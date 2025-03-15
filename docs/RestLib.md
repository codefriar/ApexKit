A class providing a library of methods for making REST callouts

## Properties

### `namedCredentialName`

`TESTVISIBLE`

The name of the Named Credential to use

#### Signature

```apex
protected namedCredentialName
```

#### Type

String

## Constructors

### `RestLib(namedCredential)`

Constructor that sets Named Credential

#### Signature

```apex
public RestLib(String namedCredential)
```

#### Parameters

| Name            | Type   | Description                         |
| --------------- | ------ | ----------------------------------- |
| namedCredential | String | name of the Named Credential to use |

---

### `RestLib()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

This constructor isn&#x27;t intended for use, which is why it&#x27;s
access modifier is &#x27;Protected&#x27;. However, any child class extending
this class will either have to implement constructors matching the one
above, or this constructor must exist. In order to make this abstraction
as useful as possible, we&#x27;ve elected to leave this constructor here,
but unavailable to anything but inner classes and classes that
extend this one.

#### Signature

```apex
protected RestLib()
```

## Methods

### `makeApiCall(apiCall)`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Omnibus callout method. This is the primary method for
making a REST callout. Most of the other methods in this class serve
as convenient, syntactic sugar on this method.

#### Signature

```apex
protected HttpResponse makeApiCall(RestLibApiCall apiCall)
```

#### Parameters

| Name    | Type                                | Description                                                                         |
| ------- | ----------------------------------- | ----------------------------------------------------------------------------------- |
| apiCall | [RestLibApiCall](RestLibApiCall.md) | The RestLibApiCall object containing all the information needed to make the callout |

#### Return Type

**HttpResponse**

HttpResponse HttpResponse Obj
