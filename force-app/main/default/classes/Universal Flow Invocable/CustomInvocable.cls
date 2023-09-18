/**
 * @description This class is an example of how to implement the Invocable Abstract Class.
 * It doesn't do much, but it does illustrate how Invocable, UniversalInvocable, UniversalFlowInputOutput and
 * UniversalFlowInputOutputParameter work together to expose multiple methods to Flow.
 */

public class CustomInvocable extends Invocable {
	public Integer daysTillChristmas(Date startingDate) {
		return startingDate.daysBetween(
			Date.newInstance(12, 25, startingDate.year())
		);
	}

	public Integer daysBetweenDates(Date startingDate, Date endingDate) {
		return startingDate.daysBetween(endingDate);
	}

	public override Object call(String methodName, Map<String, Object> param2) {
		switch on methodName.toLowerCase() {
			when 'daystillchristmas' {
				return daysTillChristmas(
					Date.valueOf(param2.get('startingDate'))
				);
			}
			when 'daysbetweendates' {
				return daysBetweenDates(
					Date.valueOf(param2.get('startingDate')),
					Date.valueOf(param2.get('endingDate'))
				);
			}
			when else {
				throwMalformedCallableException();
			}
		}
		// We'll never get here, but the compiler doesn't know that.
		return null;
	}
}
