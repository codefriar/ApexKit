# AsyncRestLibFinalizer

Abstract class defining a common interface with default implementation for finalizers handling
AsyncRestApi calls

**Implemented types**

[Finalizer](Finalizer)

## Fields

### `public response` → `HttpResponse`

the HTTP response object

---

## Methods

### `private void execute(HttpResponse response)`

The extending class must implement this method to handle the HTTP response

#### Parameters

| Param      | Description                                 |
| ---------- | ------------------------------------------- |
| `response` | HttpResponse response object to be handled. |

### `private void execute(FinalizerContext fc)`

Execution method of the finalizer. required by the interface.

#### Parameters

| Param | Description                                                        |
| ----- | ------------------------------------------------------------------ |
| `fc`  | FinalizerContext Context object dependency injected by Salesforce. |

---
