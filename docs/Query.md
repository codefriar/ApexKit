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

## Classes

### SortOrder Class

Class encompassing the soql sorting information

#### Fields

##### `fieldname`

`TESTVISIBLE`

###### Signature

```apex
private fieldname
```

###### Type

String

---

##### `direction`

`TESTVISIBLE`

###### Signature

```apex
private direction
```

###### Type

SortDirection

---

##### `nullRecords`

`TESTVISIBLE`

###### Signature

```apex
private nullRecords
```

###### Type

SortNullRecords

#### Constructors

##### `SortOrder(fieldName)`

###### Signature

```apex
public SortOrder(String fieldName)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |

---

##### `SortOrder(fieldName, direction)`

###### Signature

```apex
public SortOrder(String fieldName, SortDirection direction)
```

###### Parameters

| Name      | Type          | Description |
| --------- | ------------- | ----------- |
| fieldName | String        |             |
| direction | SortDirection |             |

---

##### `SortOrder(fieldName, direction, nullRecords)`

###### Signature

```apex
public SortOrder(String fieldName, SortDirection direction, SortNullRecords nullRecords)
```

###### Parameters

| Name        | Type            | Description |
| ----------- | --------------- | ----------- |
| fieldName   | String          |             |
| direction   | SortDirection   |             |
| nullRecords | SortNullRecords |             |

#### Methods

##### `toSortOrderString()`

###### Signature

```apex
public String toSortOrderString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### Condition Class

#### Fields

##### `logicalOperator`

`TESTVISIBLE`

###### Signature

```apex
private logicalOperator
```

###### Type

LogicalOperator

---

##### `expressions`

`TESTVISIBLE`

###### Signature

```apex
private expressions
```

###### Type

List&lt;Expression&gt;

#### Constructors

##### `Condition()`

###### Signature

```apex
public Condition()
```

---

##### `Condition(logicalOperator)`

###### Signature

```apex
public Condition(LogicalOperator logicalOperator)
```

###### Parameters

| Name            | Type            | Description |
| --------------- | --------------- | ----------- |
| logicalOperator | LogicalOperator |             |

#### Methods

##### `equals(fieldName, value)`

###### Signature

```apex
public Condition equals(String fieldName, Object value)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| value     | Object |             |

###### Return Type

**Condition**

---

##### `notEquals(fieldName, value)`

###### Signature

```apex
public Condition notEquals(String fieldName, Object value)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| value     | Object |             |

###### Return Type

**Condition**

---

##### `lessThan(fieldName, value)`

###### Signature

```apex
public Condition lessThan(String fieldName, Object value)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| value     | Object |             |

###### Return Type

**Condition**

---

##### `lessOrEqual(fieldName, value)`

###### Signature

```apex
public Condition lessOrEqual(String fieldName, Object value)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| value     | Object |             |

###### Return Type

**Condition**

---

##### `greaterThan(fieldName, value)`

###### Signature

```apex
public Condition greaterThan(String fieldName, Object value)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| value     | Object |             |

###### Return Type

**Condition**

---

##### `greaterOrEqual(fieldName, value)`

###### Signature

```apex
public Condition greaterOrEqual(String fieldName, Object value)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| value     | Object |             |

###### Return Type

**Condition**

---

##### `isLike(fieldName, value)`

###### Signature

```apex
public Condition isLike(String fieldName, Object value)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| value     | Object |             |

###### Return Type

**Condition**

---

##### `isIn(fieldName, value)`

###### Signature

```apex
public Condition isIn(String fieldName, Object value)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| value     | Object |             |

###### Return Type

**Condition**

---

##### `isNotIn(fieldName, value)`

###### Signature

