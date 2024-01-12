`APIVERSION: 58`

`STATUS: ACTIVE`

This is a fluent interface for building data sets necessary for Apex based testing.

## Fields

### `private dataTree` → `UnitOfWork`

### `private forceInsert` → `Boolean`

---

## Methods

### `public DataBuilder forceInset(Boolean forceInsert)`

### `public DataBuilder withAccounts(SObject prototype, Integer numberOfAccounts, String usingDefaultsClass)`

### `public DataBuilder withAccounts(SObject prototype, Integer numberOfAccounts)`

### `public DataBuilder withAccounts(Integer numberOfAccounts)`

### `public DataBuilder withContacts(SObject prototype, Integer numberOfContacts, String usingDefaultsClass)`

---

## Classes

### UnitOfWork

#### Fields

##### `public accounts` → `List&lt;Account&gt;`

##### `public contacts` → `List&lt;Contact&gt;`

##### `public users` → `List&lt;User&gt;`

---

---
