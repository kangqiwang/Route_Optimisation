<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Action_to_specified_email_address</fullName>
        <description>Email Action to specified email address</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Action__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>ServiceTracker/Email_Action_to_specified_email_address</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Date</fullName>
        <description>Updates the Complete Date of the Action when the status is Complete</description>
        <field>Actual_Completion__c</field>
        <formula>TODAY()</formula>
        <name>Update Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Email Action</fullName>
        <actions>
            <name>Email_Action_to_specified_email_address</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Actions__c.Email_Action__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Emails the action to the specified email address</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Date</fullName>
        <actions>
            <name>Update_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Actions__c.Status__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>Actions__c.Actual_Completion__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates the Date of the Action when Complete</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
