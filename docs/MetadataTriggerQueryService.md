MetadataTriggerHandlerClass class. It is not intended to be used directly by developers.

## Fields

### `objType`

Initialize objectTypeName as an empty string to avoid null errors

#### Signature

```apex
private objType
```

#### Type

String

## Constructors

### `MetadataTriggerQueryService(objectTypeName)`

Constructor for trigger query service

#### Signature

```apex
public MetadataTriggerQueryService(String objectTypeName)
```

#### Parameters

| Name           | Type   | Description                 |
| -------------- | ------ | --------------------------- |
| objectTypeName | String | String The object Type name |

## Methods

### `getMetadataTriggers()`

`SUPPRESSWARNINGS`

This query finds an ordered list trigger handler classes
to execute. It ignores any classes that are marked as disabled.

&lt;br&gt;Note: It will exclude any triggerHandler metadata records for which
the user&#x27;s email address is found in a related `disabled_for__mdt`
record.

&lt;br&gt;Admins and Developers can selectively disable trigger handlers
for all or selected individuals _without_ deploying.

#### Signature

```apex
public List<Metadata_Driven_Trigger__mdt> getMetadataTriggers()
```

#### Return Type

**List&lt;Metadata_Driven_Trigger\_\_mdt&gt;**

,[object Object]

---

### `getSObjectType(triggerNew, triggerOld)`

This determines the active sObject type by describing the first
record in the trigger New / Old list

#### Signature

```apex
public static String getSObjectType(List<SObject> triggerNew, List<SObject> triggerOld)
```

#### Parameters

| Name       | Type                | Description                              |
| ---------- | ------------------- | ---------------------------------------- |
| triggerNew | List&lt;SObject&gt; | List&lt;sObject&gt; The trigger.new list |
| triggerOld | List&lt;SObject&gt; | List&lt;sObject&gt; The trigger.old list |

#### Return Type

**String**

,[object Object], the ObjectType name

#### Throws

[MetadataTriggerFrameworkException](MetadataTriggerFrameworkException.md): when both triggerNew and triggerOld are null
