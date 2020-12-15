@isTest
private class CustomMapComponentTest {
    private static final String POSTAL_CODE = '100';
    private static final String STATE = 'NY';
    private static final String STREET = 'SomeTest';
    private static final String COUNTRY = 'US';
    private static final String CITY = 'NY';
    private static final String NAME = 'Test';
    
    @TestSetup
    static void makeData() {
        TestUtilities utils = new TestUtilities();
        Account acc = utils.insertAccount(NAME);
        acc.BillingPostalCode = POSTAL_CODE;
        acc.BillingState = STATE;
        acc.BillingStreet = STREET;
        acc.BillingCountry = COUNTRY;
        acc.BillingCity = CITY;
        update acc;
    }

    @isTest
    private static void itShouldGetCountryValues() {
        Account acc = [SELECT Id, Name from Account LIMIT 1];
        String objectName = 'Account';
        List<String> fields = new List<String> { 'BillingCountry', 'BillingCity', 'BillingState', 'BillingStreet', 'BillingPostalCode' };
        Id recordId = acc.Id;
        Test.startTest();
        SObject accRetrieved = CustomMapComponentController.getCountryFieldValues(objectName, fields, recordId);
        Test.stopTest();
        System.assertEquals(COUNTRY, accRetrieved.get('BillingCountry'), 'Did not get correct value');
    }

    @isTest
    private static void itShouldThrowException() {
        Account acc = [SELECT Id, Name from Account LIMIT 1];
        String objectName = 'Account';
        List<String> fields = new List<String> { 'Billing', 'BillingCity', 'BillingState', 'BillingStreet', 'BillingPostalCode' };
        Id recordId = acc.Id;
        Test.startTest();
        try {

            SObject accRetrieved = CustomMapComponentController.getCountryFieldValues(objectName, fields, recordId);
            System.assert(false, 'Did not throw an exception');
        }
        catch (Exception ex) {

            System.assert(true, 'Did not throw an exception');
        }
        Test.stopTest();
    }

    @isTest
    private static void itShouldThrowException2() {
        Account acc = [SELECT Id, Name from Account LIMIT 1];
        String objectName = 'Account';
        String field = null;
        Id recordId = acc.Id;
        Test.startTest();
        try {

            Object accRetrieved = CustomMapComponentController.getFieldValue(objectName, field, recordId);
            System.assert(false, 'Did not throw an exception');
        }
        catch (Exception ex) {

            System.assert(true, 'Did not throw an exception');
        }
        Test.stopTest();
    }

    @isTest
    private static void itShouldGetFieldValue() {
        Account acc = [SELECT Id, Name from Account LIMIT 1];
        String objectName = 'Account';
        String field = 'Name';
        Id recordId = acc.Id;

        Test.startTest();
        Object accRetrieved = CustomMapComponentController.getFieldValue(objectName, field, recordId);
        Test.stopTest();
        System.assertEquals(NAME, String.valueOf(accRetrieved), 'Did not get field value');
    }
}
