public with sharing class CustomMapComponentHelper {

    /**
     * Method to retrieve the field values of any object.
     * This method expects to receive City, Country, PostalCode, State, Street as fields
     */
    public static SObject getCountryFieldValues(String objectName, List<String> fieldNames, String recordId) {
        
        SObject value = null;
        List<String> queryParams = new List<String>();
        queryParams.addAll(fieldNames);
        queryParams.add(objectName);
        queryParams.add('\'' + recordId + '\'');
        
        String sql = String.format('SELECT {0}, {1}, {2}, {3}, {4} FROM {5} WHERE Id = {6}', queryParams);
        List<SObject> records = Database.query(sql);

        if (!records.isEmpty()) {

            value = records[0];
        }

        return value;
    }

    @AuraEnabled(cacheable=true)
    public static Object getFieldValue(String objectName, String fieldName, String recordId) {
        
        Object value = null;

        String sql = String.format('SELECT {0} FROM {1} WHERE Id = {2}', new String[] { fieldName, objectName, '\'' + recordId + '\''});

        SObject[] records = Database.query(sql);

        if (!records.isEmpty()) {

            SObject record = records[0];
            value = record.get(fieldName);
        }

        return value;
    }
}