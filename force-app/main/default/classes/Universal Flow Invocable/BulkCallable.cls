/**
 * @description Provides a similar interface to Callable, but with multiple sets of parameters
 *
 * @author      Brian Fear
 * @since       2023-09-18
 */
public interface BulkCallable {
	List<Object> call(String methodName, List<Map<String, Object>> parameters);
}
