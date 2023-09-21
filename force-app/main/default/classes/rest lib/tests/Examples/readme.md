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

The important part here, is to construct your `RestLibApiCall` object with the named credential, etc
and then pass it to the `RestClient.makeAPICall` method.

In the following example, it's assumed you've generated a Data Transfer Object (DTO) for the call's response using a
tool like json2apex
(https://json2apex.herokuapp.com/). The DTO is used to parse the response into a strongly typed object.

```apex
RestLibApiCall callout = new RestLibApiCall('CatFactsNamedCredential', 'GET', '/fact');
SomeDTOObjectType response = SomeDTOObjectType.parse(
		new RestClient.makeAPICall('CatFactsNamedCredential', callout)
);
```

#### Writing an interaction class

Interaction classes are designed to be API Glue. They should be the only classes in your codebase that know about the
external api's details such as endpoints, and request payloads.
To make these easier and faster to write, the `RestClientLib` is designed to be extended.
In the following example, we'll create a CatFactsInteraction library that combines buisness logic with
the `RestClientLib` to make callouts to the CatFacts api.

```apex
public with sharing class CatFactsInteraction extends RestClientLib {
	// Here we'll establish a no-param constructor that calls the
	// super constructor with the named credential.
	// This ensures that any call made from this class is tied
	// to the named credential.
	public CatFactsInteraction() {
		super('CatFactsNamedCredential');
	}

	// Here we'll create a method that makes a callout to the api
	public getCatBreed() {
		// this example makes a get call, but you can use any of the http verbs
		CatFactBreedDTO[] breedInfo = CatFactBreedDTO.parse(get('/breeds'));
		List<CatBreed__c> breedsToInsert = new List<CatBreed__c>();
		for (CatFactBreedDTO breed : breedInfo) {
			breedsToInsert.add(
				new CatBreed__c(
					Name = breed.name,
					Description__c = breed.description
				)
			);
		}
		insert as user breedsToInsert;
	}
}
```
