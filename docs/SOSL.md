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

### `SOSL(queryString)`

`TESTVISIBLE`

#### Signature

```apex
private SOSL(String queryString)
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

### `query()`

#### Signature

```apex
public List<List<SObject>> query()
```

#### Return Type

**List&lt;List&lt;SObject&gt;&gt;**

---

### `find()`

#### Signature

```apex
public Search.SearchResults find()
```

#### Return Type

**Search.SearchResults**

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

##### `searchCondition`

`TESTVISIBLE`

###### Signature

```apex
private searchCondition
```

###### Type

Query.SearchCondition

---

##### `searchGroup`

`TESTVISIBLE`

###### Signature

```apex
private searchGroup
```

###### Type

Query.SearchGroup

---

##### `returningFieldSpecs`

`TESTVISIBLE`

###### Signature

```apex
private returningFieldSpecs
```

###### Type

List&lt;Query.ReturningFieldSpec&gt;

---

##### `division`

`TESTVISIBLE`

###### Signature

```apex
private division
```

###### Type

String

---

##### `dataCategorySpecs`

`TESTVISIBLE`

###### Signature

```apex
private dataCategorySpecs
```

###### Type

List&lt;DataCategorySpec&gt;

---

##### `snippet`

`TESTVISIBLE`

###### Signature

```apex
private snippet
```

###### Type

String

---

##### `networkIds`

`TESTVISIBLE`

###### Signature

```apex
private networkIds
```

###### Type

Set&lt;String&gt;

---

##### `pricebookId`

`TESTVISIBLE`

###### Signature

```apex
private pricebookId
```

###### Type

String

---

##### `withHighlight`

`TESTVISIBLE`

###### Signature

```apex
private withHighlight
```

###### Type

Boolean

---

##### `snippetTargetLength`

`TESTVISIBLE`

###### Signature

```apex
private snippetTargetLength
```

###### Type

Integer

---

##### `spellCorrection`

`TESTVISIBLE`

###### Signature

```apex
private spellCorrection
```

###### Type

String

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

##### `statementUpdate`

`TESTVISIBLE`

###### Signature

```apex
private statementUpdate
```

###### Type

Set&lt;String&gt;

#### Constructors

##### `Builder(searchPhrase)`

###### Signature

```apex
public Builder(String searchPhrase)
```

###### Parameters

| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| searchPhrase | String |             |

---

##### `Builder(searchCondition)`

###### Signature

```apex
public Builder(Query.SearchCondition searchCondition)
```

###### Parameters

| Name            | Type                  | Description |
| --------------- | --------------------- | ----------- |
| searchCondition | Query.SearchCondition |             |

#### Methods

##### `withSearchGroup(searchGroup)`

###### Signature

```apex
public Builder withSearchGroup(Query.SearchGroup searchGroup)
```

###### Parameters

| Name        | Type              | Description |
| ----------- | ----------------- | ----------- |
| searchGroup | Query.SearchGroup |             |

###### Return Type

**Builder**

---

##### `addReturningFieldSpec(returningFieldSpec)`

###### Signature

```apex
public Builder addReturningFieldSpec(Query.ReturningFieldSpec returningFieldSpec)
```

###### Parameters

| Name               | Type                     | Description |
| ------------------ | ------------------------ | ----------- |
| returningFieldSpec | Query.ReturningFieldSpec |             |

###### Return Type

**Builder**

---

##### `withDivision(division)`

###### Signature

```apex
public Builder withDivision(String division)
```

###### Parameters

| Name     | Type   | Description |
| -------- | ------ | ----------- |
| division | String |             |

###### Return Type

**Builder**

---

##### `withDataCategoryAt(groupName, category)`

###### Signature

```apex
public Builder withDataCategoryAt(String groupName, String category)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| groupName | String |             |
| category  | String |             |

###### Return Type

**Builder**

---

##### `withDataCategoryAbove(groupName, category)`

###### Signature

```apex
public Builder withDataCategoryAbove(String groupName, String category)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| groupName | String |             |
| category  | String |             |

###### Return Type

**Builder**

---

##### `withDataCategoryBelow(groupName, category)`

###### Signature

```apex
public Builder withDataCategoryBelow(String groupName, String category)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| groupName | String |             |
| category  | String |             |

