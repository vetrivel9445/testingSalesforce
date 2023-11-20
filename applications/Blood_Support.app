<?xml version="1.0" encoding="UTF-8"?>
<CustomApplication xmlns="http://soap.sforce.com/2006/04/metadata">
    <brand>
        <headerColor>#FD0004</headerColor>
        <shouldOverrideOrgTheme>true</shouldOverrideOrgTheme>
    </brand>
    <description>For support blood donors</description>
    <formFactors>Small</formFactors>
    <formFactors>Large</formFactors>
    <isNavAutoTempTabsDisabled>false</isNavAutoTempTabsDisabled>
    <isNavPersonalizationDisabled>false</isNavPersonalizationDisabled>
    <isNavTabPersistenceDisabled>false</isNavTabPersistenceDisabled>
    <label>Blood Support</label>
    <navType>Standard</navType>
    <profileActionOverrides>
        <actionName>View</actionName>
        <content>blood_group</content>
        <formFactor>Large</formFactor>
        <pageOrSobjectType>Blood_Donor__c</pageOrSobjectType>
        <type>Flexipage</type>
        <profile>Standard</profile>
    </profileActionOverrides>
    <tabs>Blood_Donor__c</tabs>
    <tabs>Blood_request__c</tabs>
    <tabs>blood_coor__c</tabs>
    <tabs>Salesorder__c</tabs>
    <tabs>Feedback__c</tabs>
    <tabs>Department__c</tabs>
    <tabs>Employee__c</tabs>
    <tabs>Customer_Project__c</tabs>
    <tabs>Contact_Relationship__c</tabs>
    <tabs>Customer__c</tabs>
    <tabs>Market__c</tabs>
    <tabs>Zone__c</tabs>
    <tabs>Store__c</tabs>
    <tabs>Event__c</tabs>
    <tabs>Error_Log__c</tabs>
    <tabs>Receipt__c</tabs>
    <uiType>Lightning</uiType>
    <utilityBar>Blood_Support_UtilityBar</utilityBar>
</CustomApplication>
