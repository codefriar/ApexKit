public with sharing class Polyfills {
    private class GuaranteedNotToExist {
    }

    public static String classNameFromInstance(Object obj) {
        String result = '';
        try {
            GuaranteedNotToExist shouldThrow = (GuaranteedNotToExist) obj;
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
        return sObjects.get(0).getSObjectType().getDescribe().getName();
    }
}