```apex
public Condition isNotIn(String fieldName, Object value)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| fieldName | String |             |
| value     | Object |             |

###### Return Type

**Condition**

---

##### `includes(fieldName, value)`

###### Signature

```apex
public Condition includes(String fieldName, Set<Set<String>> value)
```

###### Parameters

| Name      | Type                         | Description |
| --------- | ---------------------------- | ----------- |
| fieldName | String                       |             |
| value     | Set&lt;Set&lt;String&gt;&gt; |             |

###### Return Type

**Condition**

---

##### `includes(fieldName, value)`

###### Signature

```apex
public Condition includes(String fieldName, Set<String> value)
```

###### Parameters

| Name      | Type              | Description |
| --------- | ----------------- | ----------- |
| fieldName | String            |             |
| value     | Set&lt;String&gt; |             |

###### Return Type

**Condition**

---

##### `excludes(fieldName, value)`

###### Signature

```apex
public Condition excludes(String fieldName, Set<Set<String>> value)
```

###### Parameters

| Name      | Type                         | Description |
| --------- | ---------------------------- | ----------- |
| fieldName | String                       |             |
| value     | Set&lt;Set&lt;String&gt;&gt; |             |

###### Return Type

**Condition**

---

##### `excludes(fieldName, value)`

###### Signature

```apex
public Condition excludes(String fieldName, Set<String> value)
```

###### Parameters

| Name      | Type              | Description |
| --------- | ----------------- | ----------- |
| fieldName | String            |             |
| value     | Set&lt;String&gt; |             |

###### Return Type

**Condition**

---

##### `subcondition(condition)`

###### Signature

```apex
public Condition subcondition(Condition condition)
```

###### Parameters

| Name      | Type      | Description |
| --------- | --------- | ----------- |
| condition | Condition |             |

###### Return Type

**Condition**

---

##### `negateSubcondition(condition)`

###### Signature

```apex
public Condition negateSubcondition(Condition condition)
```

###### Parameters

| Name      | Type      | Description |
| --------- | --------- | ----------- |
| condition | Condition |             |

###### Return Type

**Condition**

---

##### `toConditionString()`

###### Signature

```apex
public String toConditionString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### DateLiteral Class

#### Fields

##### `dateLiteralName`

`TESTVISIBLE`

###### Signature

```apex
private dateLiteralName
```

###### Type

String

---

##### `numberOfUnits`

`TESTVISIBLE`

###### Signature

```apex
private numberOfUnits
```

###### Type

Integer

#### Constructors

##### `DateLiteral(dateLiteralName)`

###### Signature

```apex
public DateLiteral(String dateLiteralName)
```

###### Parameters

| Name            | Type   | Description |
| --------------- | ------ | ----------- |
| dateLiteralName | String |             |

---

##### `DateLiteral(dateLiteralName, numberOfUnits)`

###### Signature

```apex
public DateLiteral(String dateLiteralName, Integer numberOfUnits)
```

###### Parameters

| Name            | Type    | Description |
| --------------- | ------- | ----------- |
| dateLiteralName | String  |             |
| numberOfUnits   | Integer |             |

#### Methods

##### `toDateLiteralString()`

###### Signature

```apex
public String toDateLiteralString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### ScriptVariable Class

#### Fields

##### `variableName`

`TESTVISIBLE`

###### Signature

```apex
private variableName
```

###### Type

String

#### Constructors

##### `ScriptVariable(variableName)`

###### Signature

```apex
public ScriptVariable(String variableName)
```

###### Parameters

| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| variableName | String |             |

#### Methods

##### `toScriptVariableString()`

###### Signature

```apex
public String toScriptVariableString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### TypeOf Class

#### Fields

##### `polymorphicReference`

`TESTVISIBLE`

###### Signature

```apex
private polymorphicReference
```

###### Type

String

---

##### `sobjectType2FieldList`

`TESTVISIBLE`

###### Signature

```apex
private sobjectType2FieldList
```

###### Type

Map&lt;String,Set&lt;String&gt;&gt;

---

##### `elseFieldList`

`TESTVISIBLE`

###### Signature

```apex
private elseFieldList
```

###### Type

Set&lt;String&gt;

#### Constructors

##### `TypeOf(polymorphicReference)`

###### Signature

```apex
public TypeOf(String polymorphicReference)
```

###### Parameters

| Name                 | Type   | Description |
| -------------------- | ------ | ----------- |
| polymorphicReference | String |             |

