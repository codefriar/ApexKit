/**
 * @description Provides a similar interface to Callable, but bulkified to handle multiple sets of parameters.
 *
 * @author Brian Fear
 */
public interface BulkCallable {
	List<Object> call(String methodName, List<Map<String, Object>> parameters);
}
