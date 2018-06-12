<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Line_Invoiced_Value</fullName>
        <description>Update the invoice value</description>
        <field>Already_Invoiced__c</field>
        <formula>If(Already_Invoiced__c &lt;&gt; 0,
Invoice_Value__c + Already_Invoiced__c,
Invoice_Value__c)</formula>
        <name>Update Line Invoiced Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Short_Description</fullName>
        <field>Line_Description__c</field>
        <formula>Left( Line_Description_Long__c ,255)</formula>
        <name>Update Short Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Line Invoiced Value</fullName>
        <actions>
            <name>Update_Line_Invoiced_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Billing_Items__c.Status__c</field>
            <operation>equals</operation>
            <value>To Be Invoiced</value>
        </criteriaItems>
        <criteriaItems>
            <field>Billing_Items__c.Invoice_Value_Remaining__c</field>
            <operation>notEqual</operation>
            <value>0</value>
        </criteriaItems>
        <description>Updates the value that has already been invoiced against a line item</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Short Description</fullName>
        <actions>
            <name>Update_Short_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Short Description with the Long Description for conversion to Actions</description>
        <formula>Or(Isnew(), ischanged( Line_Description_Long__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
