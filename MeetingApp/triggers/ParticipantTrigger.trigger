trigger ParticipantTrigger on Participant__c (after insert) {
    /*Increment the Registered_Participants__c field on the related Meeting__c object
        when a Participant__c record is inserted.
      Update the Status__c field on Meeting__c to Full when Remaining_Capacity__c equals 0.
*/
    if(Trigger.isAfter && Trigger.isInsert){
        set<id> meetingIds = new set<id>();
        for(Participant__c participant : Trigger.new){
            if(participant.meeting__c != null){
                meetingIds.add(participant.meeting__c);
            }
        }
        Map<id,Meeting__c> meetingsMap = new Map<id,Meeting__c>([select id,name,capacity__c,Registered_Participants__c,Status__c,Remaining_Capacity__c from meeting__c
                                                                  where id IN:meetingIds]);
        
        for(Meeting__c meeting :meetingsMap.values()){
            if(meeting.Registered_Participants__c ==null){
                meeting.Registered_Participants__c = 0;
            }
            meeting.Registered_Participants__c = meeting.Registered_Participants__c +1;
            
             Decimal capacity = meeting.Capacity__c;
             Decimal registered = meeting.Registered_Participants__c;
            
            if(capacity-registered == 0){
                meeting.Status__c = 'Full';
            }
        }
        update meetingsMap.values();
    }      
}