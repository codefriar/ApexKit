/**
 * Created by kpoorman on 10/2/23.
 */

public with sharing class AutoCallable {
	public Map<String, Map<String, Object>> findCallableMethods(
		String className
	) {
		if (!isValidClass(className)) {
			throw new AutoCallableException('Invalid Class Name');
		}

		ApexClass apexClass = [
			SELECT Id, Name, Body
			FROM ApexClass
			WHERE Name = :className
			WITH SYSTEM_MODE
		];
		Pattern publicMethodSignatureMatcher = Pattern.compile(
			'public\\s+(?!static\\s+)(\\w+)\\s+(\\w+)\\s*\\([^\\)]*\\)'
		);
		Matcher publicMethodSignatures = publicMethodSignatureMatcher.matcher(
			apexClass.Body
		);
		Map<String, Map<String, Object>> methodMap = new Map<String, Map<String, Object>>();
		while (publicMethodSignatures.find()) {
			System.debug(
				'#### found Signature ' + publicMethodSignatures.group()
			);
			String methodSignature = publicMethodSignatures.group();
			methodSignature = methodSignature.replace('(', ' ')
				.replace(')', '');
			System.debug('#### methodSignature without () ' + methodSignature);
			String[] parts = methodSignature.split(' ', 3);

			String methodReturnType = parts[1];
			System.debug('#### methodReturnType ' + methodReturnType);
			String methodName = parts[2];
			System.debug('#### methodName ' + methodName);
			String methodParams = parts[3] != null ? parts[3] : '';
			System.debug('#### methodParams ' + methodParams);
			Map<String, Object> methodInfo = new Map<String, Object>();
			methodInfo.put('name', methodName);
			methodInfo.put('params', methodParams);
			methodMap.put(methodName, methodInfo);
		}
		return methodMap;
	}

	public Boolean isValidClass(String className) {
		Type isType = Type.forName(className);
		return isType != null;
	}

	public class AutoCallableException extends Exception {
	}
}
