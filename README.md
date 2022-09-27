# Events DAO app


## 1. Project Name
EventDAO

## 2. Team Name
Monika Zając

## 3. Short description of the project
EventDAO is a blockchain-based app for event organizers. Online nature of crypto projects allows them to easily grow globally. This is also the root of the problem with in-person events of many communities. For many people it is hard or even impossible to attend conferences like NFT.NYC either because of the funds or the visas needed. An app like EventDAO would help global communities organize locally. It is a great tool for both existing projects and for independent event organizers.

## 4. Long description of the project
Crypto communities are scattered all over the world, while crypto events prioritize the biggest hubs. For many people it is hard or even impossible to travel to popular crypto events destinations like the United States, not only because of the expenses, but also because of visa requirements. These people could meet locally but to organize, they need the right tools.

Event organization can be a full-time job but many enthusiasts sacrifice their own free time and sometimes even their own money to organize events for the community. Often there is more than one person responsible for organization and the questions about task management and decision making arise.

Free beer and pizza are a standard for crypto meetups but they require sponsors. Harder than finding one is agreeing to a form of settlement. Sponsors don't want to entrust their money to a single person, they want to make a donation to an organization.

EventDAO aims to solve all these problems. It will make organizing events easier and crowdfunding less messy.

DAO voting will improve decision making both in the communities, but also in the groups of independent event organizers.

Our tool also offers internal and external crowdfunding options making finance management transparent and trustless. Communities can fund their own small meetups in a coordinated manner while they can also easily manage external sponsors who prefer working with organizations rather than private people.

A proper tool for bottom-up event organization will result in more quality events wherever there are communities willing to meet.

## 5. Tech stack used (e.g. Web3 Js, Solidity, Truffle, Ipfs)
- Solidity (smart contracts)
- Hardhat (smart contracts framework)
- Javascript (main language)
- Vercel (frontend deployment)
- Figma (designs)
- Vue.js (frontend)
- Gitbook (documentation)

## 6. Payment Address (USDC on Milkomeda)
0x978e08c5fF1375b5429F7c4F18cb127b99Cb2c1C

## 7. The website link (if applicable)
https://events-dao.vercel.app/

8. Documentation on how to run the project

### Install dependencies
```sh
$ git clone https://github.com/monika-zajac-krypto/events-dao-app
$ yarn install
```

### How to deploy smart contracts on milkomeda
```sh
$ npx hardhat run scripts/deploy.js --network milkomeda
```

### Run smart contracts tests
```sh
$ yarn test
```

### Run front end app
```sh
$ yarn serve
```

Documentation on Gitbook: https://eventdao.gitbook.io/eventdao/

## 9. Recorded pitch ( please send it also to iwo@milkomeda.com)
TODO: add a link

## 10. Smart-contracts
Main smart contract for EventDAO is deployed on Milkomeda devnet at address `0x3C6B46819794e84C45A8435642174A4eA309e8e6` ([Link to the verified smart contract in the milkomeda BlockScount explorer](https://explorer-devnet-cardano-evm.c1.milkomeda.com/address/0x3C6B46819794e84C45A8435642174A4eA309e8e6/contracts#address-tabs))

Smart contracts source code is located in: [contracts/](contracts/)

### To deploy smart contracts on milkomeda:
1. Prepare .env file similar to `example.env` with your private key (env. `PRIVATE_KEY=0x123...`)
2. Run the following command `npx hardhat run scripts/deploy.js --network milkomeda`

## 11. Frontend code (if applicable)

Front-end code is located in the [src/](src/) folder.
The front-end has the following routes:
- `/` (main route)
- `/dao/:id` (selected dao view)
- `/dao/:id/members` (list of the dao members)
- `/dao/:id/votings` (votings for the dao)
- `/dao/:id/propose-event` (proposing an event form for a given dao)

The front-end app has the following components:
- AboutView.vue
- DaoMembersView.vue
- DaoView.vue
- DaoVotingsView.vue
- HomeView.vue
- ProposeEventView.vue
- UpcomingEvents.vue
- Welcome.vue
- BlockchainAddress.vue

## 12. Screens / graphic materials (optional)

### Main screen
<img width="1278" alt="Screenshot 2022-09-26 at 23 47 11" src="https://user-images.githubusercontent.com/114422762/192386629-dd39b13a-7484-4ff0-a4f7-b730928f2b9e.png">

### Selected DAO view

<img width="1278" alt="Screenshot 2022-09-26 at 23 47 45" src="https://user-images.githubusercontent.com/114422762/192386692-caf394ea-e485-4ccc-830b-0af5a075e444.png">

### Events search bar

<img width="952" alt="Screenshot 2022-09-26 at 23 48 18" src="https://user-images.githubusercontent.com/114422762/192386757-4ddb66fc-3335-426f-8aea-4d6f330e6542.png">

### DAO members list
<img width="1278" alt="Screenshot 2022-09-26 at 23 48 57" src="https://user-images.githubusercontent.com/114422762/192386844-736bdfff-02b7-4f84-be8a-2959f72840ea.png">

### Votings view
<img width="1275" alt="Screenshot 2022-09-26 at 23 49 18" src="https://user-images.githubusercontent.com/114422762/192386906-88b2069c-fc23-4fa5-9b25-3b66a1e1881b.png">

### Event proposal view
<img width="882" alt="Screenshot 2022-09-26 at 23 50 08" src="https://user-images.githubusercontent.com/114422762/192387029-fd907752-9581-4fe3-acca-a554fbbc6812.png">


- [Designs on figma](https://www.figma.com/file/zwDoAg7cs2YfrY4IMQC6B1/Milkomeda-Hackathon?node-id=0%3A1)

