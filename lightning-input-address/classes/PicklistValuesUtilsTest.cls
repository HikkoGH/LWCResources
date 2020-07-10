@isTest
private with sharing class PicklistValuesUtilsTest {
    @isTest
    private static void itShouldReturnTheObjectField() {
        Schema.SObjectField expectedField = Account.Name;
        Schema.SObjectField actualField = DependantPicklistValue.getSObjectField('Account.Name');
        System.assertEquals(expectedField, actualField, 'The method did not return the sobject of the field');
    }

    @isTest
    private static void itShouldReturnDependantValues() {
        Map<String, List<DependantPicklistValue.PicklistEntry>> dependantValues = DependantPicklistValue.getDependentPicklistValues('Samples_Request__c.Ship_To_State__c');
        System.assert(!dependantValues.isEmpty(), 'The method did not return the dependant values');
    }

    @isTest
    private static void itShouldReturnPicklistValues() {
        List<DependantPicklistValue.PicklistEntry> picklistValues = DependantPicklistValue.getPicklistValues('Account.Type');
        System.assert(!picklistValues.isEmpty(), 'The method did not return the picklist values');
    }
}
