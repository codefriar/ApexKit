A virtual class for making REST API calls

**Inheritance**

[RestLib](RestLib.md)

## Properties

### `namedCredentialName`

_Inherited_

`TESTVISIBLE`

The name of the Named Credential to use

#### Signature

```apex
protected namedCredentialName
```

#### Type

String

## Constructors

### `RestClient(namedCredentialName)`

Constructor for the RestClient class.

#### Signature

```apex
public RestClient(String namedCredentialName)
```

#### Parameters

| Name                | Type   | Description                                 |
| ------------------- | ------ | ------------------------------------------- |
| namedCredentialName | String | String value of the named credential to use |

## Methods

### `makeApiCall(namedCredential, apiCall)`

`SUPPRESSWARNINGS`

A static wrapper for the main makeApiCall method

#### Signature

```apex
public static HttpResponse makeApiCall(String namedCredential, RestLibApiCall apiCall)
```

#### Parameters

| Name            | Type                                | Description                         |
| --------------- | ----------------------------------- | ----------------------------------- |
| namedCredential | String                              | The named credential to use         |
| apiCall         | [RestLibApiCall](RestLibApiCall.md) | HTTPVerb enum value. See Enum above |

#### Return Type

**HttpResponse**

,[object Object]

#### Example

Log.get().publish(RestClient.makeApiCall(new RestLibApiCall(&#x27;MockBin&#x27;,
RestClient.HttpVerb.GET,
&#x27;4cb453a6-a23b-42ea-a6ba-9be1c1f17050&#x27;,
&#x27;&#x27;,
&#x27;&#x27;,
new Map&lt;String,String&gt;())));
