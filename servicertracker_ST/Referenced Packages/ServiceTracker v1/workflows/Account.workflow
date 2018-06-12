<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Clear_Mapping_on_New</fullName>
        <field>Mapping_Status__c</field>
        <literalValue>Not Located Yet,</literalValue>
        <name>Clear Mapping on New</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Billing_City</fullName>
        <description>Update the Billing City from the Parent if the Billing Address if Blank</description>
        <field>BillingCity</field>
        <formula>If(
ParentId &lt;&gt; null,
Parent.BillingCity,
ShippingCity
)</formula>
        <name>Update Billing City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Billing_Postcode</fullName>
        <description>Update the Billing PostalCode from the Parent if the Billing Address if Blank</description>
        <field>BillingPostalCode</field>
        <formula>If(
ParentId &lt;&gt; null,
Parent.BillingPostalCode,
ShippingPostalCode
)</formula>
        <name>Update Billing Postcode</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Billing_State_Province</fullName>
        <field>BillingState</field>
        <formula>If(
ParentId &lt;&gt; null,
Parent.BillingState,
ShippingState
)</formula>
        <name>Update Billing State/Province</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Billing_Street</fullName>
        <description>Update the Billing Street from the Parent Billing Address if Blank</description>
        <field>BillingStreet</field>
        <formula>If(
ParentId &lt;&gt; null,
Parent.BillingStreet,
ShippingStreet
)</formula>
        <name>Update Billing Street</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Shipping_City</fullName>
        <description>Update the Shipping City from the Billing Address if Blank</description>
        <field>ShippingCity</field>
        <formula>BillingCity</formula>
        <name>Update Shipping City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Shipping_Postalcode</fullName>
        <description>Update the Shipping PostalCode from the Billing Address if Blank</description>
        <field>ShippingPostalCode</field>
        <formula>BillingPostalCode</formula>
        <name>Update Shipping Postalcode</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Shipping_State_Province</fullName>
        <description>Update the Shipping State/Province from the Billing Address if Blank</description>
        <field>ShippingState</field>
        <formula>BillingState</formula>
        <name>Update Shipping State/Province</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Shipping_Street</fullName>
        <description>Update the Shipping Street from the Billing Address if Blank</description>
        <field>ShippingStreet</field>
        <formula>BillingStreet</formula>
        <name>Update Shipping Street</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Clear Mapping on New</fullName>
        <actions>
            <name>Clear_Mapping_on_New</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Mapping_Status__c</field>
            <operation>equals</operation>
            <value>Located</value>
        </criteriaItems>
        <description>Clears the mapping details when an account is created or cloned</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Billing Address</fullName>
        <actions>
            <name>Update_Billing_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Billing_Postcode</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Billing_State_Province</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Billing_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.BillingStreet</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.BillingCity</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.BillingPostalCode</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.BillingState</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Update Billing Address from Parent if Blank</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Shipping Address</fullName>
        <actions>
            <name>Update_Shipping_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Shipping_Postalcode</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Shipping_State_Province</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Shipping_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.ShippingStreet</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.ShippingCity</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.ShippingPostalCode</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.ShippingPostalCode</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Update Shipping Address if Blank</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
