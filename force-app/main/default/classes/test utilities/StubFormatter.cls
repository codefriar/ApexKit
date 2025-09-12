/**
 * @description Utility class for formatting ASCII tables in exception logs to display
 * stubbed method call information and available mocks for debugging purposes.
 */
@IsTest
public with sharing class StubFormatter {
	private static final String TABLE_BORDER = '+';
	private static final String TABLE_SEPARATOR = '-';
	private static final String TABLE_COLUMN_SEPARATOR = ':';
	private static final String LINE_BREAK = '\n';
	private static final Integer MIN_COLUMN_WIDTH = 10;
	private static final Integer MAX_COLUMN_WIDTH = 50;

	/**
	 * @description Formats a complete stub exception message with method call details and available mocks
	 * @param methodName The name of the method that was called
	 * @param parameterTypes List of parameter types for the called method
	 * @param parameterValues List of parameter values for the called method
	 * @param mockedMethods List of MockedMethod objects representing available mocks
	 * @return Formatted ASCII table string for exception logging
	 */
	public static String formatStubException(
		String methodName,
		List<Type> parameterTypes,
		List<Object> parameterValues,
		List<MockedMethod> mockedMethods
	) {
		String formattedMessage = '';
		formattedMessage += LINE_BREAK;
		formattedMessage += 'Stub Exception: No matching mock found for the executed method call.';
		formattedMessage += LINE_BREAK;

		// Add method call information
		formattedMessage += formatMethodCallTable(methodName, parameterTypes, parameterValues);
		formattedMessage += LINE_BREAK;
		formattedMessage += LINE_BREAK;

		// Add available mocks information
		formattedMessage += formatAvailableMocksTable(mockedMethods);

		return formattedMessage;
	}

	/**
	 * @description Formats method call information as an ASCII table
	 * @param methodName The name of the method that was called
	 * @param parameterTypes List of parameter types for the called method
	 * @param parameterValues List of parameter values for the called method
	 * @return Formatted ASCII table string showing the method call details
	 */
	public static String formatMethodCallTable(
		String methodName,
		List<Type> parameterTypes,
		List<Object> parameterValues
	) {
		List<List<String>> tableData = new List<List<String>>();

		// Add header
		tableData.add(new List<String>{ 'Property', 'Value' });

		// Add method name
		tableData.add(new List<String>{ 'Method Name', methodName != null ? methodName : 'null' });

		// Add parameter types
		String paramTypesStr = formatParameterTypes(parameterTypes);
		tableData.add(new List<String>{ 'Parameter Types', paramTypesStr });

		// Add parameter values
		String paramValuesStr = formatParameterValues(parameterValues);
		tableData.add(new List<String>{ 'Parameter Values', paramValuesStr });

		return buildTable('\nMETHOD CALL DETAILS', tableData);
	}

	/**
	 * @description Formats available mocks information as an ASCII table
	 * @param mockedMethods List of MockedMethod objects representing available mocks
	 * @return Formatted ASCII table string showing available mocks
	 */
	public static String formatAvailableMocksTable(List<MockedMethod> mockedMethods) {
		List<List<String>> tableData = new List<List<String>>();

		// Add header
		tableData.add(new List<String>{ 'Method Name', 'Parameter Types', 'Expected Values', 'Return Type' });

		// Add mock method details
		if (mockedMethods != null && !mockedMethods.isEmpty()) {
			for (MockedMethod mockedMethod : mockedMethods) {
				String methodName = getMethodNameFromMock(mockedMethod);
				String paramTypes = getParameterTypesFromMock(mockedMethod);
				String expectedValues = getExpectedValuesFromMock(mockedMethod);
				String returnType = getReturnTypeFromMock(mockedMethod);

				tableData.add(new List<String>{ methodName, paramTypes, expectedValues, returnType });
			}
		} else {
			tableData.add(new List<String>{ 'No mocks available', '', '', '' });
		}

		return buildTable('AVAILABLE MOCKS', tableData);
	}

	/**
	 * @description Builds an ASCII table from table data
	 * @param title The title to display above the table
	 * @param tableData List of rows, where each row is a list of column values
	 * @return Formatted ASCII table string
	 */
	private static String buildTable(String title, List<List<String>> tableData) {
		if (tableData == null || tableData.isEmpty()) {
			return '';
		}

		// Calculate column widths
		List<Integer> columnWidths = calculateColumnWidths(tableData);

		String table = '';

		// Add title
		if (String.isNotBlank(title)) {
			Integer totalWidth = getTotalTableWidth(columnWidths);
			table += centerText(title, totalWidth);
			table += LINE_BREAK;
		}

		// Add top border
		table += buildHorizontalBorder(columnWidths);
		table += LINE_BREAK;

		// Add rows
		for (Integer i = 0; i < tableData.size(); i++) {
			List<String> row = tableData[i];
			table += buildTableRow(row, columnWidths);
			table += LINE_BREAK;

			// Add separator after header row
			if (i == 0) {
				table += buildHorizontalBorder(columnWidths);
				table += LINE_BREAK;
			}
		}

		// Add bottom border
		table += buildHorizontalBorder(columnWidths);

		return table;
	}

	/**
	 * @description Calculates optimal column widths based on content
	 * @param tableData List of rows with column data
	 * @return List of column widths
	 */
	private static List<Integer> calculateColumnWidths(List<List<String>> tableData) {
		List<Integer> columnWidths = new List<Integer>();

		if (tableData.isEmpty()) {
			return columnWidths;
		}

		Integer numColumns = tableData[0].size();

		// Initialize column widths with minimum width
		for (Integer i = 0; i < numColumns; i++) {
			columnWidths.add(MIN_COLUMN_WIDTH);
		}

		// Calculate maximum width needed for each column
		for (List<String> row : tableData) {
			for (Integer i = 0; i < Math.min(row.size(), numColumns); i++) {
				String cellValue = row[i] != null ? row[i] : '';
				Integer contentWidth = cellValue.length() + 2; // Add padding
				if (contentWidth > columnWidths[i] && contentWidth <= MAX_COLUMN_WIDTH) {
					columnWidths[i] = contentWidth;
				} else if (contentWidth > MAX_COLUMN_WIDTH) {
					columnWidths[i] = MAX_COLUMN_WIDTH;
				}
			}
		}

		return columnWidths;
	}

	/**
	 * @description Builds a horizontal border for the table
	 * @param columnWidths List of column widths
	 * @return Horizontal border string
	 */
	private static String buildHorizontalBorder(List<Integer> columnWidths) {
		String border = '';
		border += TABLE_BORDER;

		for (Integer width : columnWidths) {
			for (Integer i = 0; i < width; i++) {
				border += TABLE_SEPARATOR;
			}
			border += TABLE_BORDER;
		}

		return border;
	}

	/**
	 * @description Builds a table row with proper formatting
	 * @param rowData List of cell values for the row
	 * @param columnWidths List of column widths
	 * @return Formatted table row string
	 */
	private static String buildTableRow(List<String> rowData, List<Integer> columnWidths) {
		String row = '';
		row += TABLE_COLUMN_SEPARATOR;

		for (Integer i = 0; i < columnWidths.size(); i++) {
			String cellValue = i < rowData.size() && rowData[i] != null ? rowData[i] : '';
			String formattedCell = formatCell(cellValue, columnWidths[i]);
			row += formattedCell;
			row += TABLE_COLUMN_SEPARATOR;
		}

		return row;
	}

	/**
	 * @description Formats a cell value with proper padding and truncation
	 * @param value The cell value to format
	 * @param width The target width for the cell
	 * @return Formatted cell string
	 */
	private static String formatCell(String value, Integer width) {
		if (String.isBlank(value)) {
			value = '';
		}

		// Truncate if too long
		if (value.length() > width - 2) {
			value = value.substring(0, width - 5) + '...';
		}

		// Add padding
		Integer padding = width - value.length() - 2;
		Integer leftPadding = padding / 2;
		Integer rightPadding = padding - leftPadding;

		String formattedCell = '';
		formattedCell += ' ';

		for (Integer i = 0; i < leftPadding; i++) {
			formattedCell += ' ';
		}

		formattedCell += value;

		for (Integer i = 0; i < rightPadding; i++) {
			formattedCell += ' ';
		}

		formattedCell += ' ';

		return formattedCell;
	}

	/**
	 * @description Centers text within a given width
	 * @param text The text to center
	 * @param width The target width
	 * @return Centered text string
	 */
	private static String centerText(String text, Integer width) {
		if (String.isBlank(text)) {
			return '';
		}

		if (text.length() >= width) {
			return text;
		}

		Integer padding = width - text.length();
		Integer leftPadding = padding / 2;
		Integer rightPadding = padding - leftPadding;

		String centeredText = '';

		for (Integer i = 0; i < leftPadding; i++) {
			centeredText += ' ';
		}

		centeredText += text;

		for (Integer i = 0; i < rightPadding; i++) {
			centeredText += ' ';
		}

		return centeredText;
	}

	/**
	 * @description Calculates total table width including borders
	 * @param columnWidths List of column widths
	 * @return Total table width
	 */
	private static Integer getTotalTableWidth(List<Integer> columnWidths) {
		Integer total = 1; // Start with left border
		for (Integer width : columnWidths) {
			total += width + 1; // Column width plus right border
		}
		return total;
	}

	/**
	 * @description Formats parameter types list as a string
	 * @param parameterTypes List of parameter types
	 * @return Formatted parameter types string
	 */
	private static String formatParameterTypes(List<Type> parameterTypes) {
		if (parameterTypes == null || parameterTypes.isEmpty()) {
			return 'No parameters';
		}

		List<String> typeNames = new List<String>();
		for (Type paramType : parameterTypes) {
			typeNames.add(paramType != null ? paramType.toString() : 'null');
		}

		return String.join(typeNames, ', ');
	}

	/**
	 * @description Formats parameter values list as a string
	 * @param parameterValues List of parameter values
	 * @return Formatted parameter values string
	 */
	private static String formatParameterValues(List<Object> parameterValues) {
		if (parameterValues == null || parameterValues.isEmpty()) {
			return 'No values';
		}

		List<String> valueStrings = new List<String>();
		for (Object value : parameterValues) {
			if (value == null) {
				valueStrings.add('null');
			} else {
				String valueStr = String.valueOf(value ?? '');
				if (valueStr.length() > 20) {
					valueStr = valueStr.substring(0, 17) + '...';
				}
				valueStrings.add(valueStr);
			}
		}

		return String.join(valueStrings, ', ');
	}

	/**
	 * @description Extracts method name from MockedMethod using reflection
	 * @param mockedMethod The mocked method object
	 * @return Method name or 'Unknown' if not accessible
	 */
	private static String getMethodNameFromMock(MockedMethod mockedMethod) {
		return mockedMethod.methodSignature.methodName;
	}

	/**
	 * @description Extracts parameter types from MockedMethod
	 * @param mockedMethod The mocked method object
	 * @return Parameter types string or 'Unknown' if not accessible
	 */
	private static String getParameterTypesFromMock(MockedMethod mockedMethod) {
		List<String> paramTypes = new List<String>();
		for (Type paramType : mockedMethod.methodSignature.methodParameterTypes) {
			paramTypes.add(paramType != null ? paramType.toString() : 'null');
		}
		return String.join(paramTypes, ', ');
	}

	/**
	 * @description Extracts expected values from MockedMethod
	 * @param mockedMethod The mocked method object
	 * @return Expected values string or 'Unknown' if not accessible
	 */
	private static String getExpectedValuesFromMock(MockedMethod mockedMethod) {
		List<String> expectedValues = new List<String>();
		for (Object value : mockedMethod.expectedParameters ?? new List<Object>()) {
			expectedValues.add(value != null ? String.valueOf(value ?? '') : 'null');
		}
		return String.join(expectedValues, ', ');
	}

	/**
	 * @description Extracts return type from MockedMethod
	 * @param mockedMethod The mocked method object
	 * @return Return type string or 'Unknown' if not accessible
	 */
	private static String getReturnTypeFromMock(MockedMethod mockedMethod) {
		String returnValue = '';
		try {
			returnValue = JSON.serialize(mockedMethod.returnValue);
		} catch (Exception e) {
			returnValue = String.valueOf(mockedMethod.returnValue);
		}
		return returnValue;
	}
}
