public with sharing class PicklistValuesUtils {
    @AuraEnabled(Cacheable = true)
    public static Map<String, List<PicklistEntry> > getDependentPicklistValues(String dependentField) {
        Schema.sObjectField dependToken = getSObjectField(dependentField);
        Schema.DescribeFieldResult depend = dependToken.getDescribe();
        Schema.sObjectField controlToken = depend.getController();
        if (controlToken == null) {
            return new Map<String, List<PicklistEntry> >();
        }
    
        Schema.DescribeFieldResult control = controlToken.getDescribe();
        List<Schema.PicklistEntry> controlEntries;
        if(control.getType() != Schema.DisplayType.Boolean) {
            controlEntries = control.getPicklistValues();
        }
    
        String base64map = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
        Map<String, List<PicklistEntry>> dependentPicklistValues = new Map<String, List<PicklistEntry>>();
        for (Schema.PicklistEntry entry : depend.getPicklistValues()) {
            if (entry.isActive() && String.isNotEmpty(String.valueOf(((Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(entry))).get('validFor')))) {
                List<String> base64chars =
                        String.valueOf(((Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(entry))).get('validFor')).split('');
                for (Integer index = 0; index < (controlEntries != null ? controlEntries.size() : 2); index++) {
                    Object controlValue =
                            (controlEntries == null
                                    ?   (Object) (index == 1)
                                    :   (Object) (controlEntries[index].isActive() ? controlEntries[index].getValue() : null)
                            );
                    Integer bitIndex = index / 6;
                    if (bitIndex > base64chars.size() - 1) {
                        break;
                    }
                    Integer bitShift = 5 - Math.mod(index, 6);
                    if  (controlValue == null || (base64map.indexOf( base64chars[ bitIndex ] ) & (1 << bitShift)) == 0)
                        continue;
                    if (!dependentPicklistValues.containsKey((String) controlValue)) {
                        dependentPicklistValues.put((String) controlValue, new List<PicklistEntry>());
                    }

                    dependentPicklistValues.get((String) controlValue).add(new PicklistEntry(entry.getValue(), entry.getLabel()));
                }
            }
        }
        return dependentPicklistValues;
    }

    @AuraEnabled(Cacheable = true)
    public static List<PicklistEntry> getPicklistValues(String picklistField) {
        List<PicklistEntry> myPicklist = new List<PicklistEntry>();
        Schema.SObjectField sObjectField = getSObjectField(picklistField);
        Schema.DescribeFieldResult field = sObjectField.getDescribe();
    
        for (Schema.PicklistEntry f : field.getPicklistValues()) {
            myPicklist.add(new PicklistEntry(f.getValue(), f.getLabel()));
        }
    
        return myPicklist;          
    }

    /**
     * returns SObjectField from string
     * The string should be ofr example: Account.Type
     */
    @TestVisible
    private static Schema.SObjectField getSObjectField(String field) {
        List<String> splitString = field.split('\\.');
        return Schema.getGlobalDescribe().get(splitString[0]).getDescribe().fields.getMap().get(splitString[1]);
    }

    public class PicklistEntry {
        @AuraEnabled
        public String value { get; set; }
        @AuraEnabled
        public String label { get; set; }
        
        public PicklistEntry(String value, String label) {
            this.value = value;
            this.label = label;
        }
    }
}
