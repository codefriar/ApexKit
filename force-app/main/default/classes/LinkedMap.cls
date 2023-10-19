public class LinkedMap {
    private Map<Set<String>, List<Object>> linkedMap;

    public LinkedMap() {
        this.linkedMap = new Map<Set<String>, List<Object>>();
    }

    public void put(Set<String> keys, List<Object> values) {
        if (this.linkedMap.containsKey(keys)) {
            this.linkedMap.get(keys).addAll(values);
        } else {
            this.linkedMap.put(keys, values);
        }
    }

    public List<Object> get(Set<String> keys) {
        return this.linkedMap.get(keys);
    }

    public List<Object> remove(Set<String> keys) {
        return this.linkedMap.remove(keys);
    }

    public Boolean containsKey(Set<String> keys) {
        return this.linkedMap.containsKey(keys);
    }

    public Set<Set<String>> keySet() {
        return this.linkedMap.keySet();
    }

    public List<List<Object>> values() {
        return this.linkedMap.values();
    }
}
