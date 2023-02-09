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
public inherited sharing class SOQLAgregate {
	@TestVisible
	private String queryString;

	@TestVisible
	private SOQLAgregate(String queryString) {
		this.queryString = queryString;
	}

	public String getQueryString() {
		return queryString;
	}

	public List<AggregateResult> getAggregateResults() {
		return Database.query(queryString);
	}

	public override String toString() {
		return JSON.serialize(this);
	}

	public class Builder {
		@TestVisible
		private String objectType;
		@TestVisible
		private Set<String> fieldsToSelect;
		@TestVisible
		private Query.Condition whereCondition;
		@TestVisible
		private List<Query.SortOrder> sortOrders;
		@TestVisible
		private Integer numberOfRows;
		@TestVisible
		private Integer offset;
		@TestVisible
		private Set<String> groupByOptions;
		@TestVisible
		private Set<String> groupByRollupOptions;
		@TestVisible
		private Set<String> groupByCubeOptions;
		@TestVisible
		private Query.Condition havingCondition;

		public Builder(String objectType) {
			this.objectType = objectType;
			fieldsToSelect = new Set<String>();
			whereCondition = new Query.Condition(
				Query.LogicalOperator.AND_VALUE
			);
			sortOrders = new List<Query.SortOrder>();
			fieldsToSelect = new Set<String>();
			groupByOptions = new Set<String>();
			groupByRollupOptions = new Set<String>();
			groupByCubeOptions = new Set<String>();
			havingCondition = new Query.Condition(
				Query.LogicalOperator.AND_VALUE
			);
		}

		public Builder average(String fieldName) {
			fieldsToSelect.add('AVG(' + fieldName + ')');
			return this;
		}

		public Builder average(String fieldName, String alias) {
			fieldsToSelect.add('AVG(' + fieldName + ') ' + alias);
			return this;
		}

		public Builder count(String fieldName) {
			fieldsToSelect.add('COUNT(' + fieldName + ')');
			return this;
		}

		public Builder count(String fieldName, String alias) {
			fieldsToSelect.add('COUNT(' + fieldName + ') ' + alias);
			return this;
		}

		public Builder countDistinct(String fieldName) {
			fieldsToSelect.add('COUNT_DISTINCT(' + fieldName + ')');
			return this;
		}

		public Builder countDistinct(String fieldName, String alias) {
			fieldsToSelect.add('COUNT_DISTINCT(' + fieldName + ') ' + alias);
			return this;
		}

		public Builder minimum(String fieldName) {
			fieldsToSelect.add('MIN(' + fieldName + ')');
			return this;
		}

		public Builder minimum(String fieldName, String alias) {
			fieldsToSelect.add('MIN(' + fieldName + ') ' + alias);
			return this;
		}

		public Builder maximum(String fieldName) {
			fieldsToSelect.add('MAX(' + fieldName + ')');
			return this;
		}

		public Builder maximum(String fieldName, String alias) {
			fieldsToSelect.add('MAX(' + fieldName + ') ' + alias);
			return this;
		}

		public Builder sum(String fieldName) {
			fieldsToSelect.add('SUM(' + fieldName + ')');
			return this;
		}

		public Builder sum(String fieldName, String alias) {
			fieldsToSelect.add('SUM(' + fieldName + ') ' + alias);
			return this;
		}

		public Builder whereCondition(Query.Condition condition) {
			this.whereCondition.subcondition(condition);
			return this;
		}

		public Builder groupBy(String fieldName) {
			groupByOptions.add(fieldName);
			fieldsToSelect.add(fieldName);
			return this;
		}

		public Builder groupByRollup(String fieldName) {
			groupByRollupOptions.add(fieldName);
			fieldsToSelect.add(fieldName);
			fieldsToSelect.add('GROUPING(' + fieldName + ')');
			return this;
		}

		public Builder groupByRollup(String fieldName, String groupingAlias) {
			groupByRollupOptions.add(fieldName);
			fieldsToSelect.add(fieldName);
			fieldsToSelect.add('GROUPING(' + fieldName + ') ' + groupingAlias);
			return this;
		}

		public Builder groupByCube(String fieldName) {
			groupByCubeOptions.add(fieldName);
			fieldsToSelect.add(fieldName);
			fieldsToSelect.add('GROUPING(' + fieldName + ')');
			return this;
		}

		public Builder groupByCube(String fieldName, String groupingAlias) {
			groupByCubeOptions.add(fieldName);
			fieldsToSelect.add(fieldName);
			fieldsToSelect.add('GROUPING(' + fieldName + ') ' + groupingAlias);
			return this;
		}

		public Builder havingCondition(Query.Condition condition) {
			this.havingCondition.subcondition(condition);
			return this;
		}

		public Builder orderBy(Query.SortOrder sortOrder) {
			sortOrders.add(sortOrder);
			return this;
		}

		public Builder scopeLimit(Integer numberOfRows) {
			this.numberOfRows = numberOfRows;
			return this;
		}

		public Builder offset(Integer offset) {
			this.offset = offset;
			return this;
		}

		public SOQLAgregate build() {
			List<String> queryStatements = new List<String>();
			addSelectStatement(queryStatements);
			addFromStatement(queryStatements);
			addWhereStatement(queryStatements);
			addGroupByStatement(queryStatements);
			addHavingStatement(queryStatements);
			addOrderByStatement(queryStatements);
			addLimitStatement(queryStatements);
			addOffsetStatement(queryStatements);
			return new SOQLAgregate(String.join(queryStatements, ' '));
		}

		private void addSelectStatement(List<String> queryStatements) {
			List<String> fieldList = new List<String>(fieldsToSelect);
			queryStatements.add('SELECT ' + String.join(fieldList, ', '));
		}

		private void addFromStatement(List<String> queryStatements) {
			queryStatements.add('FROM ' + objectType);
		}

		private void addWhereStatement(List<String> queryStatements) {
			String whereConditionString = whereCondition.toConditionString();
			if (String.isNotBlank(whereConditionString)) {
				queryStatements.add('WHERE ' + whereConditionString);
			}
		}

		private void addOrderByStatement(List<String> queryStatements) {
			List<String> sortOrderStrings = new List<String>();
			for (Query.SortOrder so : sortOrders) {
				sortOrderStrings.add(so.toSortOrderString());
			}
			if (!sortOrderStrings.isEmpty()) {
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

		private void addGroupByStatement(List<String> queryStatements) {
			List<String> groupByStrings = new List<String>();
			groupByStrings.addAll(groupByOptions);
			if (!groupByRollupOptions.isEmpty()) {
				groupByStrings.add(
					'ROLLUP(' +
						String.join(
							new List<String>(groupByRollupOptions),
							', '
						) +
						')'
				);
			}
			if (!groupByCubeOptions.isEmpty()) {
				groupByStrings.add(
					'CUBE(' +
						String.join(
							new List<String>(groupByCubeOptions),
							', '
						) +
						')'
				);
			}
			if (!groupByStrings.isEmpty()) {
				queryStatements.add(
					'GROUP BY ' + String.join(groupByStrings, ', ')
				);
			}
		}

		private void addHavingStatement(List<String> queryStatements) {
			String havingConditionString = havingCondition.toConditionString();
			if (String.isNotBlank(havingConditionString)) {
				queryStatements.add('HAVING ' + havingConditionString);
			}
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}
}