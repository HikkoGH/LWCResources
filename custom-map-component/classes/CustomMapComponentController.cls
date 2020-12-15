public with sharing class CustomMapComponentController {
    @AuraEnabled
    public static SObject getCountryFieldValues(String objectName,List<String> fieldNames, Id recordId) {
        try {
            return CustomMapComponentHelper.getCountryFieldValues(objectName, fieldNames, recordId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Object getFieldValue(String objectName, String fieldName, Id recordId) {
        try {
            return CustomMapComponentHelper.getFieldValue(objectName, fieldName, recordId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
