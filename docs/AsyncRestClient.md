**Implements**

System.Queueable,
Database.AllowsCallouts

## Fields

### `namedCredentialName`

the named credential to use for the api call

#### Signature

```apex
private final namedCredentialName
```

#### Type

String

---

### `apiCall`

The RestLibApiCall that describes your callout

#### Signature

```apex
private final apiCall
```

#### Type

[RestLibApiCall](RestLibApiCall.md)

---

### `handlerClass`

The handler class to instantiate to handle the response

#### Signature

```apex
private final handlerClass
```

#### Type

Type

## Constructors

### `AsyncRestClient(namedCredentialName, apiCall, handlerClass)`

Default constructor

#### Signature

```apex
public AsyncRestClient(String namedCredentialName, RestLibApiCall apiCall, Type handlerClass)
```

#### Parameters

| Name                | Type                                | Description                                                   |
| ------------------- | ----------------------------------- | ------------------------------------------------------------- |
| namedCredentialName | String                              | String representing the named credential to use               |
| apiCall             | [RestLibApiCall](RestLibApiCall.md) | RestLibApiCall The RestLibApiCall that describes your callout |
| handlerClass        | Type                                | Type a type reference to the finalizer to be used.            |

## Methods

### `execute(qc)`

This method will be executed by the Queueable system and is responsible for making the Api call.
The finalizer is attached according to the passed in handlerClass

#### Signature

```apex
public void execute(QueueableContext qc)
```

#### Parameters

| Name | Type             | Description                                                  |
| ---- | ---------------- | ------------------------------------------------------------ |
| qc   | QueueableContext | QueueableContext Dependency Injected by the Queueable system |

#### Return Type

**void**
