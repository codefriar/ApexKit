/**
 * @description This class is full of methods that *I* think should be in the Apex language, but aren't.  It's
 * opinionated, and these represent the best solutions i've found to the gnarly problems i've come across.
 */
public with sharing class Polyfills {
	/**
	 * @description Class exists to reserve an object type that cannot be instantiated.  It is used for generating stack
	 * traces on demand, and other reflection operations.
	 */
	private class GuaranteedNotToExist {
	}

	/**
	 * @description Exception used internally to throw exceptions that
	 * are intentional and used for unofficial reflection
	 * operations.
	 */
	private class GuaranteedNotToExistException extends Exception {
	}

	/**
	 * @description Used to determine what the Class name
	 * of the passed in Object is. There are many mostly
	 * accurate ways of doing this, but this is the only
	 * one that works in all cases.
	 *
	 * @param obj Object the object whose class name you want
	 *
	 * @return String the name of the class of the passed in object.
	 */
	public static String classNameFromInstance(Object obj) {
		String result = '';
		try {
			GuaranteedNotToExist shouldThrow = (GuaranteedNotToExist) obj; //NOPMD
		} catch (System.TypeException expectedException) {
			result = expectedException
				.getMessage()
				.toLowerCase()
				.substringBetween('invalid conversion from runtime type ', ' to polyfills.guaranteednottoexist');
		}
		return result;
	}

	/**
	 * @description Method returns a Type object from an object instance.  This is useful for reflection operations
	 *
	 * @param obj The object to get the type of
	 *
	 * @return Type the type of the passed in object
	 */
	public static Type typeObjFromInstance(Object obj) {
		return Type.forName(classNameFromInstance(obj));
	}

	/**
	 * @description Method determines the type of a list from it's first element.
	 * This is potentially incorrect, if your List is defined `List<SObject>` rather than `List<Account>`
	 * or some other specific SObject
	 *
	 * @param sObjects A list of SObjects
	 *
	 * @return String the name of the SObject type of the first element in the list
	 */
	public static String getSObjectTypeFromListsFirstObject(List<SObject> sObjects) {
		return (!sObjects.isEmpty()) ? sObjects.get(0).getSObjectType().getDescribe().getName() : 'sObject';
	}

	/**
	 * @description Method is responsible for building a map out of a list where you can specify the key. This is
	 * useful for drying up your code, as generating maps by a non-record-id key is ... common.
	 *
	 * Note: you'll need to cast this on the calling side.
	 *
	 * @param key String the name of the field to use as the key. ** This must be an ID field **
	 * However, it doesn't have to be the record id. It can be any field that is an ID field.
	 * @param incomingList List<SObject> the list of SObjects to build the map from
	 *
	 * @return Map<Id, SObject> the map of the passed in list, keyed by the passed in key
	 */
	public static Map<Id, SObject> idMapFromCollectionByKey(String key, List<SObject> incomingList) {
		String objType = getSObjectTypeFromListsFirstObject(incomingList);
		Type dynamicMapType = Type.forName('Map<Id,' + objType + '>');
		Map<Id, SObject> returnValues = (Map<Id, SObject>) dynamicMapType.newInstance();
		for (SObject current : incomingList) {
			if (current.get(key) != null) {
				returnValues.put((Id) current.get(key), current);
			}
		}
		return returnValues;
	}

	/**
	 * @description Method is responsible for building a map out of a list where you can specify the key. This is
	 * useful for drying up your code, as generating maps by a non-record-id key is ... common.
	 *
	 * Note: you'll need to cast this on the calling side.
	 *
	 * @param key String the name of the field to use as the key. ** This must be an STRING field **
	 * @param incomingList List<SObject> the list of SObjects to build the map from
	 *
	 * @return Map<Id, SObject> the map of the passed in list, keyed by the passed in key
	 */
	public static Map<String, SObject> stringMapFromCollectionByKey(String key, List<SObject> incomingList) {
		String objType = getSObjectTypeFromListsFirstObject(incomingList);
		Type dynamicMapType = Type.forName('Map<String,' + objType + '>');
		Map<String, SObject> returnValues = (Map<String, SObject>) dynamicMapType.newInstance();
		for (SObject current : incomingList) {
			if (current.get(key) != null) {
				returnValues.put((String) current.get(key), current);
			}
		}
		return returnValues;
	}

	/**
	 * @description This method is responsible for building a map out of a list where you can specify the key. However
	 * this method is designed to help you group records by common keys. For instance, you can use this method to group
	 * a list of contacts by their accountIds by passing in 'AccountId' as the key.
	 *
	 * Note: you'll need to cast this on the calling side. The key used here must be an ID field.
	 *
	 * @param key String the name of the field to use as the key. ** This must be an ID field **
	 * @param incomingList List<SObject> the list of SObjects to build the map from
	 *
	 * @return Map<Id, List<SObject>> the map of the passed in list, grouped by the passed in key
	 */
	public static Map<Id, List<SObject>> mapFromCollectionWithCollectionValues(String key, List<SObject> incomingList) {
		String objType = getSObjectTypeFromListsFirstObject(incomingList);
		Type listObjType = Type.forName('List<' + objType + '>');
		Type dynamicMapType = Type.forName('Map<Id, List<' + objType + '>>');
		Map<Id, List<SObject>> returnValues = (Map<Id, List<SObject>>) dynamicMapType.newInstance();
		for (SObject current : incomingList) {
			if (current.get(key) != null) {
				if (returnValues.keySet().contains((Id) current.get(key))) {
					List<SObject> existingList = (List<SObject>) returnValues.get((Id) current.get(key));
					existingList.add(current);
					returnValues.put((Id) current.get(key), existingList);
				} else {
					List<SObject> newList = (List<SObject>) listObjType.newInstance();
					newList.add(current);
					returnValues.put((Id) current.get(key), newList);
				}
			}
		}
		return returnValues;
	}

	/**
	 * @description This method will give you a stack trace you can inspect. It's useful for debugging, and for things
	 * like determining the call stack of a method.
	 *
	 * @return String The stack trace of the current execution context.
	 */
	public static String generateStackTrace() {
		return new DmlException().getStackTraceString();
	}

	/**
	 * @description Similar to the pluck method in lodash, this method will return a list of strings from a list of
	 * SObjects, based on the field name you pass in.
	 *
	 * @param fieldName String the name of the field to 'pluck'
	 * @param incomingList List<SObject> list of objects to pluck from
	 *
	 * @return List<String> list containing the string value of the field you passed in from every record in the
	 * incoming list
	 */
	public static List<String> pluckFieldFromList(String fieldName, List<SObject> incomingList) {
		List<String> returnValues = new List<String>();
		for (SObject current : incomingList) {
			returnValues.add(String.valueOf(current.get(fieldName)));
		}
		return returnValues;
	}

	/**
	 * @description Well, as much as I'd like to make this a generic method, I can't
	 * Apex doesn't provide a way to dynamically cast a list of one type
	 * to another type. So, this is a method that will only work for Ids
	 * Future versions of this class might include methods of the same
	 * name but with different parameters to handle other types
	 *
	 * This makes me sad.
	 *
	 * @param setToCheck A set of strings to check
	 * @param listOfPossibleOptions List<String> a list of strings that might be in the set
	 *
	 * @return Boolean True if any of the strings in the list are in the set
	 */
	public static Boolean setContainsAnyItemFromList(Set<String> setToCheck, List<String> listOfPossibleOptions) {
		Boolean setContainsAnyElementOfList = false;
		for (String current : listOfPossibleOptions) {
			if (setToCheck.contains(current)) {
				setContainsAnyElementOfList = true;
				break;
			}
		}
		return setContainsAnyElementOfList;
	}

	/**
	 * @description Generates a UUIDv4 string.  This is useful for generating unique identifiers for things.
	 *
	 * @return String a UUIDv4 string
	 */
	public static String generateUUID() {
		Blob aesKey = Crypto.generateAesKey(128);
		String hexEncodedKey = EncodingUtil.convertToHex(aesKey);
		String guid =
			hexEncodedKey.substring(0, 8) +
			'-' +
			hexEncodedKey.substring(8, 12) +
			'-' +
			hexEncodedKey.substring(12, 16) +
			'-' +
			hexEncodedKey.substring(16, 20) +
			'-' +
			hexEncodedKey.substring(20);
		return guid;
	}

	/**
	 * @description this method is useful for appending a string to a blob. Polyfill for the lack of Blob.append(String)
	 *
	 * @param someFile Blob a file to append a string to
	 * @param supplementalText String the string to append to the blob
	 *
	 * @return Blob the blob with the string appended to it
	 */
	public static Blob concatenateBlobAndString(Blob someFile, String supplementalText) {
		String joinedBlobAndString = getStringifiedBlob(someFile) + supplementalText;
		return Blob.valueOf(joinedBlobAndString);
	}

	/**
	 * @description Returns the string value of a blob. Polyfill for the lack of String.valueOf(Blob)
	 *
	 * @param someFile Blob the blob to stringify
	 *
	 * @return A string representation of the blob
	 */
	public static String getStringifiedBlob(Blob someFile) {
		HttpRequest req = new HttpRequest();
		req.setBodyAsBlob(someFile);
		return req.getBody();
	}
}
