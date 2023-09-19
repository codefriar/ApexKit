/**
 * @description This class exposes methods from any class that extends Invocable to flows.
 * By adding 'extends Invocable' to your class and adding the call method, any class' methods can be
 * invoked by this single invocable method.
 *
 */
public class UniversalInvocable {
	/**
	 * @description This method is what will be displayed in the flow builder. This method can correctly handle bulk
	 * invocations, even across multiple classes and methods, returning all outputs in the same order as the inputs.
	 * @param inputs List<Invocable.UniversalFlowInputOutput> input objects. The first object in the list will be used.
	 *
	 * @return List<Invocable.UniversalFlowInputOutput> output objects. Every input receives one output, even if
	 * non-fatal exceptions are encountered.
	 */
	@InvocableMethod(Label='Universal Invocable' Description='Universal Invocable')
	public static List<Invocable.UniversalFlowInputOutput> invoke(List<Invocable.UniversalFlowInputOutput> inputs) {
		List<Invocable.UniversalFlowInputOutput> outputs = new List<Invocable.UniversalFlowInputOutput>(inputs.size());
		Map<String, List<Integer>> inputsByClassMethod = new Map<String, List<Integer>>();
		Map<String, BulkCallable> controllers = new Map<String, BulkCallable>();
		Map<String, String> typeErrors = new Map<String, String>();

		// Prepare to load classes and group inputs by class and method
		groupInputsByClassMethod(inputs, inputsByClassMethod, controllers);

		// Attempt to load classes and report errors
		loadClasses(controllers, typeErrors);

		// For each class and method
		for (String indexKey : inputsByClassMethod.keySet()) {
			Integer[] inputIndexes = inputsByClassMethod.get(indexKey);
			List<Invocable.UniversalFlowInputOutput> inputsForClassMethod = new List<Invocable.UniversalFlowInputOutput>();
			for (Integer inputIndex : inputIndexes) {
				inputsForClassMethod.add(inputs[inputIndex]);
			}
			String className = inputsForClassMethod[0].className;
			String methodName = inputsForClassMethod[0].methodName;
			String typeError = typeErrors.get(className);

			try {
				BulkCallable controller = controllers.get(className);
				// Could not resolve class, it was not BulkCallable, or had no default constructor
				if (controller == null) {
					throw new Invocable.MalformedCallableException(typeError);
				}
				List<Map<String, Object>> parameters = new List<Map<String, Object>>();
				for (Invocable.UniversalFlowInputOutput input : inputsForClassMethod) {
					parameters.add(input.toCallableParamMap());
				}
				Object[] results = controller.call(methodName, parameters);
				for (Integer resultIndex = 0; resultIndex < inputIndexes.size(); resultIndex++) {
					outputs[inputIndexes[resultIndex]] = new Invocable.UniversalFlowInputOutput(
						className,
						methodName,
						results[resultIndex]
					);
				}
			} catch (Exception e) {
				String errorMessage = e.getMessage();
				for (Integer inputIndex : inputIndexes) {
					outputs[inputIndex] = new Invocable.UniversalFlowInputOutput(className, methodName, errorMessage);
				}
			}
		}
		return outputs;
	}
	/**
	 * @description               Utility method to populate the initial state.
	 *
	 * @param inputs              The inputs provided to the invoke method.
	 * @param inputsByClassMethod Keeps track of which inputs are using which class.
	 * @param controllers         Keeps track of class name to an instance of that class.
	 */
	static void groupInputsByClassMethod(
		Invocable.UniversalFlowInputOutput[] inputs,
		Map<String, List<Integer>> inputsByClassMethod,
		Map<String, BulkCallable> controllers
	) {
		for (Integer index = 0; index < inputs.size(); index++) {
			Invocable.UniversalFlowInputOutput input = inputs[index];
			controllers.put(input.className, null);
			// We use indexes so we can order the outputs correctly
			Integer[] inputIndexes = inputsByClassMethod.get(input.toString());
			if (inputIndexes == null) {
				inputIndexes = new List<Integer>();
				inputsByClassMethod.put(input.toString(), inputIndexes);
			}
			inputIndexes.add(index);
		}
	}
	/**
	 * @description      Attempts to load the classes, and logs any relevant errors.
	 *
	 * @param classes    A map from the class name to the instance of that class.
	 * @param typeErrors A map from the class name to the errors when trying to instantiate the class.
	 */
	static void loadClasses(Map<String, BulkCallable> classes, Map<String, String> typeErrors) {
		for (String className : classes.keySet()) {
			try {
				classes.put(className, (BulkCallable) (Type.forName(className)).newInstance());
			} catch (Exception e) {
				typeErrors.put(className, e.getMessage());
			}
		}
	}
}
