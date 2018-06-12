<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Sharing_Ref</fullName>
        <field>Portal_Sharing_Ref__c</field>
        <formula>Site_Contract_Portal_Ref__c</formula>
        <name>Update Sharing Ref</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Review Alert</fullName>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Service_Contract__c.Review_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Service_Contract__c.End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Send an email to the owner of the Contract when it is up for review</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Portal Ref</fullName>
        <actions>
            <name>Update_Sharing_Ref</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Service_Contract__c.Share_Via_Portal__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Service_Contract__c.Portal_Sharing_Ref__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates the portal reference on a contract/job if the Share Via Portal check box is TRUE</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Contract_Review</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please review this contract with the customer.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Service_Contract__c.Review_Date__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Contract Review</subject>
    </tasks>
</Workflow>
