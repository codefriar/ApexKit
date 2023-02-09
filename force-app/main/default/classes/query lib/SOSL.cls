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
public inherited sharing class SOSL {
	@TestVisible
	private String queryString;

	@TestVisible
	private SOSL(String queryString) {
		this.queryString = queryString;
	}

	public String getQueryString() {
		return queryString;
	}

	public List<List<SObject>> query() {
		return Search.query(queryString);
	}

	public Search.SearchResults find() {
		return Search.find(queryString);
	}

	public override String toString() {
		return JSON.serialize(this);
	}

	public class Builder {
		@TestVisible
		private Query.SearchCondition searchCondition;
		@TestVisible
		private Query.SearchGroup searchGroup;
		@TestVisible
		private List<Query.ReturningFieldSpec> returningFieldSpecs;
		@TestVisible
		private String division;
		@TestVisible
		private List<DataCategorySpec> dataCategorySpecs;
		@TestVisible
		private String snippet;
		@TestVisible
		private Set<String> networkIds;
		@TestVisible
		private String pricebookId;
		@TestVisible
		private Boolean withHighlight;
		@TestVisible
		private Integer snippetTargetLength;
		@TestVisible
		private String spellCorrection;
		@TestVisible
		private Integer numberOfRows;
		@TestVisible
		private Set<String> statementUpdate;

		public Builder(String searchPhrase) {
			this(new Query.SearchCondition().find(searchPhrase));
		}

		public Builder(Query.SearchCondition searchCondition) {
			this.searchCondition = searchCondition;
			returningFieldSpecs = new List<Query.ReturningFieldSpec>();
			dataCategorySpecs = new List<DataCategorySpec>();
			withHighlight = false;
			statementUpdate = new Set<String>();
			networkIds = new Set<String>();
		}

		public Builder withSearchGroup(Query.SearchGroup searchGroup) {
			this.searchGroup = searchGroup;
			return this;
		}

		public Builder addReturningFieldSpec(
			Query.ReturningFieldSpec returningFieldSpec
		) {
			this.returningFieldSpecs.add(returningFieldSpec);
			return this;
		}

		public Builder withDivision(String division) {
			this.division = division;
			return this;
		}

		public Builder withDataCategoryAt(String groupName, String category) {
			dataCategorySpecs.add(
				new DataCategorySpec(groupName, 'AT', category)
			);
			return this;
		}

		public Builder withDataCategoryAbove(
			String groupName,
			String category
		) {
			dataCategorySpecs.add(
				new DataCategorySpec(groupName, 'ABOVE', category)
			);
			return this;
		}

		public Builder withDataCategoryBelow(
			String groupName,
			String category
		) {
			dataCategorySpecs.add(
				new DataCategorySpec(groupName, 'BELOW', category)
			);
			return this;
		}

		public Builder withDataCategoryAboveOrBelow(
			String groupName,
			String category
		) {
			dataCategorySpecs.add(
				new DataCategorySpec(groupName, 'ABOVE_OR_BELOW', category)
			);
			return this;
		}

		public Builder withHighlight() {
			this.withHighlight = true;
			return this;
		}

		public Builder withNetworkId(String networkId) {
			networkIds.add(networkId);
			return this;
		}

		public Builder withNetworkIds(List<String> networkIds) {
			this.networkIds.addAll(networkIds);
			return this;
		}

		public Builder withNetworkIds(Set<String> networkIds) {
			this.networkIds.addAll(networkIds);
			return this;
		}

		public Builder withPricebookId(String pricebookId) {
			this.pricebookId = pricebookId;
			return this;
		}

		public Builder withSnippet(Integer snippetTargetLength) {
			this.snippetTargetLength = snippetTargetLength;
			return this;
		}

		public Builder withSpellCorrection(Boolean isSpellCorrectionEnabled) {
			this.spellCorrection = String.valueOf(isSpellCorrectionEnabled);
			return this;
		}

		public Builder setScopeLimit(Integer numberOfRows) {
			this.numberOfRows = numberOfRows;
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

		public SOSL build() {
			List<String> queryStatements = new List<String>();
			addFindStatement(queryStatements);
			addSearchGroupStatement(queryStatements);
			addReturningStatement(queryStatements);
			addDivisionStatement(queryStatements);
			addDataCategoryStatement(queryStatements);
			addHighlightStatement(queryStatements);
			addNetworkStatement(queryStatements);
			addPricebookIdStatement(queryStatements);
			addSnippetStatement(queryStatements);
			addSpellCorrectionStatement(queryStatements);
			addLimitStatement(queryStatements);
			addUpdateStatement(queryStatements);
			return new SOSL(String.join(queryStatements, ' '));
		}

		private void addFindStatement(List<String> queryStatements) {
			queryStatements.add(
				'FIND {' + searchCondition.toConditionString() + '}'
			);
		}

		private void addSearchGroupStatement(List<String> queryStatements) {
			if (searchGroup != null) {
				queryStatements.add('IN ' + searchGroup.name() + ' FIELDS');
			}
		}

		private void addReturningStatement(List<String> queryStatements) {
			List<String> returningFieldSpecStrings = new List<String>();
			for (
				Query.ReturningFieldSpec returningFieldSpec : returningFieldSpecs
			) {
				returningFieldSpecStrings.add(
					returningFieldSpec.toReturningFieldSpecString()
				);
			}
			if (!returningFieldSpecStrings.isEmpty()) {
				queryStatements.add(
					'RETURNING ' + String.join(returningFieldSpecStrings, ', ')
				);
			}
		}

		private void addDivisionStatement(List<String> queryStatements) {
			if (String.isNotBlank(division)) {
				queryStatements.add('WITH DIVISION = \'' + division + '\'');
			}
		}

		private void addDataCategoryStatement(List<String> queryStatements) {
			List<String> dataCategoryStrings = new List<String>();
			for (DataCategorySpec dataCategorySpec : dataCategorySpecs) {
				dataCategoryStrings.add(
					dataCategorySpec.toDataCategorySpecString()
				);
			}
			if (!dataCategoryStrings.isEmpty()) {
				queryStatements.add(
					'WITH DATA CATEGORY ' +
					String.join(dataCategoryStrings, ' AND ')
				);
			}
		}

		private void addHighlightStatement(List<String> queryStatements) {
			if (withHighlight) {
				queryStatements.add('WITH HIGHLIGHT');
			}
		}

		private void addNetworkStatement(List<String> queryStatements) {
			if (!networkIds.isEmpty()) {
				List<String> processedNetworkIds = new List<String>();
				for (String networkId : networkIds) {
					processedNetworkIds.add('\'' + networkId + '\'');
				}
				queryStatements.add(
					'WITH NETWORK IN (' +
						String.join(
							new List<String>(processedNetworkIds),
							', '
						) +
						')'
				);
			}
		}

		private void addPricebookIdStatement(List<String> queryStatements) {
			if (String.isNotBlank(pricebookId)) {
				queryStatements.add(
					'WITH PricebookId = \'' + pricebookId + '\''
				);
			}
		}

		private void addSnippetStatement(List<String> queryStatements) {
			if (snippetTargetLength != null) {
				queryStatements.add(
					'WITH SNIPPET (target_length = ' + snippetTargetLength + ')'
				);
			}
		}

		private void addSpellCorrectionStatement(List<String> queryStatements) {
			if (String.isNotBlank(spellCorrection)) {
				queryStatements.add(
					'WITH SPELL_CORRECTION = ' + spellCorrection.toUpperCase()
				);
			}
		}

		private void addLimitStatement(List<String> queryStatements) {
			if (numberOfRows != null) {
				queryStatements.add('LIMIT ' + numberOfRows);
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

	@TestVisible
	private class DataCategorySpec {
		@TestVisible
		private String groupName;
		@TestVisible
		private String operator;
		@TestVisible
		private String category;

		@TestVisible
		private DataCategorySpec(
			String groupName,
			String operator,
			String category
		) {
			this.groupName = groupName;
			this.operator = operator;
			this.category = category;
		}

		public String toDataCategorySpecString() {
			return groupName + ' ' + operator + ' ' + category;
		}

		public override String toString() {
			return JSON.serialize(this);
		}
	}
}