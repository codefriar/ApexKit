`APIVERSION: 58`

`STATUS: ACTIVE`

class exists as a namespace for 'org-wide' default values on common SObjects.
Each inner class represents one type of SObject and implements the SObjectFactory.FieldDefaults interface.
That interface dictates a map of SOBjectField =&gt; Object. SObjectFactory will apply these org-wide defaults
as it constructs your test object(s)

## Classes

### AccountDefaults

org-wide account defaults.

**Implemented types**

[SObjectFactory.FieldDefaults](SObjectFactory.FieldDefaults)

#### Methods

##### `public Map&lt;Schema.SObjectField,Object&gt; getFieldDefaults()`

Interface required method returning default values for fields

###### Returns

| Type                                    | Description                                                             |
| --------------------------------------- | ----------------------------------------------------------------------- |
| `Map&lt;Schema.SObjectField,Object&gt;` | Map&lt;Schema.SObjectField, Object&gt; map of fields and default values |

---

### CaseDefaults

org-wide case default values

**Implemented types**

[SObjectFactory.FieldDefaults](SObjectFactory.FieldDefaults)

#### Methods

##### `public Map&lt;Schema.SObjectField,Object&gt; getFieldDefaults()`

Interface required method returning default values for fields

###### Returns

| Type                                    | Description                                                             |
| --------------------------------------- | ----------------------------------------------------------------------- |
| `Map&lt;Schema.SObjectField,Object&gt;` | Map&lt;Schema.SObjectField, Object&gt; map of fields and default values |

---

### ContactDefaults

org-wide contact defaults

**Implemented types**

[SObjectFactory.FieldDefaults](SObjectFactory.FieldDefaults)

#### Methods

##### `public Map&lt;Schema.SObjectField,Object&gt; getFieldDefaults()`

Interface required method returning default values for fields

###### Returns

| Type                                    | Description                                                             |
| --------------------------------------- | ----------------------------------------------------------------------- |
| `Map&lt;Schema.SObjectField,Object&gt;` | Map&lt;Schema.SObjectField, Object&gt; map of fields and default values |

---

### OpportunityDefaults

org-wide opportunity defaults

**Implemented types**

[SObjectFactory.FieldDefaults](SObjectFactory.FieldDefaults)

#### Methods

##### `public Map&lt;Schema.SObjectField,Object&gt; getFieldDefaults()`

Interface required method returning default values for fields

###### Returns

| Type                                    | Description                                                             |
| --------------------------------------- | ----------------------------------------------------------------------- |
| `Map&lt;Schema.SObjectField,Object&gt;` | Map&lt;Schema.SObjectField, Object&gt; map of fields and default values |

---

---
