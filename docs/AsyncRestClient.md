# AsyncRestClient

wraps a restlib backed api call in a queueable context

**Implemented types**

[System.Queueable](System.Queueable)
,
[Database.AllowsCallouts](Database.AllowsCallouts)

## Constructors

### `public AsyncRestClient(String namedCredentialName, RestLibApiCall apiCall, Type handlerClass)`

Default constructor

#### Parameters

| Param                 | Description                                                   |
| --------------------- | ------------------------------------------------------------- |
| `namedCredentialName` | String representing the named credential to use               |
| `apiCall`             | RestLibApiCall The RestLibApiCall that describes your callout |
| `handlerClass`        | Type a type reference to the finalizer to be used.            |

---

## Fields

### `private apiCall` → `RestLibApiCall`

The RestLibApiCall that describes your callout

### `private handlerClass` → `Type`

The handler class to instantiate to handle the response

### `private namedCredentialName` → `String`

the named credential to use for the api call

---

## Methods

### `public void execute(QueueableContext qc)`

This method will be executed by the Queueable system and is responsible for making the Api call. The finalizer is attached according to the passed in handlerClass

#### Parameters

| Param | Description                                                  |
| ----- | ------------------------------------------------------------ |
| `qc`  | QueueableContext Dependency Injected by the Queueable system |

---
