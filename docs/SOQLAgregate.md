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

### `SOQLAgregate(queryString)`

`TESTVISIBLE`

#### Signature

```apex
private SOQLAgregate(String queryString)
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

### `getAggregateResults()`

#### Signature

```apex
public List<AggregateResult> getAggregateResults()
```

#### Return Type

**List&lt;AggregateResult&gt;**

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

##### `groupByOptions`

`TESTVISIBLE`

###### Signature

```apex
private groupByOptions
```

###### Type

Set&lt;String&gt;

---

##### `groupByRollupOptions`

`TESTVISIBLE`

###### Signature

```apex
private groupByRollupOptions
```

###### Type

Set&lt;String&gt;

---

##### `groupByCubeOptions`

`TESTVISIBLE`

###### Signature

```apex
private groupByCubeOptions
```

###### Type

Set&lt;String&gt;

---

##### `havingCondition`

`TESTVISIBLE`

###### Signature

```apex
private havingCondition
```

###### Type

Query.Condition

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

##### `average(fieldName)`

###### Signature

```apex
public Builder average(String fieldName)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |

###### Return Type

**Builder**

---

##### `average(fieldName, alias)`

###### Signature

```apex
public Builder average(String fieldName, String alias)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| alias     | String |             |

###### Return Type

**Builder**

---

##### `count(fieldName)`

###### Signature

```apex
public Builder count(String fieldName)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |

###### Return Type

**Builder**

---

##### `count(fieldName, alias)`

###### Signature

```apex
public Builder count(String fieldName, String alias)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| alias     | String |             |

###### Return Type

**Builder**

---

##### `countDistinct(fieldName)`

###### Signature

```apex
public Builder countDistinct(String fieldName)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |

###### Return Type

**Builder**

---

##### `countDistinct(fieldName, alias)`

###### Signature

```apex
public Builder countDistinct(String fieldName, String alias)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| alias     | String |             |

###### Return Type

**Builder**

---

##### `minimum(fieldName)`

###### Signature

```apex
public Builder minimum(String fieldName)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |

###### Return Type

**Builder**

---

##### `minimum(fieldName, alias)`

###### Signature

```apex
public Builder minimum(String fieldName, String alias)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| alias     | String |             |

###### Return Type

**Builder**

---

##### `maximum(fieldName)`

###### Signature

```apex
public Builder maximum(String fieldName)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |

###### Return Type

**Builder**

---

##### `maximum(fieldName, alias)`

###### Signature

```apex
public Builder maximum(String fieldName, String alias)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| alias     | String |             |

###### Return Type

**Builder**

---

##### `sum(fieldName)`

###### Signature

```apex
public Builder sum(String fieldName)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |

###### Return Type

**Builder**

---

##### `sum(fieldName, alias)`

###### Signature

```apex
public Builder sum(String fieldName, String alias)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| alias     | String |             |

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

##### `groupBy(fieldName)`

###### Signature

```apex
public Builder groupBy(String fieldName)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |

###### Return Type

**Builder**

---

##### `groupByRollup(fieldName)`

###### Signature

```apex
public Builder groupByRollup(String fieldName)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |

###### Return Type

**Builder**

---

##### `groupByRollup(fieldName, groupingAlias)`

###### Signature

```apex
public Builder groupByRollup(String fieldName, String groupingAlias)
```

###### Parameters

| Name          | Type   | Description |
| ------------- | ------ | ----------- |
| fieldName     | String |             |
| groupingAlias | String |             |

###### Return Type

**Builder**

---

##### `groupByCube(fieldName)`

###### Signature

```apex
public Builder groupByCube(String fieldName)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |

###### Return Type

**Builder**

---

##### `groupByCube(fieldName, groupingAlias)`

###### Signature

```apex
public Builder groupByCube(String fieldName, String groupingAlias)
```

###### Parameters

| Name          | Type   | Description |
| ------------- | ------ | ----------- |
| fieldName     | String |             |
| groupingAlias | String |             |

###### Return Type

**Builder**

---

##### `havingCondition(condition)`

###### Signature

```apex
public Builder havingCondition(Query.Condition condition)
```

###### Parameters

| Name      | Type            | Description |
| --------- | --------------- | ----------- |
| condition | Query.Condition |             |

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

##### `scopeLimit(numberOfRows)`

###### Signature

```apex
public Builder scopeLimit(Integer numberOfRows)
```

###### Parameters

| Name         | Type    | Description |
| ------------ | ------- | ----------- |
| numberOfRows | Integer |             |

###### Return Type

**Builder**

---

##### `offset(offset)`

###### Signature

```apex
public Builder offset(Integer offset)
```

###### Parameters

| Name   | Type    | Description |
| ------ | ------- | ----------- |
| offset | Integer |             |

###### Return Type

**Builder**

---

##### `build()`

###### Signature

```apex
public SOQLAgregate build()
```

###### Return Type

**[SOQLAgregate](SOQLAgregate.md)**

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

##### `addGroupByStatement(queryStatements)`

###### Signature

```apex
private void addGroupByStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addHavingStatement(queryStatements)`

###### Signature

```apex
private void addHavingStatement(List<String> queryStatements)
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
