/**
 * @description This class is an example of how to implement the Invocable Abstract Class.
 * It doesn't do much, but it does illustrate how BulkCallable, Invocable, UniversalInvocable, UniversalFlowInputOutput and
 * UniversalFlowInputOutputParameter work together to expose multiple methods to Flow.
 *
 * Please understand this is an example class demonstrating the work an Apex developer would need to take to make
 * the following class methods available to Flow: daysTillChristmas and daysBetweenDates.
 *
 */

public class CustomInvocable extends Invocable {
	/**
	 * @description Method exposes the Apex Date method daysBetween to Flow. It accepts a single list of parameter
	 * for the start date, then calculates the days between the start date and Christmas.
	 *
	 * @param startingDates List<Date> to start the calculation from.
	 *
	 * @return List<Integer> List of days between the starting date and Christmas.
	 */
	public List<Integer> daysTillChristmas(List<Date> startingDates) {
		List<Integer> results = new List<Integer>();
		for (Date startingDate : startingDates) {
			results.add(
				startingDate.daysBetween(
					Date.newInstance(startingDate.year(), 12, 25)
				)
			);
		}
		return results;
	}

	/**
	 * @description This method exposes the Apex date method daysBetween to flow accepting two lists of date
	 * parameters, one for startDate and one for endDate. It calculates the days between the two dates.
	 *
	 * @param startingDates List<Date> List of dates to start the calculation from.
	 * @param endingDates List<Date> List of dates to end the calculation at.
	 *
	 * @return List<Integer> List of days between the starting date and ending date.
	 */
	public List<Integer> daysBetweenDates(
		List<Date> startingDates,
		List<Date> endingDates
	) {
		List<Integer> results = new List<Integer>();
		for (Integer index = 0; index < endingDates.size(); index++) {
			results.add(startingDates[index].daysBetween(endingDates[index]));
		}
		return results;
	}

	/**
	 * @description This is the method required by the BulkCallable interface. This is the method you'll need to
	 * implement in any classes you wish to expose to flow.
	 *
	 * @param methodName String name of the method to be invoked
	 * @param param2 List<Map<String, Object>> List of parameters to be passed to the method.
	 *
	 * @return List of Objects to be returned to Flow.
	 */
	public override List<Object> call(
		String methodName,
		List<Map<String, Object>> param2
	) {
		switch on methodName.toLowerCase() {
			// Each case statement represents a method that can be invoked from Flow.
			when 'daystillchristmas' {
				return daysTillChristmas(
					(List<Date>) extractParameter(
						'startingDate',
						param2,
						List<Date>.class
					)
				);
			}
			when 'daysbetweendates' {
				return daysBetweenDates(
					(List<Date>) extractParameter(
						'startingDate',
						param2,
						List<Date>.class
					),
					(List<Date>) extractParameter(
						'endingDate',
						param2,
						List<Date>.class
					)
				);
			}
			when else {
				throw new Invocable.MalformedCallableException(
					'Unsupported method: ' + methodName
				);
			}
		}
	}
}
