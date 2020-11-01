pragma solidity >=0.4.22 <0.8.0;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Model a User
    struct User {
        uint uid;
        string name;
        bool isVoted;
        string aadhar;
        string location;
        uint pinCode;
    }
    // Store users
    mapping (uint => User) public users;
    uint public usersCount;
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

    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
        addCandidate("Candidate 3");
    }
    function addUser (uint uid,string memory _name, bool _isVoted, string memory _aadhar, string memory _location,uint  _pinCode) private {
        usersCount++;
        users[usersCount] = User(uid,_name,_isVoted,_aadhar,_location,_pinCode);
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
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