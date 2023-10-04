# QueueableProcessDataProvider

A class that separates concerns between the QueueableProcessManager and doing data lookup/access.
This helps us mock the data access in our unit tests.

## Constructors

### `public QueueableProcessDataProvider()`

`SUPPRESSWARNINGS`

default constructor. Necessary for dynamic instantiation.

---

## Methods

### `public String getClassName(Id jobId)`

This is the main method that will be called by the QueueableProcessManager. By extracting this method into a separate class, we can easily mock it in our unit tests.

#### Parameters

| Param   | Description                                                   |
| ------- | ------------------------------------------------------------- |
| `jobId` | Id The Id of the AsyncApexJob record that is being processed. |

#### Returns

| Type   | Description                                         |
| ------ | --------------------------------------------------- |
| String | String The name of the Apex class that just failed. |

---
