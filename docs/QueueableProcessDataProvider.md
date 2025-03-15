This helps us mock the data access in our unit tests.

## Constructors

### `QueueableProcessDataProvider()`

`SUPPRESSWARNINGS`

default constructor. Necessary for dynamic instantiation.

#### Signature

```apex
public QueueableProcessDataProvider()
```

## Methods

### `getClassName(jobId)`

This is the main method that will be called by the QueueableProcessManager. By extracting this
method into a separate class, we can easily mock it in our unit tests.

#### Signature

```apex
public String getClassName(Id jobId)
```

#### Parameters

| Name  | Type | Description                                                   |
| ----- | ---- | ------------------------------------------------------------- |
| jobId | Id   | Id The Id of the AsyncApexJob record that is being processed. |

#### Return Type

**String**

String The name of the Apex class that just failed.
