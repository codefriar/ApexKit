# RestLib

## Introduction

RestLib is designed to help facilitate both one-off and repeated http callouts.
It's built to enfore best practices, specifically in regard to the use of named credentials.
There are several classes here, but your usage of them depends on what you're trying to do.

## Design philosophy

The design philosophy of RestLib is to make it correctly making one-off calls correctly, while
also making it equally easy to build out API interaction classes. Interaction classes
are focused on implementing the business logic arround a particular third party http rest api.
For instance, if you had an integration with Google, you might create a GoogleAPI interaction class that
had methods like `Authenticat()`, `GetUser()` or `sendEmail()`. These methods would have the necessary logic to make the
appropriate callouts and parse their respones.

These examples all use the CatFacts api (https://catfact.ninja/fact)
you would create a CatFactsAPI class what maps business logic to specific api endpoints and request body information.

## Usage

### Fundamentals

#### RestlibApiCall

The `RestLibAPICall` class represents the information needed to make a callout. Specifically it's concerned with the
following properties:

1. Method - HttpVerb enum of GET, POST, PUT, PATCH, DELETE
2. Path - String representing the path to append to the URL
3. Query - String representing the query of the request, ie: everything after the `?`
4. Body - String representing the body of the request
5. Headers - Map<String,String> representing the headers of the request
   The remaining Classes making up RestLib use RestLibApiCall objects, in conjuction with a named credential, to make
   callouts.

#### One-off callout

```apex
    RestLibApiCall callout = new RestLibApiCall('CatFactsNamedCredential', 'GET', '/fact');
SomeDTOObjectType response = SomeDTOObjectType.parse(
		new RestClient.makeAPICall('CatFactsNamedCredential', callout)
);
```
