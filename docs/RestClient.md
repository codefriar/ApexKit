`STATUS: ACTIVE`

A virtual class for making REST API calls

**Inheritance**

[RestLib](https://github.com/codefriar/ApexKit/wiki/RestLib)
&gt;
RestClient

## Constructors

### `public RestClient(String namedCredentialName)`

Constructor for the RestClient class.

#### Parameters

| Param                 | Description                                 |
| --------------------- | ------------------------------------------- |
| `namedCredentialName` | String value of the named credential to use |

---

## Properties

### `protected namedCredentialName` → `String`

_Inherited_
`TESTVISIBLE`

The name of the Named Credential to use

---

## Methods

### `public static HttpResponse makeApiCall(String namedCredential, RestLibApiCall apiCall)`

`SUPPRESSWARNINGS`

A static wrapper for the main makeApiCall method

#### Parameters

| Param             | Description                         |
| ----------------- | ----------------------------------- |
| `namedCredential` | The named credential to use         |
| `apiCall`         | HTTPVerb enum value. See Enum above |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

#### Example

```apex
Log.get().publish(RestClient.makeApiCall(new RestLibApiCall('MockBin',
                                     RestClient.HttpVerb.GET,
                                     '4cb453a6-a23b-42ea-a6ba-9be1c1f17050',
                                     '',
                                     '',
                                     new Map<String,String>())));
```

---
