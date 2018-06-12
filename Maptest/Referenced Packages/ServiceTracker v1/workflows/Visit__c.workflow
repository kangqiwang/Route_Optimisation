<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_H_S</fullName>
        <description>Email H&amp;S</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>ServiceTracker/H_S_Reported</template>
    </alerts>
    <fieldUpdates>
        <fullName>Create_Follow_Up</fullName>
        <field>Follow_Up__c</field>
        <formula>IF(INCLUDES(Pests_Found__c,&apos;Rats&apos;),Completion_Time__c + 7,
IF(INCLUDES(Pests_Found__c,&apos;Mice&apos;),Completion_Time__c + 10,
IF(INCLUDES(Pests_Found__c,&apos;Cockroaches&apos;),Completion_Time__c + 5,null)))</formula>
        <name>Create Follow-Up</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Change</fullName>
        <description>Change the status to complete</description>
        <field>Status__c</field>
        <literalValue>Complete</literalValue>
        <name>Status Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Alert_Flag</fullName>
        <field>Alert_Sent__c</field>
        <literalValue>1</literalValue>
        <name>Update Alert Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Finish_Time</fullName>
        <description>Updates the Finish Time with the time allocation from the schedule if it is the same as the start time</description>
        <field>Due_Finish__c</field>
        <formula>Due_Date__c + (Service__r.Time_Allocation__c/1440)</formula>
        <name>Update Finish Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Follow_Up_Flag</fullName>
        <field>Follow_Up_Scheduled__c</field>
        <literalValue>1</literalValue>
        <name>Update Follow-Up Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Planned_Date</fullName>
        <field>Planned_Date__c</field>
        <formula>Due_Date__c</formula>
        <name>Update Planned Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Short_Notes</fullName>
        <field>Notes__c</field>
        <formula>LEFT(Notes_Long__c, 250)</formula>
        <name>Update Short Notes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>true</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_In_Progress</fullName>
        <field>Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Update Status to In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Visit_to_Accepted</fullName>
        <field>Status__c</field>
        <literalValue>Accepted</literalValue>
        <name>Update Visit to Accepted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Create Follow-Up</fullName>
        <actions>
            <name>Create_Follow_Up</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Visit__c.Pests_Found__c</field>
            <operation>equals</operation>
            <value>Rats</value>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Risk__c</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <description>Created a follow-up request based on certain criteria from the visit</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>H%26S Alert</fullName>
        <actions>
            <name>Email_H_S</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Visit__c.Heath_And_Safety__c</field>
            <operation>equals</operation>
            <value>Accident to report,Incident to report,Near miss to report</value>
        </criteriaItems>
        <description>Triggers a Health and Safety email alert</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Report</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Visit__c.Alert_Sent__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Completion_Time__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Template to Update the Report Sent Flag at a specific time. This should be cloned and a time trigger added</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Follow-Up Flag</fullName>
        <actions>
            <name>Update_Follow_Up_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Visit__c.Follow_Up__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Follow_Up_Scheduled__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <description>Update the follow-up flag when a follow-up has been requested</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Planned Date</fullName>
        <actions>
            <name>Update_Planned_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Visit__c.Due_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Planned_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Update the Planned date when a visit is intially created</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Short Notes</fullName>
        <actions>
            <name>Update_Short_Notes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Short Notes field from the Long Notes for reporting purposes</description>
        <formula>OR( ISNEW(), ISCHANGED( Notes_Long__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Visit__c.Completion_Time__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Arrival_Time__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the status to complete when a completion date has been added.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status to Accepted</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Visit__c.Accepted__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Accepted,In Progress,Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Arrival_Time__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Completion_Time__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates the status to Accepted when the visit has been accepted</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status to In Progress</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Visit__c.Arrival_Time__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Status__c</field>
            <operation>notEqual</operation>
            <value>In Progress,Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Completion_Time__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates the status to In Progress when the visit has been Started</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Visit End Date</fullName>
        <actions>
            <name>Update_Finish_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update the Visit End Date with the Time Allocation if it is the same or less than the start date</description>
        <formula>OR( Due_Finish__c &lt;= Due_Date__c, Due_Finish__c &gt; (Due_Date__c + (Time_Allocation__c/1440)), ISBLANK(Due_Finish__c) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