#### Methods

##### `whenSObjectType(sobjectType, whenFieldList)`

###### Signature

```apex
public TypeOf whenSObjectType(String sobjectType, Set<String> whenFieldList)
```

###### Parameters

| Name          | Type              | Description |
| ------------- | ----------------- | ----------- |
| sobjectType   | String            |             |
| whenFieldList | Set&lt;String&gt; |             |

###### Return Type

**TypeOf**

---

##### `whenSObjectType(sobjectType, whenFieldList)`

###### Signature

```apex
public TypeOf whenSObjectType(String sobjectType, List<String> whenFieldList)
```

###### Parameters

| Name          | Type               | Description |
| ------------- | ------------------ | ----------- |
| sobjectType   | String             |             |
| whenFieldList | List&lt;String&gt; |             |

###### Return Type

**TypeOf**

---

##### `elseFieldList(elseFieldList)`

###### Signature

```apex
public TypeOf elseFieldList(Set<String> elseFieldList)
```

###### Parameters

| Name          | Type              | Description |
| ------------- | ----------------- | ----------- |
| elseFieldList | Set&lt;String&gt; |             |

###### Return Type

**TypeOf**

---

##### `elseFieldList(elseFieldList)`

###### Signature

```apex
public TypeOf elseFieldList(List<String> elseFieldList)
```

###### Parameters

| Name          | Type               | Description |
| ------------- | ------------------ | ----------- |
| elseFieldList | List&lt;String&gt; |             |

###### Return Type

**TypeOf**

---

##### `elseFieldList(elseField)`

###### Signature

```apex
public TypeOf elseFieldList(String elseField)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| elseField | String |             |

###### Return Type

**TypeOf**

---

##### `toTypeOfString()`

###### Signature

```apex
public String toTypeOfString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### SearchCondition Class

#### Fields

##### `logicalOperator`

`TESTVISIBLE`

###### Signature

```apex
private logicalOperator
```

###### Type

LogicalOperator

---

##### `searchExpressions`

`TESTVISIBLE`

###### Signature

```apex
private searchExpressions
```

###### Type

List&lt;Expression&gt;

#### Constructors

##### `SearchCondition()`

###### Signature

```apex
public SearchCondition()
```

---

##### `SearchCondition(logicalOperator)`

###### Signature

```apex
public SearchCondition(LogicalOperator logicalOperator)
```

###### Parameters

| Name            | Type            | Description |
| --------------- | --------------- | ----------- |
| logicalOperator | LogicalOperator |             |

#### Methods

##### `find(searchPhrase)`

###### Signature

```apex
public SearchCondition find(String searchPhrase)
```

###### Parameters

| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| searchPhrase | String |             |

###### Return Type

**SearchCondition**

---

##### `subSearchCondition(searchCondition)`

###### Signature

```apex
public SearchCondition subSearchCondition(SearchCondition searchCondition)
```

###### Parameters

| Name            | Type            | Description |
| --------------- | --------------- | ----------- |
| searchCondition | SearchCondition |             |

###### Return Type

**SearchCondition**

---

##### `negateSubSearchCondition(searchCondition)`

###### Signature

```apex
public SearchCondition negateSubSearchCondition(SearchCondition searchCondition)
```

###### Parameters

| Name            | Type            | Description |
| --------------- | --------------- | ----------- |
| searchCondition | SearchCondition |             |

###### Return Type

**SearchCondition**

---

##### `toConditionString()`

###### Signature

```apex
public String toConditionString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### ReturningFieldSpec Class

#### Fields

##### `objectTypeName`

`TESTVISIBLE`

###### Signature

```apex
private objectTypeName
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

##### `listViewName`

`TESTVISIBLE`

###### Signature

```apex
private listViewName
```

###### Type

String

---

##### `whereCondition`

`TESTVISIBLE`

###### Signature

```apex
private whereCondition
```

###### Type

Condition

---

##### `sortOrders`

`TESTVISIBLE`

###### Signature

```apex
private sortOrders
```

###### Type

List&lt;SortOrder&gt;

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

