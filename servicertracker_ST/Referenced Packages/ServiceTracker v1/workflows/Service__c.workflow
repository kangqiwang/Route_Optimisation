<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_New_Schedule_to_False</fullName>
        <field>Create_New_Schedule__c</field>
        <literalValue>0</literalValue>
        <name>Set New Schedule to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Range_Selected</fullName>
        <field>Number_of_Range_Selected__c</field>
        <formula>Range_Selected__c</formula>
        <name>Update Range Selected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Schedule_Short_Notes</fullName>
        <field>Notes__c</field>
        <formula>LEFT(Notes_Long__c, 250)</formula>
        <name>Update Schedule Short Notes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Schedule_to_Inactive</fullName>
        <field>Status__c</field>
        <literalValue>Inactive</literalValue>
        <name>Update Schedule to Inactive</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set New Schedule to False</fullName>
        <actions>
            <name>Set_New_Schedule_to_False</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Range_Selected</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Service__c.Create_New_Schedule__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Sets the Create New Schedule field to false after update</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Number of Range Selected</fullName>
        <actions>
            <name>Update_Range_Selected</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Service__c.Range_Selected__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the schedule range</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Schedule Short Notes</fullName>
        <actions>
            <name>Update_Schedule_Short_Notes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the short notes of a schedule with the first 255 characters of the long notes for reporting and view purposes</description>
        <formula>OR(  ISNEW(),  ISCHANGED( Notes_Long__c )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status to Inactive</fullName>
        <actions>
            <name>Update_Schedule_to_Inactive</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Service__c.Next_Visit_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Service__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Complete,Inactive</value>
        </criteriaItems>
        <criteriaItems>
            <field>Service__c.Service_Type__c</field>
            <operation>equals</operation>
            <value>Contract Schedule</value>
        </criteriaItems>
        <description>Template for the Update of a schedule to inactive if there are no more visits.  This should be cloned and a time trigger added</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
