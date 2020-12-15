public with sharing class TestUtilities {
    public Account insertAccount(String name) {
        Account acc = new Account(Name = name);
        insert acc;
        return acc;
    }
}
