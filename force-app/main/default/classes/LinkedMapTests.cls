@isTest
public class LinkedMapTests {
    @isTest
    static void testPut() {
        LinkedMap map = new LinkedMap();
        map.put(new Set<String>{'key1'}, new List<Object>{'value1'});
        System.assertEquals(map.get(new Set<String>{'key1'}), new List<Object>{'value1'});
        
        map.put(new Set<String>{'key1'}, new List<Object>{'value2'});
        System.assertEquals(map.get(new Set<String>{'key1'}), new List<Object>{'value1', 'value2'});
    }

    @isTest
    static void testGet() {
        LinkedMap map = new LinkedMap();
        map.put(new Set<String>{'key1'}, new List<Object>{'value1'});
        System.assertEquals(map.get(new Set<String>{'key1'}), new List<Object>{'value1'});
        System.assertEquals(map.get(new Set<String>{'key2'}), null);
    }

    @isTest
    static void testRemove() {
        LinkedMap map = new LinkedMap();
        map.put(new Set<String>{'key1'}, new List<Object>{'value1'});
        System.assertEquals(map.remove(new Set<String>{'key1'}), new List<Object>{'value1'});
        System.assertEquals(map.remove(new Set<String>{'key1'}), null);
    }

    @isTest
    static void testContainsKey() {
        LinkedMap map = new LinkedMap();
        map.put(new Set<String>{'key1'}, new List<Object>{'value1'});
        System.assertEquals(map.containsKey(new Set<String>{'key1'}), true);
        System.assertEquals(map.containsKey(new Set<String>{'key2'}), false);
    }

    @isTest
    static void testKeySet() {
        LinkedMap map = new LinkedMap();
        map.put(new Set<String>{'key1'}, new List<Object>{'value1'});
        System.assertEquals(map.keySet(), new Set<Set<String>>{new Set<String>{'key1'}});
    }

    @isTest
    static void testValues() {
        LinkedMap map = new LinkedMap();
        map.put(new Set<String>{'key1'}, new List<Object>{'value1'});
        System.assertEquals(map.values(), new List<List<Object>>{new List<Object>{'value1'}});
    }
}
