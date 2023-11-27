// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Params {
    bool public initialized;

    // System contracts
    address
        public constant ValidatorContractAddr = 0x000000000000000000000000000000000000f000;
    address
        public constant PunishContractAddr = 0x000000000000000000000000000000000000F001;
    address
        public constant ProposalAddr = 0x000000000000000000000000000000000000F002;

    // System params
    uint16 public constant MaxValidators = 500;
    // Validator have to wait StakingLockPeriod blocks to withdraw staking
    uint64 public constant StakingLockPeriod = 20;   //86400
    // Validator have to wait WithdrawProfitPeriod blocks to withdraw his profits
    uint64 public constant WithdrawProfitPeriod = 10;    //28800
    uint256 public constant MinimalStakingCoin = 34 ether;
    // minimum initial staking to become a validator
    uint256 public constant minimumValidatorStaking = 1000000 ether;


    // percent distrubution of Gas Fee earned by validator 100000 = 100%
    uint public constant stakerPartPercent = 30000;             //30% 
    uint public constant validatorPartPercent = 60000;          //60%
    uint public constant burnPartPercent = 10000;               //10%
    uint public constant contractPartPercent = 0;               //0%
    uint public constant burnStopAmount = 100000000 ether;      // after 100,000,000 coins burn, it will stop burning
    uint public totalBurnt;



    modifier onlyMiner() {
        require(tx.origin == block.coinbase, "Miner only");
        _;
    }

    modifier onlyNotInitialized() {
        require(!initialized, "Already initialized");
        _;
    }

    modifier onlyInitialized() {
        require(initialized, "Not init yet");
        _;
    }

    modifier onlyPunishContract() {
        require(tx.origin == PunishContractAddr, "Punish contract only");
        _;
    }

    modifier onlyBlockEpoch(uint256 epoch) {
        require(block.number % epoch == 0, "Block epoch only");
        _;
    }

    modifier onlyValidatorsContract() {
        require(
            tx.origin == ValidatorContractAddr,
            "Validators contract only"
        );
        _;
    }

    modifier onlyProposalContract() {
        require(tx.origin == ProposalAddr, "Proposal contract only");
        _;
    }
}
