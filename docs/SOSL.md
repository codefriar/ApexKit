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

### `private SOSL(String queryString)`

## `TESTVISIBLE`

## Fields

### `private queryString` → `String`

`TESTVISIBLE`

---

## Methods

### `public String getQueryString()`

### `public List<List<SObject>> query()`

### `public Search find()`

### `public override String toString()`

---

## Classes

### Builder

#### Constructors

##### `public Builder(String searchPhrase)`

##### `public Builder(Query searchCondition)`

---

#### Fields

##### `private dataCategorySpecs` → `List&lt;DataCategorySpec&gt;`

`TESTVISIBLE`

##### `private division` → `String`

`TESTVISIBLE`

##### `private networkIds` → `Set&lt;String&gt;`

`TESTVISIBLE`

##### `private numberOfRows` → `Integer`

`TESTVISIBLE`

##### `private pricebookId` → `String`

`TESTVISIBLE`

##### `private returningFieldSpecs` → `List&lt;Query.ReturningFieldSpec&gt;`

`TESTVISIBLE`

##### `private searchCondition` → `Query`

`TESTVISIBLE`

##### `private searchGroup` → `Query`

`TESTVISIBLE`

##### `private snippet` → `String`

`TESTVISIBLE`

##### `private snippetTargetLength` → `Integer`

`TESTVISIBLE`

##### `private spellCorrection` → `String`

`TESTVISIBLE`

##### `private statementUpdate` → `Set&lt;String&gt;`

`TESTVISIBLE`

##### `private withHighlight` → `Boolean`

`TESTVISIBLE`

---

#### Methods

##### `public Builder withSearchGroup(Query searchGroup)`

##### `public Builder addReturningFieldSpec(Query returningFieldSpec)`

##### `public Builder withDivision(String division)`

##### `public Builder withDataCategoryAt(String groupName, String category)`

##### `public Builder withDataCategoryAbove(String groupName, String category)`

##### `public Builder withDataCategoryBelow(String groupName, String category)`

##### `public Builder withDataCategoryAboveOrBelow(String groupName, String category)`

##### `public Builder withHighlight()`

##### `public Builder withNetworkId(String networkId)`

##### `public Builder withNetworkIds(List&lt;String&gt; networkIds)`

##### `public Builder withNetworkIds(Set&lt;String&gt; networkIds)`

##### `public Builder withPricebookId(String pricebookId)`

##### `public Builder withSnippet(Integer snippetTargetLength)`

##### `public Builder withSpellCorrection(Boolean isSpellCorrectionEnabled)`

##### `public Builder setScopeLimit(Integer numberOfRows)`

##### `public Builder setUpdateTracking()`

##### `public Builder setUpdateViewStat()`

##### `public SOSL build()`

##### `private void addFindStatement(List&lt;String&gt; queryStatements)`

##### `private void addSearchGroupStatement(List&lt;String&gt; queryStatements)`

##### `private void addReturningStatement(List&lt;String&gt; queryStatements)`

##### `private void addDivisionStatement(List&lt;String&gt; queryStatements)`

##### `private void addDataCategoryStatement(List&lt;String&gt; queryStatements)`

##### `private void addHighlightStatement(List&lt;String&gt; queryStatements)`

##### `private void addNetworkStatement(List&lt;String&gt; queryStatements)`

##### `private void addPricebookIdStatement(List&lt;String&gt; queryStatements)`

##### `private void addSnippetStatement(List&lt;String&gt; queryStatements)`

##### `private void addSpellCorrectionStatement(List&lt;String&gt; queryStatements)`

##### `private void addLimitStatement(List&lt;String&gt; queryStatements)`

##### `private void addUpdateStatement(List&lt;String&gt; queryStatements)`

##### `public override String toString()`

---

### DataCategorySpec

`TESTVISIBLE`

#### Constructors

##### `private DataCategorySpec(String groupName, String operator, String category)`

## `TESTVISIBLE`

#### Fields

##### `private category` → `String`

`TESTVISIBLE`

##### `private groupName` → `String`

`TESTVISIBLE`

##### `private operator` → `String`

`TESTVISIBLE`

---

#### Methods

##### `public String toDataCategorySpecString()`

##### `public override String toString()`

---

---
