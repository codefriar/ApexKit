/**
 * @description This provides a common interface for classes & methods developers want to expose to flow.
 * Intrepid developers will note you could just implement the Callable interface in all of your classes.
 * However, this class provides a few benefits:
 * - It provides a common interface for all of your classes, which makes it easier to understand what is exposed to flow.
 * - It provides a common exception type, which makes it easier to handle exceptions in flow.
 * - It provides a common wrapper for returning custom objects, which makes it easier to return custom objects in flow.
 *
 * This is an abstract class. This means the classes you want to expose to flow must extend this class.
 * Extending this class will require you to implement the call() method. This is used by the Callable interface
 * and is how developers can expose multiple class methods to flow without writing 1 class with 1 invocable method per
 * method exposed.
 *
 * It should be noted that you should consider this a pattern. Modifying this pattern on a per-class basis would offer
 * more flexibility, additional focus on input types and output types, and more control over the flow experience.
 */
public abstract class Invocable implements BulkCallable {
	/**
	 * @description This is a required method of the callable interface that this class implements.
	 * You'll need to extend the class you intend to expose to flow with this one, and implement this method.
	 * @param methodName This is a string representing the name of the method you want to call.
	 * @param passedParameters This is a map of parameters you're passing to your method.
	 *
	 * @return Object This returns a generic Object. This is the return value of the method you're calling.
	 */
	abstract public List<Object> call(String methodName, List<Map<String, Object>> passedParameters);

	/**
	 * @description This is a common exception object shared by all classes that extend this class. Used primarily
	 * by this class to throw exceptions when the call() method is not implemented, or when the call() method doesn't
	 * handle the method name or parameters passed to it.
	 */
	public class MalformedCallableException extends Exception {
	}

