pragma solidity >=0.4.22 <0.8.0;

contract Election {
    bool public isOnGoing;
    address public admin;
    modifier OnlyAdmin() {
        require(admin==msg.sender);
        _;
    }
     modifier OnlyRuningElection() {
        require(isOnGoing==true);
        _;
    }
    event statusChanged(bool status);
    
    function changeElectionStatus(bool _status) external OnlyAdmin {
        isOnGoing=_status;
        emit statusChanged(isOnGoing);
    }
    constructor(address _admin) public {
        admin= _admin;
    }
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );
    
    //candidate event 
    event candidateAdded(uint candidateId);
    function addCandidate (string calldata _name) external OnlyAdmin {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        //Trigger the event
        emit candidateAdded(candidatesCount);
    }

    function vote (uint _candidateId) public OnlyRuningElection {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}