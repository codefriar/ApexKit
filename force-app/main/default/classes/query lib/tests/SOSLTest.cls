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
@IsTest
public with sharing class SOSLTest {
	@TestSetup
	private static void testSetup() {
		Profile systemAdminProfile = [
			SELECT Id
			FROM Profile
			WHERE Name = 'System Administrator'
		];
		User admin = new User(
			Username = 'adminTestUser@queryTest.com',
			LastName = 'LastName',
			Email = 'adminTestUser@queryTest.com',
			Alias = 'atu',
			TimeZoneSidKey = 'Europe/Dublin',
			LocaleSidKey = 'en_IE_EURO',
			EmailEncodingKey = 'ISO-8859-1',
			LanguageLocaleKey = 'en_US',
			ProfileId = systemAdminProfile.Id
		);
		insert admin;

		System.runAs(admin) {
			insert new List<Account>{
				new Account(Name = 'Test 1'),
				new Account(Name = 'Test 2')
			};
		}
	}

	@IsTest
	private static void testSOSLBuilderWithSearchPhrase() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String searchPhrase = 'Test';

			Test.startTest();

			SOSL.Builder builder = new SOSL.Builder(searchPhrase);

			Test.stopTest();

			Assert.areEqual(
				new Query.SearchCondition().find(searchPhrase).toString(),
				builder.searchCondition.toString()
			);
			Assert.areEqual(null, builder.searchGroup);
			Assert.areEqual(
				new List<Query.ReturningFieldSpec>(),
				builder.returningFieldSpecs
			);
			Assert.areEqual(null, builder.division);
			Assert.areEqual(
				new List<SOSL.DataCategorySpec>(),
				builder.dataCategorySpecs
			);
			Assert.areEqual(null, builder.snippet);
			Assert.areEqual(new Set<String>(), builder.networkIds);
			Assert.areEqual(null, builder.pricebookId);
			Assert.areEqual(false, builder.withHighlight);
			Assert.areEqual(null, builder.snippetTargetLength);
			Assert.areEqual(null, builder.spellCorrection);
			Assert.areEqual(null, builder.numberOfRows);
			Assert.areEqual(new Set<String>(), builder.statementUpdate);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithSearchCondition() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.SearchCondition searchCondition = new Query.SearchCondition(
					Query.LogicalOperator.OR_VALUE
				)
				.find('Test1')
				.find('Test2');

			Test.startTest();

			SOSL.Builder builder = new SOSL.Builder(searchCondition);

			Test.stopTest();

			Assert.areEqual(
				searchCondition.toString(),
				builder.searchCondition.toString()
			);
			Assert.areEqual(null, builder.searchGroup);
			Assert.areEqual(
				new List<Query.ReturningFieldSpec>(),
				builder.returningFieldSpecs
			);
			Assert.areEqual(null, builder.division);
			Assert.areEqual(
				new List<SOSL.DataCategorySpec>(),
				builder.dataCategorySpecs
			);
			Assert.areEqual(null, builder.snippet);
			Assert.areEqual(new Set<String>(), builder.networkIds);
			Assert.areEqual(null, builder.pricebookId);
			Assert.areEqual(false, builder.withHighlight);
			Assert.areEqual(null, builder.snippetTargetLength);
			Assert.areEqual(null, builder.spellCorrection);
			Assert.areEqual(null, builder.numberOfRows);
			Assert.areEqual(new Set<String>(), builder.statementUpdate);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithSearchGroup() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.SearchGroup searchGroup = Query.SearchGroup.ALL;
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withSearchGroup(searchGroup);

			Test.stopTest();

			Assert.areEqual(searchGroup, builder.searchGroup);
		}
	}

	@IsTest
	private static void testSOSLBuilderAddReturningFieldSpec() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				Account.SObjectType
			);
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.addReturningFieldSpec(returningFieldSpec);

			Test.stopTest();

			Assert.areEqual(
				new List<Query.ReturningFieldSpec>{ returningFieldSpec },
				builder.returningFieldSpecs
			);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithDivision() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String division = 'Global';
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withDivision(division);

			Test.stopTest();

			Assert.areEqual(division, builder.division);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithDataCategoryAt() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String groupName = 'groupName';
			String category = 'category';
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withDataCategoryAt(groupName, category);

			Test.stopTest();

			Assert.areEqual(
				1,
				builder.dataCategorySpecs.size(),
				(builder.dataCategorySpecs).toString()
			);
			SOSL.DataCategorySpec dataCategorySpec = builder.dataCategorySpecs[0];
			Assert.areEqual(groupName, dataCategorySpec.groupName);
			Assert.areEqual('AT', dataCategorySpec.operator);
			Assert.areEqual(category, dataCategorySpec.category);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithDataCategoryAbove() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String groupName = 'groupName';
			String category = 'category';
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withDataCategoryAbove(groupName, category);

			Test.stopTest();

			Assert.areEqual(
				1,
				builder.dataCategorySpecs.size(),
				(builder.dataCategorySpecs).toString()
			);
			SOSL.DataCategorySpec dataCategorySpec = builder.dataCategorySpecs[0];
			Assert.areEqual(groupName, dataCategorySpec.groupName);
			Assert.areEqual('ABOVE', dataCategorySpec.operator);
			Assert.areEqual(category, dataCategorySpec.category);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithDataCategoryBelow() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String groupName = 'groupName';
			String category = 'category';
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withDataCategoryBelow(groupName, category);

			Test.stopTest();

			Assert.areEqual(
				1,
				builder.dataCategorySpecs.size(),
				(builder.dataCategorySpecs).toString()
			);
			SOSL.DataCategorySpec dataCategorySpec = builder.dataCategorySpecs[0];
			Assert.areEqual(groupName, dataCategorySpec.groupName);
			Assert.areEqual('BELOW', dataCategorySpec.operator);
			Assert.areEqual(category, dataCategorySpec.category);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithDataCategoryAboveOrBelow() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String groupName = 'groupName';
			String category = 'category';
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withDataCategoryAboveOrBelow(groupName, category);

			Test.stopTest();

			Assert.areEqual(
				1,
				builder.dataCategorySpecs.size(),
				(builder.dataCategorySpecs).toString()
			);
			SOSL.DataCategorySpec dataCategorySpec = builder.dataCategorySpecs[0];
			Assert.areEqual(groupName, dataCategorySpec.groupName);
			Assert.areEqual('ABOVE_OR_BELOW', dataCategorySpec.operator);
			Assert.areEqual(category, dataCategorySpec.category);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithHighlight() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withHighlight();

			Test.stopTest();

			System.assert(builder.withHighlight);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithNetworkId() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String networkId = 'networkId';
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withNetworkId(networkId);

			Test.stopTest();

			Assert.areEqual(new Set<String>{ networkId }, builder.networkIds);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithNetworkIdsList() {
		User admin = selectTestUser();
		System.runAs(admin) {
			List<String> networkIds = new List<String>{ 'networkId' };
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withNetworkIds(networkIds);

			Test.stopTest();

			System.assert(
				builder.networkIds.containsAll(networkIds),
				'Expected: ' + networkIds + ', Actual: ' + builder.networkIds
			);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithNetworkIdsSet() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Set<String> networkIds = new Set<String>{ 'networkId' };
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withNetworkIds(networkIds);

			Test.stopTest();

			System.assert(
				builder.networkIds.containsAll(networkIds),
				'Expected: ' + networkIds + ', Actual: ' + builder.networkIds
			);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithPricebookId() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String pricebookId = Test.getStandardPricebookId();
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withPricebookId(pricebookId);

			Test.stopTest();

			Assert.areEqual(pricebookId, builder.pricebookId);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithSnippet() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Integer snippetTargetLength = 100;
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withSnippet(snippetTargetLength);

			Test.stopTest();

			Assert.areEqual(snippetTargetLength, builder.snippetTargetLength);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithSpellCorrection() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Boolean isSpellCorrectionEnabled = false;
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.withSpellCorrection(isSpellCorrectionEnabled);

			Test.stopTest();

			Assert.areEqual(
				String.valueOf(isSpellCorrectionEnabled),
				builder.spellCorrection
			);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithScopeLimit() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Integer numberOfRows = 100;
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.setScopeLimit(numberOfRows);

			Test.stopTest();

			Assert.areEqual(numberOfRows, builder.numberOfRows);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithTrackingUpdate() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.setUpdateTracking();

			Test.stopTest();

			Assert.areEqual(
				new Set<String>{ 'TRACKING' },
				builder.statementUpdate
			);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithViewStatUpdate() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.startTest();

			builder.setUpdateViewStat();

			Test.stopTest();

			Assert.areEqual(
				new Set<String>{ 'VIEWSTAT' },
				builder.statementUpdate
			);
		}
	}

	@IsTest
	private static void testSOSLBuilderWithFindStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.SearchCondition searchCondition = new Query.SearchCondition(
					Query.LogicalOperator.OR_VALUE
				)
				.find('Test1')
				.find('Test2');
			SOSL.Builder builder = new SOSL.Builder(searchCondition);

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test1 OR Test2}';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithSearchGroupStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test')
				.withSearchGroup(Query.SearchGroup.ALL);

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test} IN ALL FIELDS';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithReturningStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test')
				.addReturningFieldSpec(
					new Query.ReturningFieldSpec(Account.SObjectType)
				)
				.addReturningFieldSpec(
					new Query.ReturningFieldSpec(Contact.SObjectType)
				);

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test} RETURNING Account, Contact';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithDivisionStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String division = 'Global';
			SOSL.Builder builder = new SOSL.Builder('Test')
				.withDivision(division);

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test} WITH DIVISION = \'Global\'';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithDataCategoryStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test')
				.withDataCategoryAt('groupName1', 'category1')
				.withDataCategoryAt('groupName2', 'category2');

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test} WITH DATA CATEGORY groupName1 AT category1 AND groupName2 AT category2';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithHighlightStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test').withHighlight();

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test} WITH HIGHLIGHT';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithNetworkStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Set<String> networkIds = new Set<String>{
				'networkId_1',
				'networkId_2'
			};
			SOSL.Builder builder = new SOSL.Builder('Test')
				.withNetworkIds(networkIds);

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test} WITH NETWORK IN (\'networkId_1\', \'networkId_2\')';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithPricebookIdStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String pricebookId = Test.getStandardPricebookId();
			SOSL.Builder builder = new SOSL.Builder('Test')
				.withPricebookId(pricebookId);

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString =
				'FIND {Test} WITH PricebookId = \'' +
				pricebookId +
				'\'';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithSnippetStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test').withSnippet(100);

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test} WITH SNIPPET (target_length = 100)';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithSpellCorrectionStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test')
				.withSpellCorrection(false);

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test} WITH SPELL_CORRECTION = FALSE';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithLimitStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test').setScopeLimit(100);

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test} LIMIT 100';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderWithUpdateStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SOSL.Builder builder = new SOSL.Builder('Test')
				.addReturningFieldSpec(new Query.ReturningFieldSpec('FAQ__kav'))
				.setUpdateTracking()
				.setUpdateViewStat();

			Test.startTest();

			SOSL query = builder.build();

			Test.stopTest();

			String expectedSoslQueryString = 'FIND {Test} RETURNING FAQ__kav UPDATE TRACKING, VIEWSTAT';
			Assert.areEqual(expectedSoslQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLBuilderToStringOverride() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Test.startTest();

			SOSL.Builder builder = new SOSL.Builder('Test');

			Test.stopTest();

			Assert.areEqual(JSON.serialize(builder), builder.toString());
		}
	}

	@IsTest
	private static void testSearchConditionConstructor() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Test.startTest();

			Query.SearchCondition searchCondition = new Query.SearchCondition();

			Test.stopTest();

			Assert.areEqual(
				Query.LogicalOperator.AND_VALUE,
				searchCondition.logicalOperator
			);
			Assert.areEqual(
				new List<Query.Expression>(),
				searchCondition.searchExpressions
			);
		}
	}

	@IsTest
	private static void testSearchConditionConstructorWithLogicalOperator() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.LogicalOperator logicalOperator = Query.LogicalOperator.OR_VALUE;

			Test.startTest();

			Query.SearchCondition searchCondition = new Query.SearchCondition(
				logicalOperator
			);

			Test.stopTest();

			Assert.areEqual(logicalOperator, searchCondition.logicalOperator);
			Assert.areEqual(
				new List<Query.Expression>(),
				searchCondition.searchExpressions
			);
		}
	}

	@IsTest
	private static void testSearchConditionFind() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String searchPhrase = 'Test';
			Query.SearchCondition searchCondition = new Query.SearchCondition();

			Test.startTest();

			searchCondition.find(searchPhrase);

			Test.stopTest();

			Assert.areEqual(1, searchCondition.searchExpressions.size());
			Query.Expression expression = searchCondition.searchExpressions[0];
			System.assert(
				expression instanceof Query.PhraseExpression,
				expression
			);
			Assert.areEqual(
				new Query.PhraseExpression(searchPhrase).toString(),
				expression.toString()
			);
		}
	}

	@IsTest
	private static void testSearchConditionSubSearchCondition() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.SearchCondition searchCondition = new Query.SearchCondition();
			Query.SearchCondition subSearchCondition = new Query.SearchCondition()
				.find('Tes');

			Test.startTest();

			searchCondition.subSearchCondition(subSearchCondition);

			Test.stopTest();

			Assert.areEqual(1, searchCondition.searchExpressions.size());
			Query.Expression expression = searchCondition.searchExpressions[0];
			System.assert(
				expression instanceof Query.SearchExpression,
				expression
			);
			Assert.areEqual(
				new Query.SearchExpression(subSearchCondition).toString(),
				expression.toString()
			);
		}
	}

	@IsTest
	private static void testSearchConditionNegateSubSearchCondition() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.SearchCondition searchCondition = new Query.SearchCondition();
			Query.SearchCondition subSearchCondition = new Query.SearchCondition()
				.find('Tes');

			Test.startTest();

			searchCondition.negateSubSearchCondition(subSearchCondition);

			Test.stopTest();

			Assert.areEqual(1, searchCondition.searchExpressions.size());
			Query.Expression expression = searchCondition.searchExpressions[0];
			System.assert(
				expression instanceof Query.DenialSearchExpression,
				expression
			);
			Assert.areEqual(
				new Query.DenialSearchExpression(subSearchCondition).toString(),
				expression.toString()
			);
		}
	}

	@IsTest
	private static void testSearchConditionToConditionString() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.SearchCondition searchCondition = new Query.SearchCondition(
				Query.LogicalOperator.OR_VALUE
			);

			Test.startTest();

			searchCondition
				.subSearchCondition(new Query.SearchCondition().find('Test1'))
				.subSearchCondition(new Query.SearchCondition().find('Test2'));

			Test.stopTest();

			Assert.areEqual(
				'(Test1) OR (Test2)',
				searchCondition.toConditionString()
			);
		}
	}

	@IsTest
	private static void testSearchConditionToConditionStringUnsupportedOperator() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String expectedErrorMessage = 'Unsupported operator: null';
			Query.SearchCondition searchCondition = new Query.SearchCondition(
				null
			);

			Test.startTest();

			try {
				searchCondition.toConditionString();
				System.assert(
					false,
					'Expected exception: ' + expectedErrorMessage
				);
			} catch (Query.QueryException exc) {
				Assert.areEqual(expectedErrorMessage, exc.getMessage());
			}

			Test.stopTest();
		}
	}

	@IsTest
	private static void testSearchConditionToStringOverride() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.SearchCondition searchCondition = new Query.SearchCondition(
				Query.LogicalOperator.OR_VALUE
			);

			Test.startTest();

			searchCondition
				.subSearchCondition(new Query.SearchCondition().find('Test1'))
				.subSearchCondition(new Query.SearchCondition().find('Test2'));

			Test.stopTest();

			Assert.areEqual(
				JSON.serialize(searchCondition),
				searchCondition.toString()
			);
		}
	}

	@IsTest
	private static void testReturningFieldSpecConstructorBySObjectType() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SObjectType objectType = Account.SObjectType;

			Test.startTest();

			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				objectType
			);

			Test.stopTest();

			Assert.areEqual(
				objectType.getDescribe().getName(),
				returningFieldSpec.objectTypeName
			);
			Assert.areEqual(
				new Set<String>(),
				returningFieldSpec.fieldsToSelect
			);
			Assert.areEqual(null, returningFieldSpec.listViewName);
			Assert.areEqual(
				new Query.Condition(Query.LogicalOperator.AND_VALUE).toString(),
				returningFieldSpec.whereCondition.toString()
			);
			Assert.areEqual(
				new List<Query.SortOrder>(),
				returningFieldSpec.sortOrders
			);
			Assert.areEqual(null, returningFieldSpec.numberOfRows);
			Assert.areEqual(null, returningFieldSpec.offset);
		}
	}

	@IsTest
	private static void testReturningFieldSpecConstructorBySObjectTypeName() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectTypeName = Account.SObjectType.getDescribe().getName();

			Test.startTest();

			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				objectTypeName
			);

			Test.stopTest();

			Assert.areEqual(objectTypeName, returningFieldSpec.objectTypeName);
			Assert.areEqual(
				new Set<String>(),
				returningFieldSpec.fieldsToSelect
			);
			Assert.areEqual(null, returningFieldSpec.listViewName);
			Assert.areEqual(
				new Query.Condition(Query.LogicalOperator.AND_VALUE).toString(),
				returningFieldSpec.whereCondition.toString()
			);
			Assert.areEqual(
				new List<Query.SortOrder>(),
				returningFieldSpec.sortOrders
			);
			Assert.areEqual(null, returningFieldSpec.numberOfRows);
			Assert.areEqual(null, returningFieldSpec.offset);
		}
	}

	@IsTest
	private static void testReturningFieldSpecSelectField() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SObjectType objectType = Account.SObjectType;
			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				objectType
			);

			String fieldName = Account.Name.getDescribe().getName();

			Test.startTest();

			returningFieldSpec.selectField(fieldName);

			Test.stopTest();

			Assert.areEqual(
				new Set<String>{ fieldName },
				returningFieldSpec.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testReturningFieldSpecSelectFieldsFromList() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SObjectType objectType = Account.SObjectType;
			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				objectType
			);

			List<String> fieldApiNames = new List<String>{
				Account.Name.getDescribe().getName()
			};

			Test.startTest();

			returningFieldSpec.selectFields(fieldApiNames);

			Test.stopTest();

			System.assert(
				returningFieldSpec.fieldsToSelect.containsAll(fieldApiNames),
				'Expected: ' +
					fieldApiNames +
					', Actual: ' +
					returningFieldSpec.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testReturningFieldSpecSelectFieldsFromSet() {
		User admin = selectTestUser();
		System.runAs(admin) {
			SObjectType objectType = Account.SObjectType;
			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				objectType
			);

			Set<String> fieldApiNames = new Set<String>{
				Account.Name.getDescribe().getName()
			};

			Test.startTest();

			returningFieldSpec.selectFields(fieldApiNames);

			Test.stopTest();

			System.assert(
				returningFieldSpec.fieldsToSelect.containsAll(fieldApiNames),
				'Expected: ' +
					fieldApiNames +
					', Actual: ' +
					returningFieldSpec.fieldsToSelect
			);
		}
	}

	// @IsTest
	// private static void testReturningFieldSpecSelectFieldsFromFieldSet(){
	//     User admin = selectTestUser();
	//     System.runAs(admin){
	//         SObjectType objectType = Account.SObjectType;
	//         Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(objectType);

	//         Schema.FieldSet fieldSet = SObjectType.Account.FieldSets.Test;

	//         Test.startTest();

	//         returningFieldSpec.selectFields(fieldSet);

	//         Test.stopTest();

	//         for (Schema.FieldSetMember field: fieldSet.getFields()) {
	//             System.assert(returningFieldSpec.fieldsToSelect.contains(field.getFieldPath()), returningFieldSpec.fieldsToSelect);
	//         }
	//     }
	// }

	@IsTest
	private static void testReturningFieldSpecUsingListView() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String listViewName = 'Recent';
			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				Account.SObjectType
			);

			Test.startTest();

			returningFieldSpec.usingListView(listViewName);

			Test.stopTest();

			Assert.areEqual(listViewName, returningFieldSpec.listViewName);
		}
	}

	@IsTest
	private static void testReturningFieldSpecWhereCondition() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				Account.SObjectType
			);
			Query.Condition condition = new Query.Condition()
				.equals(Account.AnnualRevenue.getDescribe().getName(), 1000);

			System.assert(
				returningFieldSpec.whereCondition.expressions.isEmpty()
			);

			Test.startTest();

			returningFieldSpec.whereCondition(condition);

			Test.stopTest();

			Assert.areEqual(
				1,
				returningFieldSpec.whereCondition.expressions.size()
			);
		}
	}

	@IsTest
	private static void testReturningFieldSpecOrderByWithDirectionAndNullRecordsOrder() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				Account.SObjectType
			);
			String fieldName = Account.Type.getDescribe().getName();
			Query.SortDirection direction = Query.SortDirection.DESCENDING;
			Query.SortNullRecords nullRecords = Query.SortNullRecords.LAST;

			Test.startTest();

			returningFieldSpec.orderBy(
				new Query.SortOrder(fieldName, direction, nullRecords)
			);

			Test.stopTest();

			Assert.areEqual(1, returningFieldSpec.sortOrders.size());

			Query.SortOrder sortOrder = returningFieldSpec.sortOrders[0];
			Assert.areEqual(fieldName, sortOrder.fieldName);
			Assert.areEqual(direction, sortOrder.direction);
			Assert.areEqual(nullRecords, sortOrder.nullRecords);
		}
	}

	@IsTest
	private static void testReturningFieldSpecScopeLimit() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				Account.SObjectType
			);
			Integer scopeLimit = 100;

			Test.startTest();

			returningFieldSpec.scopeLimit(scopeLimit);

			Test.stopTest();

			Assert.areEqual(scopeLimit, returningFieldSpec.numberOfRows);
		}
	}

	@IsTest
	private static void testReturningFieldSpecOffset() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
				Account.SObjectType
			);
			Integer offset = 100;

			Test.startTest();

			returningFieldSpec.offset(offset);

			Test.stopTest();

			Assert.areEqual(offset, returningFieldSpec.offset);
		}
	}

	@IsTest
	private static void testReturningFieldSpecToReturningFieldSpecString() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Test.startTest();

			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
					Case.SObjectType
				)
				.selectField(Case.CreatedDate.getDescribe().getName())
				.selectFields(
					new List<String>{ Case.AccountId.getDescribe().getName() }
				)
				.selectFields(
					new Set<String>{ Case.OwnerId.getDescribe().getName() }
				)
				.usingListView('Recent')
				.whereCondition(
					new Query.Condition()
						.equals(Case.IsClosed.getDescribe().getName(), false)
				)
				.orderBy(
					new Query.SortOrder(
						Case.CaseNumber.getDescribe().getName(),
						Query.SortDirection.DESCENDING
					)
				)
				.scopeLimit(100)
				.offset(0);

			Test.stopTest();

			String expectedReturningFieldSpecString =
				'Case (' +
				'CreatedDate, AccountId, OwnerId' +
				' USING LISTVIEW = Recent' +
				' WHERE (IsClosed = false)' +
				' ORDER BY CaseNumber DESC' +
				' LIMIT 100' +
				' OFFSET 0' +
				')';

			Assert.areEqual(
				expectedReturningFieldSpecString,
				returningFieldSpec.toReturningFieldSpecString()
			);
		}
	}

	@IsTest
	private static void testReturningFieldSpecToStringOverride() {
		User admin = selectTestUser();
		System.runAs(admin) {
			Test.startTest();

			Query.ReturningFieldSpec returningFieldSpec = new Query.ReturningFieldSpec(
					Case.SObjectType
				)
				.selectField(Case.CreatedDate.getDescribe().getName())
				.selectFields(
					new List<String>{ Case.AccountId.getDescribe().getName() }
				)
				.selectFields(
					new Set<String>{ Case.OwnerId.getDescribe().getName() }
				)
				.usingListView('Recent')
				.whereCondition(
					new Query.Condition()
						.equals(Case.IsClosed.getDescribe().getName(), false)
				)
				.orderBy(
					new Query.SortOrder(
						Case.CaseNumber.getDescribe().getName(),
						Query.SortDirection.DESCENDING
					)
				)
				.scopeLimit(100)
				.offset(0);

			Test.stopTest();

			Assert.areEqual(
				JSON.serialize(returningFieldSpec),
				returningFieldSpec.toString()
			);
		}
	}

	@IsTest
	private static void testDataCategorySpecConstructor() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String groupName = 'groupName';
			String operator = 'AT';
			String category = 'category';

			Test.startTest();

			SOSL.DataCategorySpec dataCategorySpec = new SOSL.DataCategorySpec(
				groupName,
				operator,
				category
			);

			Test.stopTest();

			Assert.areEqual(groupName, dataCategorySpec.groupName);
			Assert.areEqual(operator, dataCategorySpec.operator);
			Assert.areEqual(category, dataCategorySpec.category);
		}
	}

	@IsTest
	private static void testDataCategoryToDataCategorySpecString() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String groupName = 'groupName';
			String operator = 'AT';
			String category = 'category';

			Test.startTest();

			SOSL.DataCategorySpec dataCategorySpec = new SOSL.DataCategorySpec(
				groupName,
				operator,
				category
			);

			Test.stopTest();

			String expectedDataCategorySpecString =
				groupName +
				' ' +
				operator +
				' ' +
				category;
			Assert.areEqual(
				expectedDataCategorySpecString,
				dataCategorySpec.toDataCategorySpecString()
			);
		}
	}

	@IsTest
	private static void testDataCategoryToStringOverride() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String groupName = 'groupName';
			String operator = 'AT';
			String category = 'category';

			Test.startTest();

			SOSL.DataCategorySpec dataCategorySpec = new SOSL.DataCategorySpec(
				groupName,
				operator,
				category
			);

			Test.stopTest();

			Assert.areEqual(
				JSON.serialize(dataCategorySpec),
				dataCategorySpec.toString()
			);
		}
	}

	@IsTest
	private static void testSOSLConstructor() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'FIND {Test}';

			Test.startTest();

			SOSL soslQuery = new SOSL(queryString);

			Test.stopTest();

			Assert.areEqual(queryString, soslQuery.queryString);
		}
	}

	@IsTest
	private static void testSOSLGetQueryString() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'FIND {Test}';

			Test.startTest();

			SOSL soslQuery = new SOSL(queryString);

			Test.stopTest();

			Assert.areEqual(queryString, soslQuery.getQueryString());
		}
	}

	@IsTest
	private static void testSOSLQuery() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'FIND {Test} RETURNING Account(Name)';
			SOSL soslQuery = new SOSL(queryString);

			Test.startTest();

			List<List<SObject>> results = soslQuery.query();

			Test.stopTest();

			List<List<SObject>> expectedResults = Search.query(queryString);
			Assert.areEqual(expectedResults, results);
		}
	}

	@IsTest
	private static void testSOSLFind() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'FIND {Test} RETURNING Account(Name)';
			SOSL soslQuery = new SOSL(queryString);

			Test.startTest();

			Search.SearchResults results = soslQuery.find();

			Test.stopTest();

			Search.SearchResults expectedResults = Search.find(queryString);
			Assert.areNotEqual(null, expectedResults);
			Assert.areNotEqual(null, results);
			Assert.areEqual(
				expectedResults.get('Account'),
				results.get('Account')
			);
		}
	}

	@IsTest
	private static void testSOSLToStringOverride() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'FIND {Test}';

			Test.startTest();

			SOSL soslQuery = new SOSL(queryString);

			Test.stopTest();

			Assert.areEqual(JSON.serialize(soslQuery), soslQuery.toString());
		}
	}

	private static User selectTestUser() {
		return [
			SELECT Id
			FROM User
			WHERE Username = 'adminTestUser@queryTest.com'
		];
	}
}