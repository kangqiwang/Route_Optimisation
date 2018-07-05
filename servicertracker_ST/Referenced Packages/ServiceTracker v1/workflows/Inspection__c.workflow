<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Account_Manager</fullName>
        <description>Email Account Manager</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>ServiceTracker/Action_Account_Manager</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Result_History</fullName>
        <field>Result_History__c</field>
        <formula>RIGHT(Service_Item__r.Result_History__c,2)+
IF(OR(
ISPICKVAL(Result__c,&apos;Pass&apos;),
ISPICKVAL(Result__c,&apos;N/A&apos;),
TEXT(Result__c) = &apos;&apos;,
TEXT(Result__c) = &apos;none&apos;,
TEXT(Result__c) = &apos;null&apos;
)
,&apos;P&apos;,&apos;F&apos;)</formula>
        <name>Update Result History</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Service_Item__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Visit_Planned_Date</fullName>
        <description>Updates the Visit Planned Date from the Visit</description>
        <field>Visit_Planned_Date__c</field>
        <formula>Visit__r.Planned_Date__c</formula>
        <name>Update Visit Planned Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Inspected</fullName>
        <field>Status__c</field>
        <literalValue>Inspected</literalValue>
        <name>Update to Inspected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>schedule_for_visit_due</fullName>
        <description>changes the scheduled date to the visit due date.</description>
        <field>Inspection_Scheduled_For__c</field>
        <formula>Visit__r.Planned_Date__c</formula>
        <name>schedule for visit due</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Check the Alert</fullName>
        <actions>
            <name>Email_Account_Manager</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Inspection__c.Result__c</field>
            <operation>equals</operation>
            <value>Fail,Removed,Replacement Required,Unable to Access</value>
        </criteriaItems>
        <description>Check if there is an Action Required on the visit</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Result History</fullName>
        <actions>
            <name>Update_Result_History</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Inspection__c.Status__c</field>
            <operation>equals</operation>
            <value>Inspected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Inspection__c.Result__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the Result History field on the Inspection item when an item has been inspected. This should be cloned and a time trigger added</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status</fullName>
        <actions>
            <name>Update_to_Inspected</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Updates the Status when a Service Date has been entered.</description>
        <formula>AND( NOT(ISBLANK(Inspection_Date_Time__c)), NOT(ISPICKVAL(Status__c,&apos;Inspected&apos;)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Visit Planned Date</fullName>
        <actions>
            <name>Update_Visit_Planned_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Inspection with the Visit Planned date for reference in the Next Inspection</description>
        <formula>Visit_Planned_Date__c &lt;&gt; Visit__r.Planned_Date__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>set scheduled for date</fullName>
        <actions>
            <name>schedule_for_visit_due</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Inspection__c.Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <description>changes the scheduled for date to match the visit planned date.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