#### Constructors

##### `ReturningFieldSpec(sobjectType)`

###### Signature

```apex
public ReturningFieldSpec(SObjectType sobjectType)
```

###### Parameters

| Name        | Type        | Description |
| ----------- | ----------- | ----------- |
| sobjectType | SObjectType |             |

---

##### `ReturningFieldSpec(objectTypeName)`

###### Signature

```apex
public ReturningFieldSpec(String objectTypeName)
```

###### Parameters

| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| objectTypeName | String |             |

#### Methods

##### `selectField(fieldApiName)`

###### Signature

```apex
public ReturningFieldSpec selectField(String fieldApiName)
```

###### Parameters

| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| fieldApiName | String |             |

###### Return Type

**ReturningFieldSpec**

---

##### `selectFields(fieldApiNames)`

###### Signature

```apex
public ReturningFieldSpec selectFields(List<String> fieldApiNames)
```

###### Parameters

| Name          | Type               | Description |
| ------------- | ------------------ | ----------- |
| fieldApiNames | List&lt;String&gt; |             |

###### Return Type

**ReturningFieldSpec**

---

##### `selectFields(fieldApiNames)`

###### Signature

```apex
public ReturningFieldSpec selectFields(Set<String> fieldApiNames)
```

###### Parameters

| Name          | Type              | Description |
| ------------- | ----------------- | ----------- |
| fieldApiNames | Set&lt;String&gt; |             |

###### Return Type

**ReturningFieldSpec**

---

##### `selectFields(fieldSet)`

###### Signature

```apex
public ReturningFieldSpec selectFields(Schema.FieldSet fieldSet)
```

###### Parameters

| Name     | Type            | Description |
| -------- | --------------- | ----------- |
| fieldSet | Schema.FieldSet |             |

###### Return Type

**ReturningFieldSpec**

---

##### `usingListView(listViewName)`

###### Signature

```apex
public ReturningFieldSpec usingListView(String listViewName)
```

###### Parameters

| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| listViewName | String |             |

###### Return Type

**ReturningFieldSpec**

---

##### `whereCondition(condition)`

###### Signature

```apex
public ReturningFieldSpec whereCondition(Condition condition)
```

###### Parameters

| Name      | Type      | Description |
| --------- | --------- | ----------- |
| condition | Condition |             |

###### Return Type

**ReturningFieldSpec**

---

##### `orderBy(sortOrder)`

###### Signature

```apex
public ReturningFieldSpec orderBy(SortOrder sortOrder)
```

###### Parameters

| Name      | Type      | Description |
| --------- | --------- | ----------- |
| sortOrder | SortOrder |             |

###### Return Type

**ReturningFieldSpec**

---

##### `scopeLimit(numberOfRows)`

###### Signature

```apex
public ReturningFieldSpec scopeLimit(Integer numberOfRows)
```

###### Parameters

| Name         | Type    | Description |
| ------------ | ------- | ----------- |
| numberOfRows | Integer |             |

###### Return Type

**ReturningFieldSpec**

---

##### `offset(offset)`

###### Signature

```apex
public ReturningFieldSpec offset(Integer offset)
```

###### Parameters

| Name   | Type    | Description |
| ------ | ------- | ----------- |
| offset | Integer |             |

###### Return Type

**ReturningFieldSpec**

---

##### `toReturningFieldSpecString()`

###### Signature

```apex
public String toReturningFieldSpecString()
```

###### Return Type

**String**

---

##### `addFieldListStatement(queryStatements)`

###### Signature

```apex
private void addFieldListStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addUsingListViewStatement(queryStatements)`

###### Signature

```apex
private void addUsingListViewStatement(List<String> queryStatements)
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

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### PhraseExpression Class

`TESTVISIBLE`

**Implements**

Expression

#### Fields

##### `searchPhrase`

`TESTVISIBLE`

###### Signature

```apex
private searchPhrase
```

###### Type

String

#### Constructors

##### `PhraseExpression(searchPhrase)`

`TESTVISIBLE`

###### Signature

```apex
private PhraseExpression(String searchPhrase)
```

###### Parameters

| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| searchPhrase | String |             |

#### Methods

##### `toExpressionString()`

###### Signature

```apex
public String toExpressionString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### SearchExpression Class

