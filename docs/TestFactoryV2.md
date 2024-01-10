`SUPPRESSWARNINGS`

`APIVERSION: 58`

`STATUS: ACTIVE`

## Fields

### `private MEMOIZED_AUTO_NUMBER_NAME_FIELD` → `Map<Schema.SObjectType,Boolean>`

### `private NAME_FIELD_OVERRIDE_MAP` → `Map<Schema.SObjectType,Schema.SObjectField>`

While the vast majority of Salesforce objects have a Name field, some objects do not. This map allows you to override the default name field for a given object type and covers the two standard objects that do not have a name field.

---

## Methods

### `public static SObject createSObject(SObject prototype)`

### `public static SObject createSObject(SObject prototype, String usingDefaultsClassName)`

### `public static SObject createSObject(SObject prototype, String usingDefaultsClassName, Boolean forceInsert)`

### `public static List<SObject> createSObjects(SObject prototype, Integer count)`

### `public static List<SObject> createSObjects(SObject prototype, Integer count, String usingDefaultsClassName)`

### `public static List<SObject> createSObjects(SObject prototype, Integer count, String usingDefaultsClassName, Boolean forceInsert)`

### `private static String calculateNameField(SObject prototype)`

### `private static Boolean nameFieldIsAutoNumber(SObject prototype, String nameField)`

### `private static SObject applyOrgWideObjectDefaults(SObject prototype)`

### `private static SObject applyCustomDefaults(SObject prototype, String usingDefaultsClassName)`

### `private static SObject applyFieldDefaults(SObject prototype, Map<Schema.SObjectField,Object> defaults)`

---
