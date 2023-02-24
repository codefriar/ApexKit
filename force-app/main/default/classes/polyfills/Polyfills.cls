public with sharing class Polyfills {
	/**
	 * Class exists to reserve an object type that cannot
	 * be instantiated.  It is used for generating stack
	 * traces on demand, and other reflection operations.
	 */
	private class GuaranteedNotToExist {
	}
	/**
	 * Exception used internally to throw exceptions that
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
	 */
	public static String classNameFromInstance(Object obj) {
		String result = '';
		try {
			GuaranteedNotToExist shouldThrow = (GuaranteedNotToExist) obj;
		} catch (System.TypeException expectedException) {
			result = expectedException
				.getMessage()
				.toLowerCase()
				.substringBetween(
					'invalid conversion from runtime type ',
					' to polyfills.guaranteednottoexist'
				);
		}
		return result;
	}

	public static Type typeObjectFromClassName(String className) {
		return Type.forName(className);
	}

	public static Type typeObjFromInstance(Object obj) {
		return typeObjectFromClassName(classNameFromInstance(obj));
	}

	public static String getSObjectTypeFromList(List<SObject> sObjects) {
		return (!sObjects.isEmpty())
			? sObjects.get(0).getSObjectType().getDescribe().getName()
			: 'sObject';
	}

	public static Map<Id, SObject> idMapFromCollectionByKey(
		String key,
		List<SObject> incomingList
	) {
		String objType = getSobjectTypeFromList(incomingList);
		Type dynamicMapType = Type.forName('Map<Id,' + objType + '>');
		Map<Id, SObject> returnValues = (Map<Id, SObject>) dynamicMapType.newInstance();
		for (SObject current : incomingList) {
			if (current.get(key) != null) {
				returnValues.put((Id) current.get(key), current);
			}
		}
		return returnValues;
	}

	public static Map<String, SObject> stringMapFromCollectionByKey(
		String key,
		List<SObject> incomingList
	) {
		String objType = getSobjectTypeFromList(incomingList);
		Type dynamicMapType = Type.forName('Map<String,' + objType + '>');
		Map<String, SObject> returnValues = (Map<String, SObject>) dynamicMapType.newInstance();
		for (SObject current : incomingList) {
			if (current.get(key) != null) {
				returnValues.put((String) current.get(key), current);
			}
		}
		return returnValues;
	}

	public static Map<Id, List<SObject>> mapFromCollectionWithCollectionValues(
		String key,
		List<SObject> incomingList
	) {
		String objType = getSobjectTypeFromList(incomingList);
		Type listObjType = Type.forName('List<' + objType + '>');
		Type dynamicMapType = Type.forName('Map<Id, List<' + objType + '>>');
		Map<Id, List<SObject>> returnValues = (Map<Id, List<SObject>>) dynamicMapType.newInstance();
		for (SObject current : incomingList) {
			if (current.get(key) != null) {
				if (returnValues.keySet().contains((Id) current.get(key))) {
					List<SObject> existingList = (List<SObject>) returnValues.get(
						(Id) current.get(key)
					);
					existingList.add(current);
					returnValues.put((id) current.get(key), existingList);
				} else {
					List<SObject> newList = (List<SObject>) listObjType.newInstance();
					newList.add(current);
					returnValues.put((id) current.get(key), newList);
				}
			}
		}
		return returnValues;
	}

	public static String generateStackTrace() {
		return new DmlException().getStackTraceString();
	}

	public static List<String> pluckFieldFromList(
		String fieldName,
		List<SObject> incomingList
	) {
		List<String> returnValues = new List<String>();
		for (SObject current : incomingList) {
			returnValues.add(String.valueOf(current.get(fieldName)));
		}
		return returnValues;
	}

	/**
	 * Well, as much as I'd like to make this a generic method, I can't
	 * Apex doesn't provide a way to dynamically cast a list of one type
	 * to another type. So, this is a method that will only work for Ids
	 * Future versions of this class might include methods of the same
	 * name but with different parameters to handle other types
	 *
	 * This makes me sad.
	 *
	 */
	public static Boolean setContainsAnyItemFromList(
		Set<String> setToCheck,
		List<String> listOfPossibleOptions
	) {
		Boolean setContainsAnyElementOfList = false;
		for (String current : listOfPossibleOptions) {
			if (setToCheck.contains(current)) {
				setContainsAnyElementOfList = true;
				break;
			}
		}
		return setContainsAnyElementOfList;
	}

	public static String generateUUID() {
		Blob aesKey = Crypto.GenerateAESKey(128);
		String hexEncodedKey = EncodingUtil.ConvertToHex(aesKey);
		String guid =
			hexEncodedKey.subString(0, 8) +
			'-' +
			hexEncodedKey.subString(8, 12) +
			'-' +
			hexEncodedKey.subString(12, 16) +
			'-' +
			hexEncodedKey.subString(16, 20) +
			'-' +
			hexEncodedKey.substring(20);
		return guid;
	}

	public static Blob concatenateBlobAndString(
		Blob someFile,
		String supplementalText
	) {
		String joinedBlobAndString =
			getStringifiedBlob(someFile) + supplementalText;
		return Blob.valueOf(joinedBlobAndString);
	}

	public static String getStringifiedBlob(Blob someFile) {
		HttpRequest req = new HttpRequest();
		req.setBodyAsBlob(someFile);
		return req.getBody();
	}
}