`TESTVISIBLE`

**Implements**

Expression

#### Fields

##### `searchCondition`

`TESTVISIBLE`

###### Signature

```apex
private searchCondition
```

###### Type

SearchCondition

#### Constructors

##### `SearchExpression(searchCondition)`

`TESTVISIBLE`

###### Signature

```apex
private SearchExpression(SearchCondition searchCondition)
```

###### Parameters

| Name            | Type            | Description |
| --------------- | --------------- | ----------- |
| searchCondition | SearchCondition |             |

#### Methods

##### `toExpressionString()`

###### Signature

```apex
public String toExpressionString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### DenialSearchExpression Class

`TESTVISIBLE`

**Implements**

Expression

#### Fields

##### `searchCondition`

`TESTVISIBLE`

###### Signature

```apex
private searchCondition
```

###### Type

SearchCondition

#### Constructors

##### `DenialSearchExpression(searchCondition)`

`TESTVISIBLE`

###### Signature

```apex
private DenialSearchExpression(SearchCondition searchCondition)
```

###### Parameters

| Name            | Type            | Description |
| --------------- | --------------- | ----------- |
| searchCondition | SearchCondition |             |

#### Methods

##### `toExpressionString()`

###### Signature

```apex
public String toExpressionString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### FieldExpression Class

`TESTVISIBLE`

**Implements**

Expression

#### Fields

##### `fieldName`

`TESTVISIBLE`

###### Signature

```apex
private fieldName
```

###### Type

String

---

##### `comparisonOperator`

`TESTVISIBLE`

###### Signature

```apex
private comparisonOperator
```

###### Type

String

---

##### `value`

`TESTVISIBLE`

###### Signature

```apex
private value
```

###### Type

Object

#### Constructors

##### `FieldExpression(fieldName, comparisonOperator, value)`

`TESTVISIBLE`

###### Signature

```apex
private FieldExpression(String fieldName, String comparisonOperator, Object value)
```

###### Parameters

| Name               | Type   | Description |
| ------------------ | ------ | ----------- |
| fieldName          | String |             |
| comparisonOperator | String |             |
| value              | Object |             |

#### Methods

##### `toExpressionString()`

###### Signature

```apex
public String toExpressionString()
```

###### Return Type

**String**

---

##### `formatValue()`

`TESTVISIBLE`

###### Signature

```apex
private String formatValue()
```

###### Return Type

**String**

---

##### `convertToStringList(values)`

###### Signature

```apex
private List<String> convertToStringList(List<Date> values)
```

###### Parameters

| Name   | Type             | Description |
| ------ | ---------------- | ----------- |
| values | List&lt;Date&gt; |             |

###### Return Type

**List&lt;String&gt;**

---

##### `convertToStringList(values)`

###### Signature

```apex
private List<String> convertToStringList(List<Datetime> values)
```

###### Parameters

| Name   | Type                 | Description |
| ------ | -------------------- | ----------- |
| values | List&lt;Datetime&gt; |             |

###### Return Type

**List&lt;String&gt;**

---

##### `convertToStringList(values)`

###### Signature

```apex
private List<String> convertToStringList(List<String> values)
```

###### Parameters

| Name   | Type               | Description |
| ------ | ------------------ | ----------- |
| values | List&lt;String&gt; |             |

###### Return Type

**List&lt;String&gt;**

---

##### `convertToStringList(values)`

###### Signature

```apex
private List<String> convertToStringList(List<Id> values)
```

###### Parameters

| Name   | Type           | Description |
| ------ | -------------- | ----------- |
| values | List&lt;Id&gt; |             |

###### Return Type

**List&lt;String&gt;**

---

##### `convertToStringList(values)`

###### Signature

```apex
private List<String> convertToStringList(List<Integer> values)
```

###### Parameters

| Name   | Type                | Description |
| ------ | ------------------- | ----------- |
| values | List&lt;Integer&gt; |             |

