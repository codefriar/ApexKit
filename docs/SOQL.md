MIT License

Copyright (c) 2020 Rafał Kopaczewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the &quot;Software&quot;), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Fields

### `queryString`

`TESTVISIBLE`

#### Signature

```apex
private queryString
```

#### Type

String

## Constructors

### `SOQL(queryString)`

`TESTVISIBLE`

#### Signature

```apex
private SOQL(String queryString)
```

#### Parameters

| Name        | Type   | Description |
| ----------- | ------ | ----------- |
| queryString | String |             |

## Methods

### `getQueryString()`

#### Signature

```apex
public String getQueryString()
```

#### Return Type

**String**

---

### `getRecord()`

#### Signature

```apex
public sObject getRecord()
```

#### Return Type

**sObject**

---

### `getRecords()`

#### Signature

```apex
public List<sObject> getRecords()
```

#### Return Type

**List&lt;sObject&gt;**

---

### `getQueryLocator()`

#### Signature

```apex
public Database.QueryLocator getQueryLocator()
```

#### Return Type

**Database.QueryLocator**

---

### `toString()`

#### Signature

```apex
public override String toString()
```

#### Return Type

**String**

## Classes

### Builder Class

#### Fields

##### `objectType`

`TESTVISIBLE`

###### Signature

```apex
private objectType
```

###### Type

String

---

##### `fieldsToSelect`

`TESTVISIBLE`

###### Signature

```apex
private fieldsToSelect
```

###### Type

Set&lt;String&gt;

---

##### `whereCondition`

`TESTVISIBLE`

###### Signature

```apex
private whereCondition
```

###### Type

Query.Condition

---

##### `sortOrders`

`TESTVISIBLE`

###### Signature

```apex
private sortOrders
```

###### Type

List&lt;Query.SortOrder&gt;

---

##### `numberOfRows`

`TESTVISIBLE`

###### Signature

```apex
private numberOfRows
```

###### Type

Integer

---

##### `offset`

`TESTVISIBLE`

###### Signature

```apex
private offset
```

###### Type

Integer

---

##### `typeOfClauses`

`TESTVISIBLE`

###### Signature

```apex
private typeOfClauses
```

###### Type

List&lt;Query.TypeOf&gt;

---

##### `scope`

`TESTVISIBLE`

###### Signature

```apex
private scope
```

###### Type

Query.Scope

---

##### `statementFor`

`TESTVISIBLE`

###### Signature

```apex
private statementFor
```

###### Type

Set&lt;String&gt;

---

##### `statementUpdate`

`TESTVISIBLE`

###### Signature

```apex
private statementUpdate
```

###### Type

Set&lt;String&gt;

#### Constructors

##### `Builder(objectType)`

###### Signature

```apex
public Builder(String objectType)
```

###### Parameters

| Name       | Type   | Description |
| ---------- | ------ | ----------- |
| objectType | String |             |

#### Methods

##### `selectField(fieldApiName)`

###### Signature

```apex
public Builder selectField(String fieldApiName)
```

###### Parameters

| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| fieldApiName | String |             |

###### Return Type

**Builder**

---

##### `selectFields(fieldApiNames)`

###### Signature

```apex
public Builder selectFields(List<String> fieldApiNames)
```

###### Parameters

| Name          | Type               | Description |
| ------------- | ------------------ | ----------- |
| fieldApiNames | List&lt;String&gt; |             |

###### Return Type

**Builder**

---

##### `selectFields(fieldApiNames)`

###### Signature

```apex
public Builder selectFields(Set<String> fieldApiNames)
```

###### Parameters

| Name          | Type              | Description |
| ------------- | ----------------- | ----------- |
| fieldApiNames | Set&lt;String&gt; |             |

###### Return Type

**Builder**

---

##### `selectFields(fieldSet)`

###### Signature

```apex
public Builder selectFields(Schema.FieldSet fieldSet)
```

###### Parameters

| Name     | Type            | Description |
| -------- | --------------- | ----------- |
| fieldSet | Schema.FieldSet |             |

###### Return Type

**Builder**

---

##### `selectFields(selection)`

###### Signature

```apex
public Builder selectFields(FieldSelection selection)
```

###### Parameters

