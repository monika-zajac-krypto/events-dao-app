// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 * @title The main EventDAO contract
 * @dev This contract is responsible for complete event management and funding in the EventDAO
 */
contract EventDAO {
  uint256 constant INITIAL_EVENT_FUNDING_BALANCE = 0;
  uint256 constant INITIAL_VOTES_FOR_COUNT = 0;
  uint256 constant INITIAL_VOTES_AGAINST_COUNT = 0;

  enum EventStatus {
    VOTING_IN_PROGRESS,
    APPROVED,
    REJECTED
  }

  enum FundingType {
    NO_FUNDING,
    INTERNAL_FUNDING,
    EXTERNAL_FUNDING
  }

  struct Event {
    string title;
    string description;
    address proposer;
    string proposedDate;
    EventStatus status;
    FundingType fundingType;
    uint256 fundingBalance;
    uint256 votesForCount;
    uint256 votesAgainstCount;
  }

  event SignedUp(address attendee, uint256 eventIndex);
  event Vote(address voter, uint256 eventIndex, bool supportsOrNot);
  event VotingSettlement(uint256 eventIndex, EventStatus result);
  event JoinedDAO(address newMember);

  uint256 private requiredVotesCountForSettlement;
  string private daoName;
  Event[] private events;
  mapping(uint256 => address[]) private atttendies;
  mapping(address => bool) private daoMembers;

  constructor(string memory _daoName, uint256 _requiredVotesCountForSettlement)
  {
    daoName = _daoName;
    requiredVotesCountForSettlement = _requiredVotesCountForSettlement;
  }

  /**
   * @dev This function registers a new event in the DAO registry
   * and automatically starts voting for it
   * @param title Title of the proposed event
   * @param description Description of the proposed event
   * @param proposedDate Date of the proposed event
   * @param fundingType Funding type of the proposed event (currently ignored)
   */
  function proposeEvent(
    string memory title,
    string memory description,
    string memory proposedDate,
    FundingType fundingType
  ) external {
    events.push(
      Event(
        title,
        description,
        msg.sender,
        proposedDate,
        EventStatus.VOTING_IN_PROGRESS,
        fundingType,
        INITIAL_EVENT_FUNDING_BALANCE,
        INITIAL_VOTES_FOR_COUNT,
        INITIAL_VOTES_AGAINST_COUNT
      )
    );
  }

  /**
   * @dev This function is called by a voter for a given event
   * Event is identified by index in the events array.
   * This function also automaticallt settles up the voting if
   * enough votes received
   * @param eventIndex Index of the event
   * @param supportsOrNot Vote type
   */
  function vote(uint256 eventIndex, bool supportsOrNot)
    external
    onlyDaoMember
    cannotVoteTwiceForTheSameEvent(eventIndex)
  {
    Event storage _event = events[eventIndex];
    require(
      _event.status == EventStatus.VOTING_IN_PROGRESS,
      "Voting is already finished"
    );

    if (supportsOrNot) {
      _event.votesForCount++;
    } else {
      _event.votesAgainstCount++;
    }

    emit Vote(msg.sender, eventIndex, supportsOrNot);

    // If enough votes received - we settle up the voting
    uint256 totalVotesForEvent = _event.votesForCount +
      _event.votesAgainstCount;
    if (totalVotesForEvent >= requiredVotesCountForSettlement) {
      _event.status = _event.votesForCount >= _event.votesAgainstCount
        ? EventStatus.APPROVED
        : EventStatus.REJECTED;
      emit VotingSettlement(eventIndex, _event.status);
    }
  }

  /**
   * @dev Currently this function simply allows anyone to join the given DAO
   * In future we can implement additional requirements for joining the DAO, e.g.:
   * - Having some special NFTs
   * - Staking some amount of some tokens
   * - Passing a decentralized KYC process
   * - Or anything else...
   */
  function joinDAO() external {
    daoMembers[msg.sender] = true;
    emit JoinedDAO(msg.sender);
  }

  /**
   * @dev This function checks funding type of the gived event and allows to
   * Increase the event balance
   * @param eventIndex Index of the event
   */
  function fundEvent(uint256 eventIndex) external payable {
    Event storage _event = events[eventIndex];
    require(
      _event.status == EventStatus.APPROVED,
      "Only approved event can be funded"
    );
    require(
      _event.fundingType != FundingType.NO_FUNDING,
      "Funding is not enabled for this event"
    );
    require(
      _event.fundingType == FundingType.EXTERNAL_FUNDING ||
        isMemberOfThisDAO(msg.sender),
      "Only DAO members can fund this event"
    );
    _event.fundingBalance += msg.value;
  }

  /**
   * @dev Function to withdraw all collected funds for the given event
   * It can be called only by the vent proposer
   * @param eventIndex Index of the event
   */
  function withdraw(uint256 eventIndex) external payable {
    Event storage _event = events[eventIndex];
    require(_event.proposer == msg.sender);
    uint256 balanceToWithdraw = _event.fundingBalance;
    _event.fundingBalance = 0;
    payable(msg.sender).transfer(balanceToWithdraw);
  }

  /**
   * @dev Function to sign up to the event
   * Can be called by anyone
   * @param eventIndex Index of the event
   */
  function signUpForEvent(uint256 eventIndex) external {
    Event storage _event = events[eventIndex];
    require(_event.status == EventStatus.APPROVED);
    emit SignedUp(msg.sender, eventIndex);
  }

  function getAllEvents() public view returns (Event[] memory) {
    return events;
  }

  function isMemberOfThisDAO(address addr) public view returns (bool) {
    return daoMembers[addr];
  }

  modifier onlyDaoMember() {
    // Code below commented to make the demo smoother
    // require(isMemberOfThisDAO(msg.sender), "Tx sender Must be a DAO member");
    _;
  }

  // The modifier below will be implemented in future
  modifier cannotVoteTwiceForTheSameEvent(uint256 _eventIndex) {
    _;
  }
}
