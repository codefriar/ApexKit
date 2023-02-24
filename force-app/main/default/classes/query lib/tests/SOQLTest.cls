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
public with sharing class SOQLTest {
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
	private static void testSOQLConstructor() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'SELECT Id FROM Account';

			Test.startTest();

			SOQL soqlQuery = new SOQL(queryString);

			Test.stopTest();

			Assert.areEqual(queryString, soqlQuery.queryString);
		}
	}

	@IsTest
	private static void testSOQLGetQueryString() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'SELECT Id FROM Account';

			Test.startTest();

			SOQL soqlQuery = new SOQL(queryString);

			Test.stopTest();

			Assert.areEqual(queryString, soqlQuery.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLGetRecord() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'SELECT Id FROM Account ORDER BY Name LIMIT 1';
			SOQL soqlQuery = new SOQL(queryString);

			Test.startTest();

			Account acc = (Account) soqlQuery.getRecord();

			Test.stopTest();

			Account expectedAccount = Database.query(queryString);
			Assert.areEqual(expectedAccount, acc);
		}
	}

	@IsTest
	private static void testSOQLGetRecords() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'SELECT Id FROM Account ORDER BY Name';
			SOQL soqlQuery = new SOQL(queryString);

			Test.startTest();

			List<Account> accounts = (List<Account>) soqlQuery.getRecords();

			Test.stopTest();

			List<Account> expectedAccounts = Database.query(queryString);
			Assert.areEqual(expectedAccounts, accounts);
		}
	}

	@IsTest
	private static void testSOQLGetQueryLocator() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'SELECT Id FROM Account ORDER BY Name';
			SOQL soqlQuery = new SOQL(queryString);

			Test.startTest();

			Database.QueryLocator queryLocator = soqlQuery.getQueryLocator();

			Test.stopTest();

			Database.QueryLocator expectedQueryLocator = Database.getQueryLocator(
				queryString
			);
			Assert.areEqual(
				expectedQueryLocator.getQuery(),
				queryLocator.getQuery()
			);
		}
	}

	@IsTest
	private static void testSOQLToStringOverride() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'SELECT Id FROM Account ORDER BY Name';

			Test.startTest();

			SOQL soqlQuery = new SOQL(queryString);

			Test.stopTest();

			Assert.areEqual(JSON.serialize(soqlQuery), soqlQuery.toString());
		}
	}

	@IsTest
	private static void testSOQLBuilderConstructor() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();

			Test.startTest();

			SOQL.Builder builder = new SOQL.Builder(objectType);

			Test.stopTest();

			Assert.areEqual(objectType, builder.objectType);
			Assert.areNotEqual(null, builder.whereCondition);
			Assert.areEqual(
				new Query.Condition(Query.LogicalOperator.AND_VALUE).toString(),
				builder.whereCondition.toString()
			);
			Assert.areEqual(new List<Query.SortOrder>(), builder.sortOrders);
			Assert.areEqual(null, builder.numberOfRows);
			Assert.areEqual(null, builder.offset);
			Assert.areEqual(new Set<String>(), builder.fieldsToSelect);
			Assert.areEqual(new List<Query.TypeOf>(), builder.typeOfClauses);
			Assert.areEqual(null, builder.scope);
			Assert.areEqual(new Set<String>(), builder.statementFor);
			Assert.areEqual(new Set<String>(), builder.statementUpdate);
		}
	}

	@IsTest
	private static void testSOQLBuilderSelectSingleField() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			String fieldName = Account.Name.getDescribe().getName();

			Test.startTest();

			builder.selectField(fieldName);

			Test.stopTest();

			System.assert(
				builder.fieldsToSelect.contains(fieldName),
				builder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderSelectFieldsAsList() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			List<String> fieldNames = new List<String>{
				Account.Name.getDescribe().getName(),
				Account.Type.getDescribe().getName()
			};

			Test.startTest();

			builder.selectFields(fieldNames);

			Test.stopTest();

			System.assert(
				builder.fieldsToSelect.containsAll(fieldNames),
				builder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderSelectFieldsAsSet() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Set<String> fieldNames = new Set<String>{
				Account.Name.getDescribe().getName(),
				Account.Type.getDescribe().getName()
			};

			Test.startTest();

			builder.selectFields(fieldNames);

			Test.stopTest();

			System.assert(
				builder.fieldsToSelect.containsAll(fieldNames),
				builder.fieldsToSelect
			);
		}
	}

	// @IsTest
	// private static void testSOQLBuilderSelectFieldsFromFieldSet(){
	//     User admin = selectTestUser();
	//     System.runAs(admin){
	//         String objectType = Account.SObjectType.getDescribe().getName();
	//         SOQL.Builder builder = new SOQL.Builder(objectType);

	//         Schema.FieldSet fieldSet = SObjectType.Account.FieldSets.Test;

	//         Test.startTest();

	//         builder.selectFields(fieldSet);

	//         Test.stopTest();

	//         for (Schema.FieldSetMember field: fieldSet.getFields()) {
	//             Assert.isTrue(builder.fieldsToSelect.contains(field.getFieldPath()), builder.fieldsToSelect);
	//         }
	//     }
	// }

	@IsTest
	private static void testSOQLBuilderAddSubQuery() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			SOQL contactsSubquery = new SOQL.Builder('Contacts').build();

			Test.startTest();

			builder.addSubQuery(contactsSubquery);

			Test.stopTest();

			String expectedSubQueryString =
				'(' +
				contactsSubquery.getQueryString() +
				')';
			Assert.isTrue(
				builder.fieldsToSelect.contains(expectedSubQueryString),
				'Expected Subquery: ' +
					expectedSubQueryString +
					' Actual Fields: ' +
					builder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderAddTypeOf() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Query.TypeOf ownerTypeOf = new Query.TypeOf('Owner')
				.whenSObjectType(
					User.SObjectType.getDescribe().getName(),
					new Set<String>{
						User.Id.getDescribe().getName(),
						User.Username.getDescribe().getName()
					}
				)
				.elseFieldList('Id');

			Test.startTest();

			builder.addTypeOf(ownerTypeOf);

			Test.stopTest();

			Assert.isTrue(
				builder.typeOfClauses.contains(ownerTypeOf),
				'Expected TypeOf: ' +
					ownerTypeOf +
					' Actual Type Of clauses: ' +
					builder.typeOfClauses
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderWhereCondition() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Query.Condition condition = new Query.Condition()
				.equals('Reason', 'Other');

			Test.startTest();

			builder.whereCondition(condition);

			Test.stopTest();

			Assert.areEqual(1, builder.whereCondition.expressions.size());

			Query.Expression expectedExpression = new Query.ConditionExpression(
				condition
			);
			Query.Expression actualExpression = builder.whereCondition.expressions[0];
			Assert.areEqual(
				expectedExpression.toExpressionString(),
				actualExpression.toExpressionString()
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderAddScope() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Query.Scope scope = Query.Scope.Everything;

			Test.startTest();

			builder.addScope(scope);

			Test.stopTest();

			Assert.areEqual(scope, builder.scope);
		}
	}

	@IsTest
	private static void testSOQLBuilderOrderBy() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			String field = Case.CreatedDate.getDescribe().getName();
			Query.SortDirection sortDirection = Query.SortDirection.DESCENDING;
			Query.SortNullRecords sortNullRecords = Query.SortNullRecords.LAST;
			Query.SortOrder expectedSortOrder = new Query.SortOrder(
				field,
				sortDirection,
				sortNullRecords
			);

			Test.startTest();

			builder.orderBy(expectedSortOrder);

			Test.stopTest();

			Assert.areEqual(1, builder.sortOrders.size());

			Query.SortOrder actualSortOrder = builder.sortOrders[0];
			Assert.areEqual(
				expectedSortOrder.toSortOrderString(),
				actualSortOrder.toSortOrderString()
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderSetScopeLimit() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Integer numberOfRows = 100;

			Test.startTest();

			builder.setScopeLimit(numberOfRows);

			Test.stopTest();

			Assert.areEqual(numberOfRows, builder.numberOfRows);
		}
	}

	@IsTest
	private static void testSOQLBuilderSetOffset() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Integer offset = 100;

			Test.startTest();

			builder.setOffset(offset);

			Test.stopTest();

			Assert.areEqual(offset, builder.offset);
		}
	}

	@IsTest
	private static void testSOQLBuilderSetForReference() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Test.startTest();

			builder.setForReference();

			Test.stopTest();

			System.assert(
				builder.statementFor.contains('REFERENCE'),
				builder.statementFor
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderSetForUpdate() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Test.startTest();

			builder.setForUpdate();

			Test.stopTest();

			System.assert(
				builder.statementFor.contains('UPDATE'),
				builder.statementFor
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderSetForView() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Test.startTest();

			builder.setForView();

			Test.stopTest();

			System.assert(
				builder.statementFor.contains('VIEW'),
				builder.statementFor
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderSetUpdateTracking() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Test.startTest();

			builder.setUpdateTracking();

			Test.stopTest();

			System.assert(
				builder.statementUpdate.contains('TRACKING'),
				builder.statementUpdate
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderSetUpdateViewStat() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Test.startTest();

			builder.setUpdateViewStat();

			Test.stopTest();

			System.assert(
				builder.statementUpdate.contains('VIEWSTAT'),
				builder.statementUpdate
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderWithSelectStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType)
				.selectField(Case.CreatedDate.getDescribe().getName())
				.selectFields(
					new List<String>{ Case.AccountId.getDescribe().getName() }
				)
				.selectFields(
					new Set<String>{ Case.OwnerId.getDescribe().getName() }
				)
				.addSubQuery(new SOQL.Builder('Contacts').build())
				.addTypeOf(
					new Query.TypeOf('Owner')
						.whenSObjectType(
							User.SObjectType.getDescribe().getName(),
							new Set<String>{
								User.Username.getDescribe().getName()
							}
						)
						.elseFieldList('Id')
				);

			Test.startTest();

			SOQL query = builder.build();

			Test.stopTest();

			String expectedSoqlQueryString =
				'SELECT CreatedDate, AccountId, OwnerId,' +
				' (SELECT Id FROM Contacts),' +
				' TYPEOF Owner WHEN User THEN Username ELSE Id END' +
				' FROM Case';

			Assert.areEqual(expectedSoqlQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLBuilderWithFromStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType);

			Test.startTest();

			SOQL query = builder.build();

			Test.stopTest();

			Assert.areEqual('SELECT Id FROM Case', query.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLBuilderWithScopeStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType)
				.addScope(Query.Scope.Everything);

			Test.startTest();

			SOQL query = builder.build();

			Test.stopTest();

			Assert.areEqual(
				'SELECT Id FROM Case USING SCOPE Everything',
				query.getQueryString()
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderWithWhereStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			List<String> caseReasons = new List<String>{ 'Other' };
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType)
				.whereCondition(
					new Query.Condition(Query.LogicalOperator.AND_VALUE)
						.equals(
							'Reason',
							new Query.ScriptVariable('caseReasons')
						)
						.equals('Origin', 'Phone')
				)
				.whereCondition(
					new Query.Condition(Query.LogicalOperator.OR_VALUE)
						.equals('Owner.Type', 'User')
						.equals(
							Case.CreatedDate.getDescribe().getName(),
							new Query.DateLiteral('LAST_N_DAYS', 100)
						)
				);

			Test.startTest();

			SOQL query = builder.build();

			Test.stopTest();

			String expectedSoqlQueryString =
				'SELECT Id FROM Case' +
				' WHERE (Reason = :caseReasons AND Origin = \'Phone\')' +
				' AND (Owner.Type = \'User\' OR CreatedDate = LAST_N_DAYS:100)';
			Assert.areEqual(expectedSoqlQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLBuilderWithOrderStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType)
				.orderBy(new Query.SortOrder('Origin'))
				.orderBy(
					new Query.SortOrder(
						'Reason',
						Query.SortDirection.DESCENDING
					)
				)
				.orderBy(
					new Query.SortOrder(
						'AccountId',
						Query.SortDirection.ASCENDING,
						Query.SortNullRecords.LAST
					)
				);

			Test.startTest();

			SOQL query = builder.build();

			Test.stopTest();

			String expectedSoqlQueryString = 'SELECT Id FROM Case ORDER BY Origin, Reason DESC, AccountId ASC NULLS LAST';
			Assert.areEqual(expectedSoqlQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLBuilderWithLimitStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType)
				.setScopeLimit(100);

			Test.startTest();

			SOQL query = builder.build();

			Test.stopTest();

			String expectedSoqlQueryString = 'SELECT Id FROM Case LIMIT 100';
			Assert.areEqual(expectedSoqlQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLBuilderWithOffsetStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType).setOffset(100);

			Test.startTest();

			SOQL query = builder.build();

			Test.stopTest();

			String expectedSoqlQueryString = 'SELECT Id FROM Case OFFSET 100';
			Assert.areEqual(expectedSoqlQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLBuilderWithForStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Case.SObjectType.getDescribe().getName();
			SOQL.Builder builder = new SOQL.Builder(objectType)
				.setForReference()
				.setForUpdate()
				.setForView();

			Test.startTest();

			SOQL query = builder.build();

			Test.stopTest();

			Assert.areEqual(
				'SELECT Id FROM Case FOR REFERENCE, UPDATE, VIEW',
				query.getQueryString()
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderWithUpdateStatement() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = 'FAQ__kav';
			SOQL.Builder builder = new SOQL.Builder(objectType)
				.setUpdateTracking()
				.setUpdateViewStat();

			Test.startTest();

			SOQL query = builder.build();

			Test.stopTest();

			Assert.areEqual(
				'SELECT Id FROM FAQ__kav UPDATE TRACKING, VIEWSTAT',
				query.getQueryString()
			);
		}
	}

	@IsTest
	private static void testSOQLBuilderToStringOverride() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = 'Account';

			Test.startTest();

			SOQL.Builder builder = new SOQL.Builder(objectType);

			Test.stopTest();

			Assert.areEqual(JSON.serialize(builder), builder.toString());
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