###### Return Type

**Builder**

---

##### `withDataCategoryAboveOrBelow(groupName, category)`

###### Signature

```apex
public Builder withDataCategoryAboveOrBelow(String groupName, String category)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| groupName | String |             |
| category  | String |             |

###### Return Type

**Builder**

---

##### `withHighlight()`

###### Signature

```apex
public Builder withHighlight()
```

###### Return Type

**Builder**

---

##### `withNetworkId(networkId)`

###### Signature

```apex
public Builder withNetworkId(String networkId)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| networkId | String |             |

###### Return Type

**Builder**

---

##### `withNetworkIds(networkIds)`

###### Signature

```apex
public Builder withNetworkIds(List<String> networkIds)
```

###### Parameters

| Name       | Type               | Description |
| ---------- | ------------------ | ----------- |
| networkIds | List&lt;String&gt; |             |

###### Return Type

**Builder**

---

##### `withNetworkIds(networkIds)`

###### Signature

```apex
public Builder withNetworkIds(Set<String> networkIds)
```

###### Parameters

| Name       | Type              | Description |
| ---------- | ----------------- | ----------- |
| networkIds | Set&lt;String&gt; |             |

###### Return Type

**Builder**

---

##### `withPricebookId(pricebookId)`

###### Signature

```apex
public Builder withPricebookId(String pricebookId)
```

###### Parameters

| Name        | Type   | Description |
| ----------- | ------ | ----------- |
| pricebookId | String |             |

###### Return Type

**Builder**

---

##### `withSnippet(snippetTargetLength)`

###### Signature

```apex
public Builder withSnippet(Integer snippetTargetLength)
```

###### Parameters

| Name                | Type    | Description |
| ------------------- | ------- | ----------- |
| snippetTargetLength | Integer |             |

###### Return Type

**Builder**

---

##### `withSpellCorrection(isSpellCorrectionEnabled)`

###### Signature

```apex
public Builder withSpellCorrection(Boolean isSpellCorrectionEnabled)
```

###### Parameters

| Name                     | Type    | Description |
| ------------------------ | ------- | ----------- |
| isSpellCorrectionEnabled | Boolean |             |

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
public SOSL build()
```

###### Return Type

**[SOSL](SOSL.md)**

---

##### `addFindStatement(queryStatements)`

###### Signature

```apex
private void addFindStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addSearchGroupStatement(queryStatements)`

###### Signature

```apex
private void addSearchGroupStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addReturningStatement(queryStatements)`

###### Signature

```apex
private void addReturningStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addDivisionStatement(queryStatements)`

###### Signature

```apex
private void addDivisionStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addDataCategoryStatement(queryStatements)`

###### Signature

```apex
private void addDataCategoryStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addHighlightStatement(queryStatements)`

###### Signature

```apex
private void addHighlightStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addNetworkStatement(queryStatements)`

###### Signature

```apex
private void addNetworkStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addPricebookIdStatement(queryStatements)`

###### Signature

```apex
private void addPricebookIdStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addSnippetStatement(queryStatements)`

###### Signature

```apex
private void addSnippetStatement(List<String> queryStatements)
```

###### Parameters

| Name            | Type               | Description |
| --------------- | ------------------ | ----------- |
| queryStatements | List&lt;String&gt; |             |

###### Return Type

**void**

---

##### `addSpellCorrectionStatement(queryStatements)`

###### Signature

```apex
private void addSpellCorrectionStatement(List<String> queryStatements)
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

### DataCategorySpec Class

`TESTVISIBLE`

#### Fields

##### `groupName`

`TESTVISIBLE`

###### Signature

```apex
private groupName
```

###### Type

String

---

##### `operator`

`TESTVISIBLE`

###### Signature

```apex
private operator
```

###### Type

String

---

##### `category`

`TESTVISIBLE`

###### Signature

```apex
private category
```

###### Type

String

#### Constructors

##### `DataCategorySpec(groupName, operator, category)`

`TESTVISIBLE`

###### Signature

```apex
private DataCategorySpec(String groupName, String operator, String category)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| groupName | String |             |
| operator  | String |             |
| category  | String |             |

#### Methods

##### `toDataCategorySpecString()`

###### Signature

```apex
public String toDataCategorySpecString()
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
