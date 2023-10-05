`STATUS: ACTIVE`

Class encapsulates the querying of Metadata_Driven_Trigger\_\_mdt records on behalf of the
MetadataTriggerHandlerClass class. It is not intended to be used directly by developers.

## Constructors

### `public MetadataTriggerQueryService(String objectTypeName)`

Constructor for trigger query service

#### Parameters

| Param            | Description                 |
| ---------------- | --------------------------- |
| `objectTypeName` | String The object Type name |

---

## Fields

### `private objType` → `String`

Initialize objectTypeName as an empty string to avoid null errors

---

## Methods

### `public List getMetadataTriggers()`

`SUPPRESSWARNINGS`

This query finds an ordered list trigger handler classes to execute. It ignores any classes that are marked as disabled. <br>Note: It will exclude any triggerHandler metadata records for which the user's email address is found in a related `disabled_for__mdt` record. <br>Admins and Developers can selectively disable trigger handlers for all or selected individuals _without_ deploying.

#### Returns

| Type                                 | Description                          |
| ------------------------------------ | ------------------------------------ |
| List<Metadata_Driven_Trigger\_\_mdt> | `List<Metadata_Driven_Trigger__mdt>` |

### `public static String getSObjectType(List<SObject> triggerNew, List<SObject> triggerOld)`

This determines the active sObject type by describing the first record in the trigger New / Old list

#### Parameters

| Param        | Description                        |
| ------------ | ---------------------------------- |
| `triggerNew` | List<sObject> The trigger.new list |
| `triggerOld` | List<sObject> The trigger.old list |

#### Returns

| Type   | Description                  |
| ------ | ---------------------------- |
| String | `String` the ObjectType name |

#### Throws

| Exception                           | Description                                  |
| ----------------------------------- | -------------------------------------------- |
| `MetadataTriggerFrameworkException` | when both triggerNew and triggerOld are null |

---
