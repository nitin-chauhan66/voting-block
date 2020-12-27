pragma solidity ^0.5.16;
import './Election.sol';
contract VotingContract {
   struct VotingEvents{
       uint eventId;
       string eventName;
       address smartContractId;
   }
   
   mapping(uint=>VotingEvents) public events_array;
   uint eventsCount;
   event newEventCreated (uint id);
   function addNewEvent(string calldata _name) external {
       eventsCount++;
       address admin=msg.sender;
       Election newEvent = new Election(admin);
       address e1= address (newEvent);
       events_array[eventsCount]=VotingEvents(eventsCount,_name,e1);
       emit  newEventCreated(eventsCount);
   }
   
}