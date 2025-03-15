Abstract class defining a common interface with default implementation for finalizers handling
AsyncRestApi calls

**Implements**

Finalizer

## Fields

### `response`

the HTTP response object

#### Signature

```apex
public response
```

#### Type

HttpResponse

## Methods

### `execute(response)`

The extending class must implement this method to handle the HTTP response

#### Signature

```apex
private abstract void execute(HttpResponse response)
```

#### Parameters

| Name     | Type         | Description                                 |
| -------- | ------------ | ------------------------------------------- |
| response | HttpResponse | HttpResponse response object to be handled. |

#### Return Type

**void**

---

### `execute(fc)`

Execution method of the finalizer. required by the interface.

#### Signature

```apex
private void execute(FinalizerContext fc)
```

#### Parameters

| Name | Type             | Description                                                        |
| ---- | ---------------- | ------------------------------------------------------------------ |
| fc   | FinalizerContext | FinalizerContext Context object dependency injected by Salesforce. |

#### Return Type

**void**
