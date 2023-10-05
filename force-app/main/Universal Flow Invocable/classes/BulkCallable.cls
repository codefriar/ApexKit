/**
 * @description Provides a similar interface to Callable, but bulkified to handle multiple sets of parameters.
 *
 * @author Brian Fear
 */
public interface BulkCallable {
	/**
	 * @description Implementing classes must implement this method signature.
	 *
	 * @param methodName String the name of the method to call
	 * @param parameters List<Map<String, Object>> a list of maps of parameters to pass to the method
	 *
	 * @return List<Object> The results of the called Apex methods
	 */
	List<Object> call(String methodName, List<Map<String, Object>> parameters);
}
