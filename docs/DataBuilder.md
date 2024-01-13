`APIVERSION: 58`

`STATUS: ACTIVE`

This is a fluent interface for building data sets necessary for Apex based testing.

## Fields

### `private dataTree` → `UnitOfWork`

### `private forceInsert` → `Boolean`

---

## Methods

### `public DataBuilder forceInset(Boolean forceInsert)`

Method to override the default of not inserting this data

#### Parameters

| Param         | Description                                               |
| ------------- | --------------------------------------------------------- |
| `forceInsert` | Boolean if true, overrides the default no insert behavior |

#### Returns

| Type          | Description      |
| ------------- | ---------------- |
| `DataBuilder` | DataBuiler this. |

### `public DataBuilder withAccounts(Integer numberOfAccounts, String usingDefaultsClass)`

Adds accounts to the constructed dataTree UOW object

#### Parameters

| Param                | Description                                                                       |
| -------------------- | --------------------------------------------------------------------------------- |
| `numberOfAccounts`   | Integer number of accounts                                                        |
| `usingDefaultsClass` | String Name of the class to instantiate to provide field values for these objects |

#### Returns

| Type          | Description |
| ------------- | ----------- |
| `DataBuilder` | this        |

### `public DataBuilder withAccounts(Integer numberOfAccounts)`

withAccounts variant allowing for just the number of accounts to create.

#### Parameters

| Param              | Description                        |
| ------------------ | ---------------------------------- |
| `numberOfAccounts` | Integer numberOfAccounts to create |

#### Returns

| Type          | Description |
| ------------- | ----------- |
| `DataBuilder` | this        |

### `public DataBuilder withContacts(Integer numberOfContacts, String usingDefaultsClass)`

A method to add Contacts to the dataTree UOW object

#### Parameters

| Param                | Description                                         |
| -------------------- | --------------------------------------------------- |
| `numberOfContacts`   | Integer the number of contacts to create            |
| `usingDefaultsClass` | String class name to instantiate for default values |

#### Returns

| Type          | Description |
| ------------- | ----------- |
| `DataBuilder` | this        |

### `public UnitOfWork build()`

Returns the constructed dataTree UOW to the developer.

#### Returns

| Type         | Description                                           |
| ------------ | ----------------------------------------------------- |
| `UnitOfWork` | UnitOfWork object containing the constructed objects. |

---

## Classes

### UnitOfWork

Inner class representing a 'Unit of Work' in this case, it's just an object to return to the
developer containing all of the constructed data.

#### Fields

##### `public accounts` → `List&lt;Account&gt;`

##### `public contacts` → `List&lt;Contact&gt;`

##### `public users` → `List&lt;User&gt;`

---

---
