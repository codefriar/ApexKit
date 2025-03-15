This seems like a woefully inadequate test class.
However, the ULID class contains no branching logic to test.
The single public method is fully tested by this class&#x27; method.
Because ULIDs are intentionally random, there&#x27;s no way to test
deterministic output.

## Methods

### `testGenerateMethod()`

`ISTEST`

#### Signature

```apex
private static void testGenerateMethod()
```

#### Return Type

**void**
