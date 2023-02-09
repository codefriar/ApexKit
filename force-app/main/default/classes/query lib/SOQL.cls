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
public inherited sharing class SOQL {
	@TestVisible
	private String queryString;

	@TestVisible
	private SOQL(String queryString) {
		this.queryString = queryString;
	}

	public String getQueryString() {
		return queryString;
	}

	public sObject getRecord() {
		return new Safely().doQuery(queryString).get(0);
		// return Database.query(queryString);
	}

	public List<sObject> getRecords() {
		return new Safely().doQuery(queryString);
		// return Database.query(queryString);
	}

	public Database.QueryLocator getQueryLocator() {
		return Database.getQueryLocator(queryString);
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
		private List<Query.TypeOf> typeOfClauses;
		@TestVisible
		private Query.Scope scope;
		@TestVisible
		private Set<String> statementFor;
		@TestVisible
		private Set<String> statementUpdate;

		public Builder(String objectType) {
			this.objectType = objectType;
			fieldsToSelect = new Set<String>();
			whereCondition = new Query.Condition(
				Query.LogicalOperator.AND_VALUE
			);
			sortOrders = new List<Query.SortOrder>();
			typeOfClauses = new List<Query.TypeOf>();
			statementFor = new Set<String>();
			statementUpdate = new Set<String>();
		}

		public Builder selectField(String fieldApiName) {
			fieldsToSelect.add(fieldApiName);
			return this;
		}

		public Builder selectFields(List<String> fieldApiNames) {
			fieldsToSelect.addAll(fieldApiNames);
			return this;
		}

		public Builder selectFields(Set<String> fieldApiNames) {
			fieldsToSelect.addAll(fieldApiNames);
			return this;
		}

		public Builder selectFields(Schema.FieldSet fieldSet) {
			for (Schema.FieldSetMember field : fieldSet.getFields()) {
				fieldsToSelect.add(field.getFieldPath());
			}
			return this;
		}

		public Builder selectFields(FieldSelection selection) {
			fieldsToSelect.add('FIELDS(' + selection.name() + ')');
			return this;
		}

		public Builder selectAll() {
			return selectFields(FieldSelection.ALL);
		}

		public Builder selectCustom() {
			return selectFields(FieldSelection.CUSTOM);
		}

		public Builder SelectStandard() {
			return selectFields(FieldSelection.STANDARD);
		}

		public Builder addSubQuery(SOQL subQuery) {
			fieldsToSelect.add('(' + subQuery.getQueryString() + ')');
			return this;
		}

		public Builder addTypeOf(Query.TypeOf typeOfClause) {
			typeOfClauses.add(typeOfClause);
			return this;
		}

		public Builder whereCondition(Query.Condition condition) {
			this.whereCondition.subcondition(condition);
			return this;
		}

		public Builder addScope(Query.Scope scope) {
			this.scope = scope;
			return this;
		}

		public Builder orderBy(Query.SortOrder sortOrder) {
			sortOrders.add(sortOrder);
			return this;
		}

		public Builder setScopeLimit(Integer numberOfRows) {
			this.numberOfRows = numberOfRows;
			return this;
		}

		public Builder setOffset(Integer offset) {
			this.offset = offset;
			return this;
		}

		public Builder setForReference() {
			statementFor.add('REFERENCE');
			return this;
		}

		public Builder setForUpdate() {
			statementFor.add('UPDATE');
			return this;
		}

		public Builder setForView() {
			statementFor.add('VIEW');
			return this;
		}

		public Builder setUpdateTracking() {
			statementUpdate.add('TRACKING');
			return this;
		}

		public Builder setUpdateViewStat() {
			statementUpdate.add('VIEWSTAT');
			return this;
		}

		public SOQL build() {
			List<String> queryStatements = new List<String>();
			addSelectStatement(queryStatements);
			addFromStatement(queryStatements);
			addScopeStatement(queryStatements);
			addWhereStatement(queryStatements);
			addOrderByStatement(queryStatements);
			addLimitStatement(queryStatements);
			addOffsetStatement(queryStatements);
			addForStatement(queryStatements);
			addUpdateStatement(queryStatements);
			return new SOQL(String.join(queryStatements, ' '));
		}

		private void addSelectStatement(List<String> queryStatements) {
			List<String> fieldList = new List<String>(fieldsToSelect);
			for (Query.TypeOf to : typeOfClauses) {
				fieldList.add(to.toTypeOfString());
			}
			if (fieldList.isEmpty()) {
				fieldList.add('Id');
			}
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

		private void addScopeStatement(List<String> queryStatements) {
			if (scope != null) {
				queryStatements.add('USING SCOPE ' + scope.name());
			}
		}

		private void addForStatement(List<String> queryStatements) {
			if (!statementFor.isEmpty()) {
				queryStatements.add(
					'FOR ' + String.join(new List<String>(statementFor), ', ')
				);
			}
		}

		private void addUpdateStatement(List<String> queryStatements) {
			if (!statementUpdate.isEmpty()) {
				queryStatements.add(
					'UPDATE ' +
					String.join(new List<String>(statementUpdate), ', ')
				);
			}
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}
}