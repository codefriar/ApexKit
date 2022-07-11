/**
 * @group Polyfills
 */
public with sharing class Polyfills {
	private class GuaranteedNotToExist {
	}

	public static String classNameFromInstance(Object obj) {
		String result = '';
		try {
			GuaranteedNotToExist shouldThrow = (GuaranteedNotToExist) obj; //NOPMD
		} catch (System.TypeException expectedException) {
			// invalid conversion from runtime type ouroborostests.exampleouroborosimplementation to polyfills.guaranteednottoexist
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
}