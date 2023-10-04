# Query

`SUPPRESSWARNINGS`

MIT License
Copyright (c) 2020 Rafał Kopaczewski
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Enums

### LogicalOperator

Enum for logical operators

### Scope

Enum for Scopes

### SearchGroup

Enum for searching groups

### SortDirection

Enum for sorting functions

### SortNullRecords

Enum for null records sorting

---

## Classes

### Condition

#### Constructors

##### `public Condition()`

##### `public Condition(LogicalOperator logicalOperator)`

---

#### Fields

##### `private expressions` → `List&lt;Expression&gt;`

`TESTVISIBLE`

##### `private logicalOperator` → `LogicalOperator`

`TESTVISIBLE`

---

#### Methods

##### `public Condition equals(String fieldName, Object value)`

##### `public Condition notEquals(String fieldName, Object value)`

##### `public Condition lessThan(String fieldName, Object value)`

##### `public Condition lessOrEqual(String fieldName, Object value)`

##### `public Condition greaterThan(String fieldName, Object value)`

##### `public Condition greaterOrEqual(String fieldName, Object value)`

##### `public Condition isLike(String fieldName, Object value)`

##### `public Condition isIn(String fieldName, Object value)`

##### `public Condition isNotIn(String fieldName, Object value)`

##### `public Condition includes(String fieldName, Set&lt;Set&lt;String&gt;&gt; value)`

##### `public Condition includes(String fieldName, Set&lt;String&gt; value)`

##### `public Condition excludes(String fieldName, Set&lt;Set&lt;String&gt;&gt; value)`

##### `public Condition excludes(String fieldName, Set&lt;String&gt; value)`

##### `public Condition subcondition(Condition condition)`

##### `public Condition negateSubcondition(Condition condition)`

##### `public String toConditionString()`

##### `public override String toString()`

---

### ConditionDenialExpression

`TESTVISIBLE`

**Implemented types**

[Expression](Expression)

#### Constructors

##### `private ConditionDenialExpression(Condition condition)`

## `TESTVISIBLE`

#### Fields

##### `private condition` → `Condition`

`TESTVISIBLE`

---

#### Methods

##### `public String toExpressionString()`

##### `public override String toString()`

---

### ConditionExpression

`TESTVISIBLE`

**Implemented types**

[Expression](Expression)

#### Constructors

##### `private ConditionExpression(Condition condition)`

## `TESTVISIBLE`

#### Fields

##### `private condition` → `Condition`

`TESTVISIBLE`

---

#### Methods

##### `public String toExpressionString()`

##### `public override String toString()`

---

### DateLiteral

#### Constructors

##### `public DateLiteral(String dateLiteralName)`

##### `public DateLiteral(String dateLiteralName, Integer numberOfUnits)`

---

#### Fields

##### `private dateLiteralName` → `String`

`TESTVISIBLE`

##### `private numberOfUnits` → `Integer`

`TESTVISIBLE`

---

#### Methods

##### `public String toDateLiteralString()`

##### `public override String toString()`

---

### DenialSearchExpression

`TESTVISIBLE`

**Implemented types**

[Expression](Expression)

#### Constructors

##### `private DenialSearchExpression(SearchCondition searchCondition)`

## `TESTVISIBLE`

#### Fields

##### `private searchCondition` → `SearchCondition`

`TESTVISIBLE`

---

#### Methods

##### `public String toExpressionString()`

##### `public override String toString()`

---

### FieldExpression

`TESTVISIBLE`

**Implemented types**

[Expression](Expression)

#### Constructors

##### `private FieldExpression(String fieldName, String comparisonOperator, Object value)`

## `TESTVISIBLE`

#### Fields

##### `private comparisonOperator` → `String`

`TESTVISIBLE`

##### `private fieldName` → `String`

`TESTVISIBLE`

##### `private value` → `Object`

`TESTVISIBLE`

---

#### Methods

##### `public String toExpressionString()`

##### `private String formatValue()`

`TESTVISIBLE`

##### `private List convertToStringList(List&lt;Date&gt; values)`

##### `private List convertToStringList(List&lt;Datetime&gt; values)`

##### `private List convertToStringList(List&lt;String&gt; values)`

##### `private List convertToStringList(List&lt;Id&gt; values)`

##### `private List convertToStringList(List&lt;Integer&gt; values)`

##### `private List convertToStringList(List&lt;Long&gt; values)`

##### `private List convertToStringList(List&lt;Decimal&gt; values)`

##### `private List convertToStringList(List&lt;Double&gt; values)`

##### `private List convertToStringList(Set&lt;Set&lt;String&gt;&gt; values)`

##### `public override String toString()`

---

### PhraseExpression

`TESTVISIBLE`

**Implemented types**

[Expression](Expression)

#### Constructors

##### `private PhraseExpression(String searchPhrase)`

## `TESTVISIBLE`

#### Fields

##### `private searchPhrase` → `String`

`TESTVISIBLE`

---

#### Methods

##### `public String toExpressionString()`

##### `public override String toString()`

---

### QueryException

**Inheritance**

QueryException