| Name      | Type                                | Description |
| --------- | ----------------------------------- | ----------- |
| selection | [FieldSelection](FieldSelection.md) |             |

###### Return Type

**Builder**

---

##### `selectAll()`

###### Signature

```apex
public Builder selectAll()
```

###### Return Type

**Builder**

---

##### `selectCustom()`

###### Signature

```apex
public Builder selectCustom()
```

###### Return Type

**Builder**

---

##### `selectStandard()`

###### Signature

```apex
public Builder selectStandard()
```

###### Return Type

**Builder**

---

##### `addSubQuery(subQuery)`

###### Signature

```apex
public Builder addSubQuery(SOQL subQuery)
```

###### Parameters

| Name     | Type            | Description |
| -------- | --------------- | ----------- |
| subQuery | [SOQL](SOQL.md) |             |

###### Return Type

**Builder**

---

##### `addTypeOf(typeOfClause)`

###### Signature

```apex
public Builder addTypeOf(Query.TypeOf typeOfClause)
```

###### Parameters

| Name         | Type         | Description |
| ------------ | ------------ | ----------- |
| typeOfClause | Query.TypeOf |             |

###### Return Type

**Builder**

---

##### `whereCondition(condition)`

###### Signature

```apex
public Builder whereCondition(Query.Condition condition)
```

###### Parameters

| Name      | Type            | Description |
| --------- | --------------- | ----------- |
| condition | Query.Condition |             |

###### Return Type

**Builder**

---

##### `addScope(scope)`

###### Signature

```apex
public Builder addScope(Query.Scope scope)
```

###### Parameters

| Name  | Type        | Description |
| ----- | ----------- | ----------- |
| scope | Query.Scope |             |

###### Return Type

**Builder**

---

##### `orderBy(sortOrder)`

###### Signature

```apex
public Builder orderBy(Query.SortOrder sortOrder)
```

###### Parameters

| Name      | Type            | Description |
| --------- | --------------- | ----------- |
| sortOrder | Query.SortOrder |             |

###### Return Type

**Builder**

---

##### `setScopeLimit(numberOfRows)`

###### Signature

```apex
public Builder setScopeLimit(Integer numberOfRows)
```

###### Parameters

| Name         | Type    | Description |
| ------------ | ------- | ----------- |
| numberOfRows | Integer |             |

###### Return Type

**Builder**

---

##### `setOffset(offset)`

###### Signature

```apex
public Builder setOffset(Integer offset)
```

###### Parameters

| Name   | Type    | Description |
| ------ | ------- | ----------- |
| offset | Integer |             |

###### Return Type

**Builder**

---

##### `setForReference()`

###### Signature

```apex
public Builder setForReference()
```

###### Return Type

**Builder**

---

##### `setForUpdate()`

###### Signature

```apex
public Builder setForUpdate()
```

###### Return Type

**Builder**

---

##### `setForView()`

###### Signature

```apex
public Builder setForView()
```

###### Return Type

**Builder**

---

##### `setUpdateTracking()`

###### Signature

```apex
public Builder setUpdateTracking()
```

###### Return Type

**Builder**

---

##### `setUpdateViewStat()`

###### Signature

```apex
public Builder setUpdateViewStat()
```

###### Return Type

**Builder**

---

##### `build()`

###### Signature

```apex
public SOQL build()
```

###### Return Type

**[SOQL](SOQL.md)**

---

##### `addSelectStatement(queryStatements)`

###### Signature

```apex
private void addSelectStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addFromStatement(queryStatements)`

###### Signature

```apex
private void addFromStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addWhereStatement(queryStatements)`

###### Signature

```apex
private void addWhereStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addOrderByStatement(queryStatements)`

###### Signature

```apex
private void addOrderByStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addLimitStatement(queryStatements)`

###### Signature

```apex
private void addLimitStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addOffsetStatement(queryStatements)`

###### Signature

```apex
private void addOffsetStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addScopeStatement(queryStatements)`

###### Signature

```apex
private void addScopeStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addForStatement(queryStatements)`

###### Signature

```apex
private void addForStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addUpdateStatement(queryStatements)`

###### Signature

```apex
private void addUpdateStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**
