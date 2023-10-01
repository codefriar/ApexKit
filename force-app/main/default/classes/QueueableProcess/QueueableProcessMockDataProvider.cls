@IsTest
public class QueueableProcessMockDataProvider implements System.StubProvider {
	private final String returnString;
	public QueueableProcessMockDataProvider(String returnString) {
		this.returnString = returnString;
	}
	@SuppressWarnings('PMD.ExcessiveParameterList')
	public Object handleMethodCall(
		Object stubbedObject,
		String stubbedMethodName,
		Type returnType,
		List<Type> paramTypes,
		List<String> paramNames,
		List<Object> args
	) {
		// We'ere only working with one method here, so this suffices.
		return this.returnString;
	}
}
