`STATUS: ACTIVE`

A class providing a library of methods for making REST callouts

## Constructors

### `public RestLib(String namedCredential)`

Constructor that sets Named Credential

#### Parameters

| Param             | Description                         |
| ----------------- | ----------------------------------- |
| `namedCredential` | name of the Named Credential to use |

### `protected RestLib()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

This constructor isn't intended for use, which is why it's access modifier is 'Protected'. However, any child class extending this class will either have to implement constructors matching the one above, or this constructor must exist. In order to make this abstraction as useful as possible, we've elected to leave this constructor here, but unavailable to anything but inner classes and classes that extend this one.

---

## Properties

### `protected namedCredentialName` → `String`

`TESTVISIBLE`

The name of the Named Credential to use

---

## Methods

### `protected HttpResponse makeApiCall(RestLibApiCall apiCall)`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Omnibus callout method. This is the primary method for making a REST callout. Most of the other methods in this class serve as convenient, syntactic sugar on this method.

#### Parameters

| Param     | Description                                                                         |
| --------- | ----------------------------------------------------------------------------------- |
| `apiCall` | The RestLibApiCall object containing all the information needed to make the callout |

#### Returns

| Type         | Description                   |
| ------------ | ----------------------------- |
| HttpResponse | HttpResponse HttpResponse Obj |

---
