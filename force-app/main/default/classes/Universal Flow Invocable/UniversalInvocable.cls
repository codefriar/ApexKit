/**
 * @description This class exposes methods from any class that extends Invocable to flows.
 * By adding 'extends Invocable' to your class and adding the call method, any class' methods can be
 * invoked by this single invocable method.
 *
 */
public class UniversalInvocable {
	/**
	 * @description This method is what will be displayed in the flow builder. While the flow actions interface
	 * handles multiple instances of an input object from a list, this currently only deals with the first input object.
	 * @param inputs List<Invocable.UniversalFlowInputOutput> input objects. The first object in the list will be used.
	 *
	 * @return List<Invocable.UniversalFlowInputOutput> output objects. The first object in the list will be populated.
	 */
	@InvocableMethod(
		Label='Universal Invocable'
		Description='Universal Invocable'
	)
	public static List<Invocable.UniversalFlowInputOutput> invoke(
		List<Invocable.UniversalFlowInputOutput> inputs
	) {
		// ignore all but the first input, due to limitations of Invocable Actions framework
		Invocable.UniversalFlowInputOutput input = inputs[0];

		List<Invocable.UniversalFlowInputOutput> outputs = new List<Invocable.UniversalFlowInputOutput>{};

		try {
			// create a new instance of the class you want to invoke via reflection. This works because
			// all of the classes you want to expose as invocable implement the Invocable interface.
			Invocable newInvocable = (Invocable) Type.forName(input.className)
				.newInstance();
			newInvocable.className = input.className;
			newInvocable.methodName = input.methodName;
			// invoke the method on the class
			Object results = newInvocable.call(
				input.methodName,
				input.toCallableParamMap()
			);
			outputs.add(
				new Invocable.UniversalFlowInputOutput(
					input.className,
					input.methodName,
					results
				)
			);
		} catch (TypeException caughtTypeException) {
			// if the class name is invalid, return an error
			outputs.add(
				new Invocable.UniversalFlowInputOutput(
					input.className,
					input.methodName,
					caughtTypeException.getMessage()
				)
			);
		}

		return outputs;
	}
}
