`APIVERSION: 58`

`STATUS: ACTIVE`

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

## Constructors

### `private SOQL(String queryString)`

## `TESTVISIBLE`

## Fields

### `private queryString` → `String`

`TESTVISIBLE`

---

## Methods

### `public String getQueryString()`

### `public sObject getRecord()`

### `public List getRecords()`

### `public Database getQueryLocator()`

### `public override String toString()`

---

## Classes

### Builder

#### Constructors

##### `public Builder(String objectType)`

---

#### Fields

##### `private fieldsToSelect` → `Set&lt;String&gt;`

`TESTVISIBLE`

##### `private numberOfRows` → `Integer`

`TESTVISIBLE`

##### `private objectType` → `String`

`TESTVISIBLE`

##### `private offset` → `Integer`

`TESTVISIBLE`

##### `private scope` → `Query`

`TESTVISIBLE`

##### `private sortOrders` → `List&lt;Query.SortOrder&gt;`

`TESTVISIBLE`

##### `private statementFor` → `Set&lt;String&gt;`

`TESTVISIBLE`

##### `private statementUpdate` → `Set&lt;String&gt;`

`TESTVISIBLE`

##### `private typeOfClauses` → `List&lt;Query.TypeOf&gt;`

`TESTVISIBLE`

##### `private whereCondition` → `Query`

`TESTVISIBLE`

---

#### Methods

##### `public Builder selectField(String fieldApiName)`

##### `public Builder selectFields(List&lt;String&gt; fieldApiNames)`

##### `public Builder selectFields(Set&lt;String&gt; fieldApiNames)`

##### `public Builder selectFields(Schema fieldSet)`

##### `public Builder selectFields(FieldSelection selection)`

##### `public Builder selectAll()`

##### `public Builder selectCustom()`

##### `public Builder selectStandard()`

##### `public Builder addSubQuery(SOQL subQuery)`

##### `public Builder addTypeOf(Query typeOfClause)`

##### `public Builder whereCondition(Query condition)`

##### `public Builder addScope(Query scope)`

##### `public Builder orderBy(Query sortOrder)`

##### `public Builder setScopeLimit(Integer numberOfRows)`

##### `public Builder setOffset(Integer offset)`

##### `public Builder setForReference()`

##### `public Builder setForUpdate()`

##### `public Builder setForView()`

##### `public Builder setUpdateTracking()`

##### `public Builder setUpdateViewStat()`

##### `public SOQL build()`

##### `private void addSelectStatement(List&lt;String&gt; queryStatements)`

##### `private void addFromStatement(List&lt;String&gt; queryStatements)`

##### `private void addWhereStatement(List&lt;String&gt; queryStatements)`

##### `private void addOrderByStatement(List&lt;String&gt; queryStatements)`

##### `private void addLimitStatement(List&lt;String&gt; queryStatements)`

##### `private void addOffsetStatement(List&lt;String&gt; queryStatements)`

##### `private void addScopeStatement(List&lt;String&gt; queryStatements)`

##### `private void addForStatement(List&lt;String&gt; queryStatements)`

##### `private void addUpdateStatement(List&lt;String&gt; queryStatements)`

##### `public override String toString()`

---

---
