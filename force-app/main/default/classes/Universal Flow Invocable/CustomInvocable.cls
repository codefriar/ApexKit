/**
 * @description This class is an example of how to implement the Invocable Abstract Class.
 * It doesn't do much, but it does illustrate how Invocable, UniversalInvocable, UniversalFlowInputOutput and
 * UniversalFlowInputOutputParameter work together to expose multiple methods to Flow.
 */

public class CustomInvocable extends Invocable {
	public List<Integer> daysTillChristmas(List<Date> startingDates) {
		List<Integer> results = new List<Integer>();
		for (Date startingDate : startingDates) {
			results.add(startingDate.daysBetween(Date.newInstance(startingDate.year(), 12, 25)));
		}
		return results;
	}

	public List<Integer> daysBetweenDates(List<Date> startingDates, List<Date> endingDates) {
		List<Integer> results = new List<Integer>();
		for (Integer index = 0; index < endingDates.size(); index++) {
			results.add(startingDates[index].daysBetween(endingDates[index]));
		}
		return results;
	}

	public override List<Object> call(String methodName, List<Map<String, Object>> param2) {
		switch on methodName.toLowerCase() {
			when 'daystillchristmas' {
				return daysTillChristmas((List<Date>) extractParameter('startingDate', param2, List<Date>.class));
			}
			when 'daysbetweendates' {
				return daysBetweenDates(
					(List<Date>) extractParameter('startingDate', param2, List<Date>.class),
					(List<Date>) extractParameter('endingDate', param2, List<Date>.class)
				);
			}
		}
		throw new Invocable.MalformedCallableException('Unsupported method: ' + methodName);
	}
}