	/**
	 * @description   a 2D point.
	 *
	 * @param x       the x coordinate
	 * @param y       the y coordinate
	 */
	class Point implements Comparable {
		Integer x;
		Integer y;
		Integer hashCode;
		Point(Integer x, Integer y) {
			this.x = x;
			this.y = y;
			hashCode = x << 16 | y;
		}
		/**
		 * @description Used by Map/Set to identify unique values quickly
		 *
		 * @return      `Integer` returns a unique value based on x, y coordinates
		 */
		public Integer hashCode() {
			return hashCode;
		}
		/**
		 * @description checks if the current instance is equal to another
		 *
		 * @param other The object to check for equality
		 * @return      `Boolean` returns `true` if the objects are equal, `false` otherwise
		 */
		public Boolean equals(Object other) {
			return hashCode == ((Point) other).hashCode;
		}
		/**
		 * @description
		 *
		 * @param other the other object to determine sort order
		 * @return      `Integer` negative when `this` is smaller, positive when greater, 0 when equal
		 */
		public Integer compareTo(Object other) {
			return hashCode - ((Point) other).hashCode;
		}
	}
	/**
	 * @description Processes flow input values and returns flow output values
	 */
	public class Processor {
		Map<String, String> typeErrors;
		Map<String, BulkCallable> controllers;
		List<List<UniversalFlowInputOutput>> outputs;
		List<List<UniversalFlowInputOutput>> inputs;
		Map<String, Map<Point, UniversalFlowInputOutput>> inputsByClassMethodByIndex;
    /**
     * @description Default constructor for shared initialization
     */    
    Processor() {
			typeErrors = new Map<String, String>();
			controllers = new Map<String, BulkCallable>();
			inputsByClassMethodByIndex = new Map<String, Map<Point, UniversalFlowInputOutput>>();
    }
		/**
		 * @description  Constructor used for bulk flow processing
		 *
		 * @param inputs the flow inputs from a collection of bulk flow inputs
		 */
		public Processor(List<List<UniversalFlowInputOutput>> inputs) {
      this();
			this.inputs = inputs;
		}
		/**
		 * @description  Constructor used for single bulkified flow processing
		 *
		 * @param inputs the flow inputs from a collection of flow inputs
		 */
		public Processor(List<UniversalFlowInputOutput> inputs) {
      this();
			this.inputs = new List<List<UniversalFlowInputOutput>>{ inputs };
		}
		/**
		 * @description processes a single bulkified flow
		 *
		 * @return      `List<UniversalFlowInputOutput>` the flow inputs from a bulkified flow transaction
		 */
		public List<UniversalFlowInputOutput> execute() {
			return executeBulk()[0];
		}
		/**
		 * @description
		 *
		 * @return      `List<List<UniversalFlowInputOutput>>` the flow inputs from a collection of flow inputs
		 */
		public List<List<UniversalFlowInputOutput>> executeBulk() {
      System.debug(JSON.serialize(this));
			prepare();
      System.debug(JSON.serialize(this));
			loadClasses();
      System.debug(JSON.serialize(this));
			processInputs();
			return outputs;
		}
  /**
   * @description prepares the data structures we need to process
   */
		void prepare() {
			Integer size1 = inputs.size();
      // Allocate the top-level outputs
			outputs = new List<List<UniversalFlowInputOutput>>(size1);
			for (Integer index1 = 0; index1 < size1; index1++) {
				Integer size2 = inputs[index1].size();
        // Allocate the inner-level outputs
				outputs[index1] = new List<UniversalFlowInputOutput>(size2);
				for (Integer index2 = 0; index2 < size2; index2++) {
					UniversalFlowInputOutput input = inputs[index1][index2];
					String classMethodName = input.toString();
					controllers.put(input.className, null);
          // Keep track of each request that uses the same method
					Map<Point, UniversalFlowInputOutput> inputsByClassMethod = inputsByClassMethodByIndex.get(
						classMethodName
					);
					if (inputsByClassMethod == null) {
						inputsByClassMethod = new Map<Point, UniversalFlowInputOutput>();
						inputsByClassMethodByIndex.put(classMethodName, inputsByClassMethod);
					}
					inputsByClassMethod.put(new Point(index1, index2), input);
				}
			}
		}
  /**
   * @description Attempts to instantiate controllers and records errors
   */    
		void loadClasses() {
			for (String className : controllers.keySet()) {
				try {
					controllers.put(className, (BulkCallable) (Type.forName(className)).newInstance());
				} catch (Exception e) {
					typeErrors.put(className, e.getMessage());
				}
			}
		}
  /**
   * @description runs each of the requested methods with the related inputs
   */    
		void processInputs() {
			for (String classMethodName : inputsByClassMethodByIndex.keySet()) {
				Map<Point, UniversalFlowInputOutput> inputsByPoint = inputsByClassMethodByIndex.get(classMethodName);
				List<Point> pointIndexes = new List<Point>(inputsByPoint.keySet());
				List<UniversalFlowInputOutput> inputsForMethod = new List<UniversalFlowInputOutput>();
				for (Point pointIndex : pointIndexes) {
					inputsForMethod.add(inputsByPoint.get(pointIndex));
				}
				Integer inputSize = inputsForMethod.size();
				String className = inputsForMethod[0].className;
        String methodName = inputsForMethod[0].methodName;
				try {
          // Abort this method early if the class could not load
					if (typeErrors.containsKey(className)) {
						throw new MalformedCallableException(
							'Error loading ' + className + ':' + typeErrors.get(className)
						);
					}
          // Load the parameters for BulkCallable
					List<Map<String, Object>> parameterMapping = new List<Map<String, Object>>();
					for (UniversalFlowInputOutput input : inputsForMethod) {
						parameterMapping.add(input.toCallableParamMap());
					}
					BulkCallable controller = controllers.get(className);
          // Attempt to call the method
					List<Object> results = controller.call(methodName, parameterMapping);
					for (Integer index = 0; index < inputSize; index++) {
						Point inputPoint = pointIndexes[index];
						outputs[inputPoint.x][inputPoint.y] = new UniversalFlowInputOutput(
							className,
							methodName,
							results[index],
							false
						);
					}
				} catch (Exception e) {
          // Record errors to report to the flow
					String errorMessage = e.getMessage();
					for (Integer index = 0; index < inputSize; index++) {
						Point inputPoint = pointIndexes[index];
						outputs[inputPoint.x][inputPoint.y] = new UniversalFlowInputOutput(
							className,
							methodName,
							errorMessage,
							true
						);
					}
				}
			}
		}
	}

	/**
	 * @description             Extracts values from a list of parameters. Used by implementations of the Invocable framework.
	 *
	 * @param parameterName     the parameter name to extract into the list
	 * @param parameters        the parameters provided by the flow framework
	 * @param parameterListType the Type of the new list to create
	 * @return                  `List<Object>` The list of extracted values, in the same data type as requested
	 */
	protected List<Object> extractParameter(
		String parameterName,
		List<Map<String, Object>> parameters,
		Type parameterListType
	) {
		List<Object> results = (List<Object>) parameterListType.newInstance();
		for (Map<String, Object> parameter : parameters) {
			results.add(parameter.get(parameterName));
		}
		return results;
	}
}