###### Return Type

**List&lt;String&gt;**

---

##### `convertToStringList(values)`

###### Signature

```apex
private List<String> convertToStringList(List<Long> values)
```

###### Parameters

| Name   | Type             | Description |
| ------ | ---------------- | ----------- |
| values | List&lt;Long&gt; |             |

###### Return Type

**List&lt;String&gt;**

---

##### `convertToStringList(values)`

###### Signature

```apex
private List<String> convertToStringList(List<Decimal> values)
```

###### Parameters

| Name   | Type                | Description |
| ------ | ------------------- | ----------- |
| values | List&lt;Decimal&gt; |             |

###### Return Type

**List&lt;String&gt;**

---

##### `convertToStringList(values)`

###### Signature

```apex
private List<String> convertToStringList(List<Double> values)
```

###### Parameters

| Name   | Type               | Description |
| ------ | ------------------ | ----------- |
| values | List&lt;Double&gt; |             |

###### Return Type

**List&lt;String&gt;**

---

##### `convertToStringList(values)`

###### Signature

```apex
private List<String> convertToStringList(Set<Set<String>> values)
```

###### Parameters

| Name   | Type                         | Description |
| ------ | ---------------------------- | ----------- |
| values | Set&lt;Set&lt;String&gt;&gt; |             |

###### Return Type

**List&lt;String&gt;**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### ConditionExpression Class

`TESTVISIBLE`

**Implements**

Expression

#### Fields

##### `condition`

`TESTVISIBLE`

###### Signature

```apex
private condition
```

###### Type

Condition

#### Constructors

##### `ConditionExpression(condition)`

`TESTVISIBLE`

###### Signature

```apex
private ConditionExpression(Condition condition)
```

###### Parameters

| Name      | Type      | Description |
| --------- | --------- | ----------- |
| condition | Condition |             |

#### Methods

##### `toExpressionString()`

###### Signature

```apex
public String toExpressionString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### ConditionDenialExpression Class

`TESTVISIBLE`

**Implements**

Expression

#### Fields

##### `condition`

`TESTVISIBLE`

###### Signature

```apex
private condition
```

###### Type

Condition

#### Constructors

##### `ConditionDenialExpression(condition)`

`TESTVISIBLE`

###### Signature

```apex
private ConditionDenialExpression(Condition condition)
```

###### Parameters

| Name      | Type      | Description |
| --------- | --------- | ----------- |
| condition | Condition |             |

#### Methods

##### `toExpressionString()`

###### Signature

```apex
public String toExpressionString()
```

###### Return Type

**String**

---

##### `toString()`

###### Signature

```apex
public override String toString()
```

###### Return Type

**String**

### QueryException Class

## Enums

### LogicalOperator Enum

Enum for logical operators

#### Values

| Value     | Description |
| --------- | ----------- |
| AND_VALUE |             |
| OR_VALUE  |             |

### SortDirection Enum

Enum for sorting functions

#### Values

| Value      | Description |
| ---------- | ----------- |
| ASCENDING  |             |
| DESCENDING |             |

### SortNullRecords Enum

Enum for null records sorting

#### Values

| Value | Description |
| ----- | ----------- |
| FIRST |             |
| LAST  |             |

### Scope Enum

Enum for Scopes

#### Values

| Value             | Description |
| ----------------- | ----------- |
| DELEGATED         |             |
| EVERYTHING        |             |
| MINE              |             |
| MY_TEAM_TERRITORY |             |
| MY_TERRITORY      |             |
| QUEUE             |             |
| TEAM              |             |

### SearchGroup Enum

Enum for searching groups

#### Values

| Value   | Description |
| ------- | ----------- |
| ALL     |             |
| EMAIL   |             |
| NAME    |             |
| PHONE   |             |
| SIDEBAR |             |

## Interfaces

### Expression Interface

`TESTVISIBLE`

#### Methods

##### `toExpressionString()`

`TESTVISIBLE`

###### Signature

```apex
private String toExpressionString()
```

###### Return Type

**String**
