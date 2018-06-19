<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Create_Call_Out</fullName>
        <description>Updates the Create Call Out Checkbox on the associated item</description>
        <field>Create_Call_Out__c</field>
        <literalValue>1</literalValue>
        <name>Create Call Out</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Inspection_Item__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Create Call Out</fullName>
        <actions>
            <name>Create_Call_Out</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Remote_Monitoring__c.Create_Call_Out__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Creates a call out request from an inspection item when triggered by a remote call out</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
