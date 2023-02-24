/**
 * MIT License
 *
 * Copyright (c) 2020 Rafał Kopaczewski
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
public class Query {
	public enum LogicalOperator {
		AND_VALUE,
		OR_VALUE
	}

	public enum SortDirection {
		ASCENDING,
		DESCENDING
	}

	public enum SortNullRecords {
		FIRST,
		LAST
	}

	public enum Scope {
		Delegated,
		Everything,
		Mine,
		MyTeamTerritory,
		MyTerritory,
		Queue,
		Team
	}

	public enum SearchGroup {
		ALL,
		EMAIL,
		NAME,
		PHONE,
		SIDEBAR
	}

	public class SortOrder {
		@TestVisible
		private String fieldname;
		@TestVisible
		private SortDirection direction;
		@TestVisible
		private SortNullRecords nullRecords;

		public SortOrder(String fieldName) {
			this.fieldname = fieldname;
		}

		public SortOrder(String fieldName, SortDirection direction) {
			this(fieldName);
			this.direction = direction;
		}

		public SortOrder(
			String fieldName,
			SortDirection direction,
			SortNullRecords nullRecords
		) {
			this(fieldName, direction);
			this.nullRecords = nullRecords;
		}

		public String toSortOrderString() {
			List<String> sortOrderStrings = new List<String>{ fieldName };
			if (direction != null) {
				switch on direction {
					when ASCENDING {
						sortOrderStrings.add('ASC');
					}
					when DESCENDING {
						sortOrderStrings.add('DESC');
					}
				}
			}
			if (nullRecords != null) {
				sortOrderStrings.add('NULLS ' + nullRecords.name());
			}
			return String.join(sortOrderStrings, ' ');
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	public class Condition {
		@TestVisible
		private LogicalOperator logicalOperator;
		@TestVisible
		private List<Expression> expressions;

		public Condition() {
			this(QUERY.LogicalOperator.AND_VALUE);
		}

		public Condition(LogicalOperator logicalOperator) {
			this.logicalOperator = logicalOperator;
			expressions = new List<Expression>();
		}

		public Condition equals(String fieldName, Object value) {
			expressions.add(new FieldExpression(fieldName, '=', value));
			return this;
		}

		public Condition notEquals(String fieldName, Object value) {
			expressions.add(new FieldExpression(fieldName, '!=', value));
			return this;
		}

		public Condition lessThan(String fieldName, Object value) {
			expressions.add(new FieldExpression(fieldName, '<', value));
			return this;
		}

		public Condition lessOrEqual(String fieldName, Object value) {
			expressions.add(new FieldExpression(fieldName, '<=', value));
			return this;
		}

		public Condition greaterThan(String fieldName, Object value) {
			expressions.add(new FieldExpression(fieldName, '>', value));
			return this;
		}

		public Condition greaterOrEqual(String fieldName, Object value) {
			expressions.add(new FieldExpression(fieldName, '>=', value));
			return this;
		}

		public Condition isLike(String fieldName, Object value) {
			expressions.add(new FieldExpression(fieldName, 'LIKE', value));
			return this;
		}

		public Condition isIn(String fieldName, Object value) {
			expressions.add(new FieldExpression(fieldName, 'IN', value));
			return this;
		}

		public Condition isNotIn(String fieldName, Object value) {
			expressions.add(new FieldExpression(fieldName, 'NOT IN', value));
			return this;
		}

		public Condition includes(String fieldName, Set<Set<String>> value) {
			expressions.add(new FieldExpression(fieldName, 'INCLUDES', value));
			return this;
		}

		public Condition includes(String fieldName, Set<String> value) {
			expressions.add(new FieldExpression(fieldName, 'INCLUDES', value));
			return this;
		}

		public Condition excludes(String fieldName, Set<Set<String>> value) {
			expressions.add(new FieldExpression(fieldName, 'EXCLUDES', value));
			return this;
		}

		public Condition excludes(String fieldName, Set<String> value) {
			expressions.add(new FieldExpression(fieldName, 'EXCLUDES', value));
			return this;
		}

		public Condition subcondition(Condition condition) {
			expressions.add(new ConditionExpression(condition));
			return this;
		}

		public Condition negateSubcondition(Condition condition) {
			expressions.add(new ConditionDenialExpression(condition));
			return this;
		}

		public String toConditionString() {
			List<String> expressionStrings = new List<String>();
			for (Expression e : expressions) {
				expressionStrings.add(e.toExpressionString());
			}
			switch on logicalOperator {
				when AND_VALUE {
					return String.join(expressionStrings, ' AND ');
				}
				when OR_VALUE {
					return String.join(expressionStrings, ' OR ');
				}
				when else {
					throw new QueryException(
						'Unsupported operator: ' + logicalOperator
					);
				}
			}
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	public class DateLiteral {
		@TestVisible
		private String dateLiteralName;
		@TestVisible
		private Integer numberOfUnits;

		public DateLiteral(String dateLiteralName) {
			this.dateLiteralName = dateLiteralName;
		}
		public DateLiteral(String dateLiteralName, Integer numberOfUnits) {
			this.dateLiteralName = dateLiteralName;
			this.numberOfUnits = numberOfUnits;
		}

		@TestVisible
		public String toDateLiteralString() {
			return dateLiteralName +
				(numberOfUnits == null ? '' : ':' + numberOfUnits);
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	public class ScriptVariable {
		@TestVisible
		private String variableName;

		public ScriptVariable(String variableName) {
			this.variableName = variableName;
		}

		@TestVisible
		public String toScriptVariableString() {
			return ':' + variableName;
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	public class TypeOf {
		@TestVisible
		private String polymorphicReference;
		@TestVisible
		private Map<String, Set<String>> sobjectType2FieldList;
		@TestVisible
		private Set<String> elseFieldList;

		public TypeOf(String polymorphicReference) {
			this.polymorphicReference = polymorphicReference;
			sobjectType2FieldList = new Map<String, Set<String>>();
			elseFieldList = new Set<String>();
		}

		public TypeOf whenSObjectType(
			String sobjectType,
			Set<String> whenFieldList
		) {
			sobjectType2FieldList.put(sobjectType, whenFieldList);
			return this;
		}

		public TypeOf whenSObjectType(
			String sobjectType,
			List<String> whenFieldList
		) {
			sobjectType2FieldList.put(
				sobjectType,
				new Set<String>(whenFieldList)
			);
			return this;
		}

		public TypeOf elseFieldList(Set<String> elseFieldList) {
			this.elseFieldList.addAll(elseFieldList);
			return this;
		}

		public TypeOf elseFieldList(List<String> elseFieldList) {
			this.elseFieldList.addAll(elseFieldList);
			return this;
		}

		public TypeOf elseFieldList(String elseField) {
			elseFieldList.add(elseField);
			return this;
		}

		public String toTypeOfString() {
			List<String> typeOfConditions = new List<String>();
			for (String sobjectType : sobjectType2FieldList.keySet()) {
				typeOfConditions.add(
					'WHEN ' +
						sobjectType +
						' THEN ' +
						String.join(
							new List<String>(
								sobjectType2FieldList.get(sobjectType)
							),
							', '
						)
				);
			}
			if (!elseFieldList.isEmpty()) {
				typeOfConditions.add(
					'ELSE ' + String.join(new List<String>(elseFieldList), ', ')
				);
			}
			return 'TYPEOF ' +
				polymorphicReference +
				' ' +
				String.join(typeOfConditions, ' ') +
				' END';
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	public class SearchCondition {
		@TestVisible
		private LogicalOperator logicalOperator;
		@TestVisible
		private List<Expression> searchExpressions;

		public SearchCondition() {
			this(QUERY.LogicalOperator.AND_VALUE);
		}

		public SearchCondition(LogicalOperator logicalOperator) {
			this.logicalOperator = logicalOperator;
			searchExpressions = new List<Expression>();
		}

		public SearchCondition find(String searchPhrase) {
			searchExpressions.add(new PhraseExpression(searchPhrase));
			return this;
		}

		public SearchCondition subSearchCondition(
			SearchCondition searchCondition
		) {
			searchExpressions.add(new SearchExpression(searchCondition));
			return this;
		}

		public SearchCondition negateSubSearchCondition(
			SearchCondition searchCondition
		) {
			searchExpressions.add(new DenialSearchExpression(searchCondition));
			return this;
		}

		public String toConditionString() {
			List<String> searchExpressionStrings = new List<String>();
			for (Expression e : searchExpressions) {
				searchExpressionStrings.add(e.toExpressionString());
			}
			switch on logicalOperator {
				when AND_VALUE {
					return String.join(searchExpressionStrings, ' AND ');
				}
				when OR_VALUE {
					return String.join(searchExpressionStrings, ' OR ');
				}
				when else {
					throw new QueryException(
						'Unsupported operator: ' + logicalOperator
					);
				}
			}
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	public class ReturningFieldSpec {
		@TestVisible
		private String objectTypeName;
		@TestVisible
		private Set<String> fieldsToSelect;
		@TestVisible
		private String listViewName;
		@TestVisible
		private Condition whereCondition;
		@TestVisible
		private List<SortOrder> sortOrders;
		@TestVisible
		private Integer numberOfRows;
		@TestVisible
		private Integer offset;

		public ReturningFieldSpec(SobjectType sobjectType) {
			this(sobjectType.getDescribe().getName());
		}

		public ReturningFieldSpec(String objectTypeName) {
			this.objectTypeName = objectTypeName;
			fieldsToSelect = new Set<String>();
			whereCondition = new Condition(Query.LogicalOperator.AND_VALUE);
			sortOrders = new List<SortOrder>();
		}

		public ReturningFieldSpec selectField(String fieldApiName) {
			fieldsToSelect.add(fieldApiName);
			return this;
		}

		public ReturningFieldSpec selectFields(List<String> fieldApiNames) {
			fieldsToSelect.addAll(fieldApiNames);
			return this;
		}

		public ReturningFieldSpec selectFields(Set<String> fieldApiNames) {
			fieldsToSelect.addAll(fieldApiNames);
			return this;
		}

		public ReturningFieldSpec selectFields(Schema.FieldSet fieldSet) {
			for (Schema.FieldSetMember field : fieldSet.getFields()) {
				fieldsToSelect.add(field.getFieldPath());
			}
			return this;
		}

		public ReturningFieldSpec usingListView(String listViewName) {
			this.listViewName = listViewName;
			return this;
		}

		public ReturningFieldSpec whereCondition(Condition condition) {
			this.whereCondition.subcondition(condition);
			return this;
		}

		public ReturningFieldSpec orderBy(SortOrder sortOrder) {
			sortOrders.add(sortOrder);
			return this;
		}

		public ReturningFieldSpec scopeLimit(Integer numberOfRows) {
			this.numberOfRows = numberOfRows;
			return this;
		}

		public ReturningFieldSpec offset(Integer offset) {
			this.offset = offset;
			return this;
		}

		public String toReturningFieldSpecString() {
			List<String> queryStatements = new List<String>();
			addFieldListStatement(queryStatements);
			addUsingListViewStatement(queryStatements);
			addWhereStatement(queryStatements);
			addOrderByStatement(queryStatements);
			addLimitStatement(queryStatements);
			addOffsetStatement(queryStatements);

			return objectTypeName +
				(queryStatements.isEmpty()
					? ''
					: ' (' + String.join(queryStatements, ' ') + ')');
		}

		private void addFieldListStatement(List<String> queryStatements) {
			if (!fieldsToSelect.isEmpty()) {
				List<String> fieldList = new List<String>(fieldsToSelect);
				queryStatements.add(String.join(fieldList, ', '));
			}
		}

		private void addUsingListViewStatement(List<String> queryStatements) {
			if (String.isNotBlank(listViewName)) {
				queryStatements.add('USING LISTVIEW = ' + listViewName);
			}
		}

		private void addWhereStatement(List<String> queryStatements) {
			String whereConditionString = whereCondition.toConditionString();
			if (String.isNotBlank(whereConditionString)) {
				queryStatements.add('WHERE ' + whereConditionString);
			}
		}

		private void addOrderByStatement(List<String> queryStatements) {
			if (!sortOrders.isEmpty()) {
				List<String> sortOrderStrings = new List<String>();
				for (SortOrder so : sortOrders) {
					sortOrderStrings.add(so.toSortOrderString());
				}
				queryStatements.add(
					'ORDER BY ' + String.join(sortOrderStrings, ', ')
				);
			}
		}

		private void addLimitStatement(List<String> queryStatements) {
			if (numberOfRows != null) {
				queryStatements.add('LIMIT ' + numberOfRows);
			}
		}

		private void addOffsetStatement(List<String> queryStatements) {
			if (offset != null) {
				queryStatements.add('OFFSET ' + offset);
			}
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	@TestVisible
	private class PhraseExpression implements Expression {
		@TestVisible
		private String searchPhrase;

		@TestVisible
		private PhraseExpression(String searchPhrase) {
			this.searchPhrase = searchPhrase;
		}

		public String toExpressionString() {
			return searchPhrase;
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	@TestVisible
	private class SearchExpression implements Expression {
		@TestVisible
		private SearchCondition searchCondition;

		@TestVisible
		private SearchExpression(SearchCondition searchCondition) {
			this.searchCondition = searchCondition;
		}

		public String toExpressionString() {
			return '(' + searchCondition.toConditionString() + ')';
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	@TestVisible
	private class DenialSearchExpression implements Expression {
		@TestVisible
		private SearchCondition searchCondition;

		@TestVisible
		private DenialSearchExpression(SearchCondition searchCondition) {
			this.searchCondition = searchCondition;
		}

		public String toExpressionString() {
			return 'NOT(' + searchCondition.toConditionString() + ')';
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	@TestVisible
	private interface Expression {
		String toExpressionString();
	}

	@TestVisible
	private class FieldExpression implements Expression {
		@TestVisible
		private String fieldName;
		@TestVisible
		private String comparisonOperator;
		@TestVisible
		private Object value;

		@TestVisible
		private FieldExpression(
			String fieldName,
			String comparisonOperator,
			Object value
		) {
			this.fieldName = fieldName;
			this.comparisonOperator = comparisonOperator;
			this.value = value;
		}

		public String toExpressionString() {
			return fieldName + ' ' + comparisonOperator + ' ' + formatValue();
		}

		@TestVisible
		private String formatValue() {
			if (value instanceof String) {
				return '\'' +
					String.escapeSingleQuotes(String.valueOf(value)) +
					'\'';
			} else if (
				value instanceof Integer ||
				value instanceof Long ||
				value instanceof Double ||
				value instanceof Decimal ||
				value instanceof Boolean
			) {
				return String.valueOf(value);
			} else if (value instanceof Date) {
				String dateString = String.valueOf(value);
				Integer indexOfTimePart = dateString.indexOf(' ');
				return indexOfTimePart > 0
					? dateString.substring(0, indexOfTimePart)
					: dateString;
			} else if (value instanceof Datetime) {
				Datetime d = (Datetime) value;
				return d.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ');
			} else if (value instanceof List<String>) {
				return '(' +
					String.join(
						convertToStringList((List<String>) value),
						', '
					) +
					')';
			} else if (value instanceof Set<String>) {
				return '(' +
					String.join(
						convertToStringList(
							new List<String>((Set<String>) value)
						),
						', '
					) +
					')';
			} else if (value instanceof Set<Id>) {
				return '(' +
					String.join(
						convertToStringList(new List<Id>((Set<Id>) value)),
						', '
					) +
					')';
			} else if (value instanceof List<Date>) {
				return '(' +
					String.join(convertToStringList((List<Date>) value), ', ') +
					')';
			} else if (value instanceof Set<Date>) {
				return '(' +
					String.join(
						convertToStringList(new List<Date>((Set<Date>) value)),
						', '
					) +
					')';
			} else if (value instanceof List<Datetime>) {
				return '(' +
					String.join(
						convertToStringList((List<Datetime>) value),
						', '
					) +
					')';
			} else if (value instanceof Set<Datetime>) {
				return '(' +
					String.join(
						convertToStringList(
							new List<Datetime>((Set<Datetime>) value)
						),
						', '
					) +
					')';
			} else if (value instanceof List<Integer>) {
				return '(' +
					String.join(
						convertToStringList((List<Integer>) value),
						', '
					) +
					')';
			} else if (value instanceof Set<Integer>) {
				return '(' +
					String.join(
						convertToStringList(
							new List<Integer>((Set<Integer>) value)
						),
						', '
					) +
					')';
			} else if (value instanceof List<Long>) {
				return '(' +
					String.join(convertToStringList((List<Long>) value), ', ') +
					')';
			} else if (value instanceof Set<Long>) {
				return '(' +
					String.join(
						convertToStringList(new List<Long>((Set<Long>) value)),
						', '
					) +
					')';
			} else if (value instanceof List<Double>) {
				return '(' +
					String.join(
						convertToStringList((List<Double>) value),
						', '
					) +
					')';
			} else if (value instanceof Set<Double>) {
				return '(' +
					String.join(
						convertToStringList(
							new List<Double>((Set<Double>) value)
						),
						', '
					) +
					')';
			} else if (value instanceof Set<Decimal>) {
				return '(' +
					String.join(
						convertToStringList(
							new List<Decimal>((Set<Decimal>) value)
						),
						', '
					) +
					')';
			} else if (value instanceof Set<Set<String>>) {
				return '(' +
					String.join(
						convertToStringList((Set<Set<String>>) value),
						', '
					) +
					')';
			} else if (value instanceof SOQL.Builder) {
				SOQL.Builder builder = (SOQL.Builder) value;
				SOQL query = builder.build();
				return '(' + query.getQueryString() + ')';
			} else if (value instanceof SOQL) {
				SOQL query = (SOQL) value;
				return '(' + query.getQueryString() + ')';
			} else if (value instanceof ScriptVariable) {
				ScriptVariable scriptVariable = (ScriptVariable) value;
				return scriptVariable.toScriptVariableString();
			} else if (value instanceof DateLiteral) {
				DateLiteral dateLiteral = (DateLiteral) value;
				return dateLiteral.toDateLiteralString();
			} else if (value == null) {
				return 'NULL';
			} else {
				throw new QueryException('Unsupported value: ' + value);
			}
		}

		private List<String> convertToStringList(List<Date> values) {
			List<String> dateValues = new List<String>();
			for (Date value : values) {
				String dateString = String.valueOf(value);
				Integer indexOfTimePart = dateString.indexOf(' ');
				dateValues.add(
					indexOfTimePart > 0
						? dateString.substring(0, indexOfTimePart)
						: dateString
				);
			}
			return dateValues;
		}

		private List<String> convertToStringList(List<Datetime> values) {
			List<String> datetimeValues = new List<String>();
			for (Datetime value : values) {
				Datetime d = (Datetime) value;
				datetimeValues.add(d.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
			}
			return datetimeValues;
		}

		private List<String> convertToStringList(List<String> values) {
			List<String> escapedValues = new List<String>();
			for (String value : values) {
				escapedValues.add(
					'\'' + String.escapeSingleQuotes(value) + '\''
				);
			}
			return escapedValues;
		}

		private List<String> convertToStringList(List<Id> values) {
			List<String> escapedValues = new List<String>();
			for (Id value : values) {
				escapedValues.add('\'' + String.valueOf(value) + '\'');
			}
			return escapedValues;
		}

		private List<String> convertToStringList(List<Integer> values) {
			List<String> escapedValues = new List<String>();
			for (Integer value : values) {
				escapedValues.add(String.valueOf(value));
			}
			return escapedValues;
		}

		private List<String> convertToStringList(List<Long> values) {
			List<String> escapedValues = new List<String>();
			for (Long value : values) {
				escapedValues.add(String.valueOf(value));
			}
			return escapedValues;
		}

		private List<String> convertToStringList(List<Decimal> values) {
			List<String> escapedValues = new List<String>();
			for (Decimal value : values) {
				escapedValues.add(String.valueOf(value));
			}
			return escapedValues;
		}

		private List<String> convertToStringList(List<Double> values) {
			List<String> escapedValues = new List<String>();
			for (Double value : values) {
				escapedValues.add(String.valueOf(value));
			}
			return escapedValues;
		}

		private List<String> convertToStringList(Set<Set<String>> values) {
			List<String> escapedValues = new List<String>();
			for (Set<String> valueGroup : values) {
				List<String> escapedGroupValues = new List<String>();
				for (String value : valueGroup) {
					escapedGroupValues.add(String.escapeSingleQuotes(value));
				}
				escapedValues.add(
					'\'' + String.join(escapedGroupValues, ';') + '\''
				);
			}
			return escapedValues;
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	@TestVisible
	private class ConditionExpression implements Expression {
		@TestVisible
		private Condition condition;

		@TestVisible
		private ConditionExpression(Condition condition) {
			this.condition = condition;
		}

		public String toExpressionString() {
			return '(' + condition.toConditionString() + ')';
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	@TestVisible
	private class ConditionDenialExpression implements Expression {
		@TestVisible
		private Condition condition;

		@TestVisible
		private ConditionDenialExpression(Condition condition) {
			this.condition = condition;
		}

		public String toExpressionString() {
			return 'NOT(' + condition.toConditionString() + ')';
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}

	public class QueryException extends Exception {
	}
}