### ReturningFieldSpec

#### Constructors

##### `public ReturningFieldSpec(SObjectType sobjectType)`

##### `public ReturningFieldSpec(String objectTypeName)`

---

#### Fields

##### `private fieldsToSelect` → `Set&lt;String&gt;`

`TESTVISIBLE`

##### `private listViewName` → `String`

`TESTVISIBLE`

##### `private numberOfRows` → `Integer`

`TESTVISIBLE`

##### `private objectTypeName` → `String`

`TESTVISIBLE`

##### `private offset` → `Integer`

`TESTVISIBLE`

##### `private sortOrders` → `List&lt;SortOrder&gt;`

`TESTVISIBLE`

##### `private whereCondition` → `Condition`

`TESTVISIBLE`

---

#### Methods

##### `public ReturningFieldSpec selectField(String fieldApiName)`

##### `public ReturningFieldSpec selectFields(List&lt;String&gt; fieldApiNames)`

##### `public ReturningFieldSpec selectFields(Set&lt;String&gt; fieldApiNames)`

##### `public ReturningFieldSpec selectFields(Schema fieldSet)`

##### `public ReturningFieldSpec usingListView(String listViewName)`

##### `public ReturningFieldSpec whereCondition(Condition condition)`

##### `public ReturningFieldSpec orderBy(SortOrder sortOrder)`

##### `public ReturningFieldSpec scopeLimit(Integer numberOfRows)`

##### `public ReturningFieldSpec offset(Integer offset)`

##### `public String toReturningFieldSpecString()`

##### `private void addFieldListStatement(List&lt;String&gt; queryStatements)`

##### `private void addUsingListViewStatement(List&lt;String&gt; queryStatements)`

##### `private void addWhereStatement(List&lt;String&gt; queryStatements)`

##### `private void addOrderByStatement(List&lt;String&gt; queryStatements)`

##### `private void addLimitStatement(List&lt;String&gt; queryStatements)`

##### `private void addOffsetStatement(List&lt;String&gt; queryStatements)`

##### `public override String toString()`

---

### ScriptVariable

#### Constructors

##### `public ScriptVariable(String variableName)`

---

#### Fields

##### `private variableName` → `String`

`TESTVISIBLE`

---

#### Methods

##### `public String toScriptVariableString()`

##### `public override String toString()`

---

### SearchCondition

#### Constructors

##### `public SearchCondition()`

##### `public SearchCondition(LogicalOperator logicalOperator)`

---

#### Fields

##### `private logicalOperator` → `LogicalOperator`

`TESTVISIBLE`

##### `private searchExpressions` → `List&lt;Expression&gt;`

`TESTVISIBLE`

---

#### Methods

##### `public SearchCondition find(String searchPhrase)`

##### `public SearchCondition subSearchCondition(SearchCondition searchCondition)`

##### `public SearchCondition negateSubSearchCondition(SearchCondition searchCondition)`

##### `public String toConditionString()`

##### `public override String toString()`

---

### SearchExpression

`TESTVISIBLE`

**Implemented types**

[Expression](Expression)

#### Constructors

##### `private SearchExpression(SearchCondition searchCondition)`

## `TESTVISIBLE`

#### Fields

##### `private searchCondition` → `SearchCondition`

`TESTVISIBLE`

---

#### Methods

##### `public String toExpressionString()`

##### `public override String toString()`

---

### SortOrder

Class encompassing the soql sorting information

#### Constructors

##### `public SortOrder(String fieldName)`

##### `public SortOrder(String fieldName, SortDirection direction)`

##### `public SortOrder(String fieldName, SortDirection direction, SortNullRecords nullRecords)`

---

#### Fields

##### `private direction` → `SortDirection`

`TESTVISIBLE`

##### `private fieldname` → `String`

`TESTVISIBLE`

##### `private nullRecords` → `SortNullRecords`

`TESTVISIBLE`

---

#### Methods

##### `public String toSortOrderString()`

##### `public override String toString()`

---

### TypeOf

#### Constructors

##### `public TypeOf(String polymorphicReference)`

---

#### Fields

##### `private elseFieldList` → `Set&lt;String&gt;`

`TESTVISIBLE`

##### `private polymorphicReference` → `String`

`TESTVISIBLE`

##### `private sobjectType2FieldList` → `Map&lt;String,Set&lt;String&gt;&gt;`

`TESTVISIBLE`

---

#### Methods

##### `public TypeOf whenSObjectType(String sobjectType, Set&lt;String&gt; whenFieldList)`

##### `public TypeOf whenSObjectType(String sobjectType, List&lt;String&gt; whenFieldList)`

##### `public TypeOf elseFieldList(Set&lt;String&gt; elseFieldList)`

##### `public TypeOf elseFieldList(List&lt;String&gt; elseFieldList)`

##### `public TypeOf elseFieldList(String elseField)`

##### `public String toTypeOfString()`

##### `public override String toString()`

---

---

## Interfaces

### Expression

`TESTVISIBLE`

#### Methods

##### `private String toExpressionString()`

## `TESTVISIBLE`
