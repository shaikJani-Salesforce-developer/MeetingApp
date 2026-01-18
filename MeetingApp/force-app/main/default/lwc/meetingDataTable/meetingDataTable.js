import { LightningElement, wire } from 'lwc';
import getMeetings from '@salesforce/apex/MeetingController.getMeetings';

const COLUMNS = [
    { label: 'Meeting Name', fieldName: 'Name' },
    { label: 'Meeting Date', fieldName: 'Meeting_Date__c', type: 'date' },
    { label: 'Location', fieldName: 'Location__c' },
    { label: 'Capacity', fieldName: 'Capacity__c', type: 'number' },
    { label: 'Registered Participants', fieldName: 'Registered_Participants__c', type: 'number' },
    { label: 'Remaining Capacity', fieldName: 'Remaining_Capacity__c', type: 'number' },
    { label: 'Status', fieldName: 'Status__c' }
];

export default class MeetingDataTable extends LightningElement {
    columns = COLUMNS;
    meetings;

    @wire(getMeetings)
    wiredMeetings({ data, error }) {
        if (data) {
            this.meetings = data;
        } else if (error) {
            console.error(error);
        }
    }
}
