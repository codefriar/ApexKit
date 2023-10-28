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

### `private SOQLAgregate(String queryString)`

## `TESTVISIBLE`

## Fields

### `private queryString` → `String`

`TESTVISIBLE`

---

## Methods

### `public String getQueryString()`

### `public List getAggregateResults()`

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

##### `private groupByCubeOptions` → `Set&lt;String&gt;`

`TESTVISIBLE`

##### `private groupByOptions` → `Set&lt;String&gt;`

`TESTVISIBLE`

##### `private groupByRollupOptions` → `Set&lt;String&gt;`

`TESTVISIBLE`

##### `private havingCondition` → `Query`

`TESTVISIBLE`

##### `private numberOfRows` → `Integer`

`TESTVISIBLE`

##### `private objectType` → `String`

`TESTVISIBLE`

##### `private offset` → `Integer`

`TESTVISIBLE`

##### `private sortOrders` → `List&lt;Query.SortOrder&gt;`

`TESTVISIBLE`

##### `private whereCondition` → `Query`

`TESTVISIBLE`

---

#### Methods

##### `public Builder average(String fieldName)`

##### `public Builder average(String fieldName, String alias)`

##### `public Builder count(String fieldName)`

##### `public Builder count(String fieldName, String alias)`

##### `public Builder countDistinct(String fieldName)`

##### `public Builder countDistinct(String fieldName, String alias)`

##### `public Builder minimum(String fieldName)`

##### `public Builder minimum(String fieldName, String alias)`

##### `public Builder maximum(String fieldName)`

##### `public Builder maximum(String fieldName, String alias)`

##### `public Builder sum(String fieldName)`

##### `public Builder sum(String fieldName, String alias)`

##### `public Builder whereCondition(Query condition)`

##### `public Builder groupBy(String fieldName)`

##### `public Builder groupByRollup(String fieldName)`

##### `public Builder groupByRollup(String fieldName, String groupingAlias)`

##### `public Builder groupByCube(String fieldName)`

##### `public Builder groupByCube(String fieldName, String groupingAlias)`

##### `public Builder havingCondition(Query condition)`

##### `public Builder orderBy(Query sortOrder)`

##### `public Builder scopeLimit(Integer numberOfRows)`

##### `public Builder offset(Integer offset)`

##### `public SOQLAgregate build()`

##### `private void addSelectStatement(List&lt;String&gt; queryStatements)`

##### `private void addFromStatement(List&lt;String&gt; queryStatements)`

##### `private void addWhereStatement(List&lt;String&gt; queryStatements)`

##### `private void addOrderByStatement(List&lt;String&gt; queryStatements)`

##### `private void addLimitStatement(List&lt;String&gt; queryStatements)`

##### `private void addOffsetStatement(List&lt;String&gt; queryStatements)`

##### `private void addGroupByStatement(List&lt;String&gt; queryStatements)`

##### `private void addHavingStatement(List&lt;String&gt; queryStatements)`

##### `public override String toString()`

---

---
