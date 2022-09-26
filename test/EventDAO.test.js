/* eslint-disable no-undef */
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");

describe("EventDAO", function () {
  const testEventDetails = {
    title: "Test event title",
    description: "Test event description",
    proposedDate: "2022-12-12",
    fundingType: 2,
  };

  async function deployTestEventDAO() {
    const requiredVotesCountForSettlement = 3;

    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const EventDAO = await ethers.getContractFactory("EventDAO");
    const eventDAOContract = await EventDAO.deploy(
      "Test DAO",
      requiredVotesCountForSettlement
    );

    return {
      eventDAOContract,
      owner,
      otherAccount,
      requiredVotesCountForSettlement,
    };
  }

  async function proposeEvent(eventDAOContract, eventDetails) {
    const tx = await eventDAOContract.proposeEvent(
      eventDetails.title,
      eventDetails.description,
      eventDetails.proposedDate,
      eventDetails.fundingType
    );
    await tx.wait();
  }

  it("Should propose an event", async function () {
    const { eventDAOContract } = await loadFixture(deployTestEventDAO);

    await proposeEvent(eventDAOContract, testEventDetails);

    const allEvents = await eventDAOContract.getAllEvents();
    expect(allEvents.length).to.equal(1);
    expect(allEvents[0].title).to.equal(testEventDetails.title);
    expect(allEvents[0].description).to.equal(testEventDetails.description);
  });

  it("Should vote for event", async function () {
    const { eventDAOContract, requiredVotesCountForSettlement } =
      await loadFixture(deployTestEventDAO);

    await proposeEvent(eventDAOContract, testEventDetails);
    for (let i = 0; i < requiredVotesCountForSettlement; i++) {
      const tx = await eventDAOContract.vote(0, true);
      await tx.wait();
    }

    await expect(eventDAOContract.vote(0, true)).to.be.revertedWith(
      "Voting is already finished"
    );

    const allEvents = await eventDAOContract.getAllEvents();
    expect(allEvents.length).to.equal(1);
    expect(allEvents[0].status).to.equal(1); // Approved
  });

  it("Should not fund unapproved event or an event with disabled funding", async function () {
    const { eventDAOContract, requiredVotesCountForSettlement } =
      await loadFixture(deployTestEventDAO);

    await proposeEvent(eventDAOContract, {
      ...testEventDetails,
      fundingType: 0,
    });

    await expect(
      eventDAOContract.fundEvent(0, { value: 1000 })
    ).to.be.revertedWith("Only approved event can be funded");

    for (let i = 0; i < requiredVotesCountForSettlement; i++) {
      const tx = await eventDAOContract.vote(0, true);
      await tx.wait();
    }

    await expect(
      eventDAOContract.fundEvent(0, { value: 1000 })
    ).to.be.revertedWith("Funding is not enabled for this event");
  });

  it("Should fund event", async function () {
    const { eventDAOContract, requiredVotesCountForSettlement } =
      await loadFixture(deployTestEventDAO);

    await proposeEvent(eventDAOContract, testEventDetails);

    for (let i = 0; i < requiredVotesCountForSettlement; i++) {
      const tx = await eventDAOContract.vote(0, true);
      await tx.wait();
    }

    const tx = await eventDAOContract.fundEvent(0, { value: 1000 });
    await tx.wait();

    const allEvents = await eventDAOContract.getAllEvents();
    expect(allEvents.length).to.equal(1);
    expect(allEvents[0].fundingBalance).to.equal(1000);
  });

  it("Should sign up for event", async function () {
    const { eventDAOContract, requiredVotesCountForSettlement, owner } =
      await loadFixture(deployTestEventDAO);

    await proposeEvent(eventDAOContract, testEventDetails);

    for (let i = 0; i < requiredVotesCountForSettlement; i++) {
      const tx = await eventDAOContract.vote(0, true);
      await tx.wait();
    }

    const tx = await eventDAOContract.signUpForEvent(0);
    const receipt = await tx.wait();
    const event = receipt.events[0];

    expect(receipt.events.length).to.be.equal(1);
    expect(event.args.eventIndex).to.be.equal(0);
    expect(event.args.attendee).to.be.equal(owner.address);
    expect(event.event).to.be.equal("SignedUp");
  });
});
