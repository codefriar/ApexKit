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
public with sharing class SOQLAgregateTest {
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
	private static void testSOQLAgregateConstructor() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'SELECT COUNT(Id) FROM Account';

			Test.startTest();

			SOQLAgregate soqlQuery = new SOQLAgregate(queryString);

			Test.stopTest();

			Assert.areEqual(queryString, soqlQuery.queryString);
		}
	}

	@IsTest
	private static void testSOQLAgregateGetQueryString() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'SELECT COUNT(Id) FROM Account';

			Test.startTest();

			SOQLAgregate soqlQuery = new SOQLAgregate(queryString);

			Test.stopTest();

			Assert.areEqual(queryString, soqlQuery.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLAgregateGetAggregateResults() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'SELECT COUNT(Id) FROM Account';
			SOQLAgregate soqlQuery = new SOQLAgregate(queryString);

			Test.startTest();

			List<AggregateResult> agregatedResults = soqlQuery.getAggregateResults();

			Test.stopTest();

			List<AggregateResult> expectedAgregatedResults = Database.query(
				queryString
			);
			Assert.areEqual(expectedAgregatedResults, agregatedResults);
		}
	}

	@IsTest
	private static void testSOQLAgregateToStringOverride() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String queryString = 'SELECT COUNT(Id) FROM Account';

			Test.startTest();

			SOQLAgregate soqlQuery = new SOQLAgregate(queryString);

			Test.stopTest();

			Assert.areEqual(JSON.serialize(soqlQuery), soqlQuery.toString());
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderConstructor() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();

			Test.startTest();

			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.stopTest();

			Assert.areEqual(objectType, soqlAgregateBuilder.objectType);
			Assert.areNotEqual(null, soqlAgregateBuilder.whereCondition);
			Assert.areEqual(
				new Query.Condition(Query.LogicalOperator.AND_VALUE).toString(),
				soqlAgregateBuilder.whereCondition.toString()
			);
			Assert.areEqual(
				new List<Query.SortOrder>(),
				soqlAgregateBuilder.sortOrders
			);
			Assert.areEqual(null, soqlAgregateBuilder.numberOfRows);
			Assert.areEqual(null, soqlAgregateBuilder.offset);
			Assert.areEqual(
				new Set<String>(),
				soqlAgregateBuilder.fieldsToSelect
			);
			Assert.areEqual(
				new Set<String>(),
				soqlAgregateBuilder.groupByOptions
			);
			Assert.areEqual(
				new Set<String>(),
				soqlAgregateBuilder.groupByRollupOptions
			);
			Assert.areNotEqual(null, soqlAgregateBuilder.havingCondition);
			Assert.areEqual(
				new Query.Condition(Query.LogicalOperator.AND_VALUE).toString(),
				soqlAgregateBuilder.havingCondition.toString()
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderAverage() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.AnnualRevenue.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.average(fieldName);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat = 'AVG(' + fieldName + ')';
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderAverageWithAlias() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.AnnualRevenue.getDescribe().getName();
			String alias = 'AverageAnnualRevenue';
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.average(fieldName, alias);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat =
				'AVG(' +
				fieldName +
				') ' +
				alias;
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderCount() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.Id.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.count(fieldName);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat = 'COUNT(' + fieldName + ')';
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderCountWithAlias() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.Id.getDescribe().getName();
			String alias = 'NumberOfRecords';
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.count(fieldName, alias);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat =
				'COUNT(' +
				fieldName +
				') ' +
				alias;
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderCountDistinct() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.Type.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.countDistinct(fieldName);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat =
				'COUNT_DISTINCT(' +
				fieldName +
				')';
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderCountDistinctWithAlias() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.Type.getDescribe().getName();
			String alias = 'UniqueTypes';
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.countDistinct(fieldName, alias);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat =
				'COUNT_DISTINCT(' +
				fieldName +
				') ' +
				alias;
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderMinimum() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.AnnualRevenue.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.minimum(fieldName);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat = 'MIN(' + fieldName + ')';
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderMinimumWithAlias() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.AnnualRevenue.getDescribe().getName();
			String alias = 'MinimumAnnualRevenue';
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.minimum(fieldName, alias);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat =
				'MIN(' +
				fieldName +
				') ' +
				alias;
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderMaximum() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.AnnualRevenue.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.maximum(fieldName);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat = 'MAX(' + fieldName + ')';
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderMaximumWithAlias() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.AnnualRevenue.getDescribe().getName();
			String alias = 'MaximumAnnualRevenue';
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.maximum(fieldName, alias);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat =
				'MAX(' +
				fieldName +
				') ' +
				alias;
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderSum() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.AnnualRevenue.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.sum(fieldName);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat = 'SUM(' + fieldName + ')';
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderSumWithAlias() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			String fieldName = Account.AnnualRevenue.getDescribe().getName();
			String alias = 'TotalAnnualRevenue';
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);

			Test.startTest();

			soqlAgregateBuilder.sum(fieldName, alias);

			Test.stopTest();

			Assert.areNotEqual(null, soqlAgregateBuilder.fieldsToSelect);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());

			String expectedAgregateFunctionFormat =
				'SUM(' +
				fieldName +
				') ' +
				alias;
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					expectedAgregateFunctionFormat
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderAddWhereCondition() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);
			Query.Condition condition = new Query.Condition()
				.equals(Account.AnnualRevenue.getDescribe().getName(), 1000);

			System.assert(
				soqlAgregateBuilder.whereCondition.expressions.isEmpty()
			);

			Test.startTest();

			soqlAgregateBuilder.whereCondition(condition);

			Test.stopTest();

			Assert.areEqual(
				1,
				soqlAgregateBuilder.whereCondition.expressions.size()
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderGroupBy() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);
			String fieldName = Account.Type.getDescribe().getName();

			Test.startTest();

			soqlAgregateBuilder.groupBy(fieldName);

			Test.stopTest();

			Assert.areEqual(1, soqlAgregateBuilder.groupByOptions.size());
			System.assert(
				soqlAgregateBuilder.groupByOptions.contains(fieldName),
				soqlAgregateBuilder.groupByOptions
			);
			Assert.areEqual(1, soqlAgregateBuilder.fieldsToSelect.size());
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(fieldName),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderGroupByRollup() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);
			String fieldName = Account.Type.getDescribe().getName();

			Test.startTest();

			soqlAgregateBuilder.groupByRollup(fieldName);

			Test.stopTest();

			Assert.areEqual(1, soqlAgregateBuilder.groupByRollupOptions.size());
			System.assert(
				soqlAgregateBuilder.groupByRollupOptions.contains(fieldName),
				soqlAgregateBuilder.groupByRollupOptions
			);
			Assert.areEqual(2, soqlAgregateBuilder.fieldsToSelect.size());
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(fieldName),
				soqlAgregateBuilder.fieldsToSelect
			);
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					'GROUPING(' + fieldName + ')'
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderGroupByRollupWithGroupingAlias() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);
			String fieldName = Account.Type.getDescribe().getName();
			String groupingAlias = 'grpType';

			Test.startTest();

			soqlAgregateBuilder.groupByRollup(fieldName, groupingAlias);

			Test.stopTest();

			Assert.areEqual(1, soqlAgregateBuilder.groupByRollupOptions.size());
			System.assert(
				soqlAgregateBuilder.groupByRollupOptions.contains(fieldName),
				soqlAgregateBuilder.groupByRollupOptions
			);
			Assert.areEqual(2, soqlAgregateBuilder.fieldsToSelect.size());
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(fieldName),
				soqlAgregateBuilder.fieldsToSelect
			);
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					'GROUPING(' + fieldName + ') ' + groupingAlias
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderGroupByCube() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);
			String fieldName = Account.Type.getDescribe().getName();

			Test.startTest();

			soqlAgregateBuilder.groupByCube(fieldName);

			Test.stopTest();

			Assert.areEqual(1, soqlAgregateBuilder.groupByCubeOptions.size());
			System.assert(
				soqlAgregateBuilder.groupByCubeOptions.contains(fieldName),
				soqlAgregateBuilder.groupByCubeOptions
			);
			Assert.areEqual(2, soqlAgregateBuilder.fieldsToSelect.size());
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(fieldName),
				soqlAgregateBuilder.fieldsToSelect
			);
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					'GROUPING(' + fieldName + ')'
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderGroupByCubeWithGroupingAlias() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);
			String fieldName = Account.Type.getDescribe().getName();
			String groupingAlias = 'grpType';

			Test.startTest();

			soqlAgregateBuilder.groupByCube(fieldName, groupingAlias);

			Test.stopTest();

			Assert.areEqual(1, soqlAgregateBuilder.groupByCubeOptions.size());
			System.assert(
				soqlAgregateBuilder.groupByCubeOptions.contains(fieldName),
				soqlAgregateBuilder.groupByCubeOptions
			);
			Assert.areEqual(2, soqlAgregateBuilder.fieldsToSelect.size());
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(fieldName),
				soqlAgregateBuilder.fieldsToSelect
			);
			System.assert(
				soqlAgregateBuilder.fieldsToSelect.contains(
					'GROUPING(' + fieldName + ') ' + groupingAlias
				),
				soqlAgregateBuilder.fieldsToSelect
			);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderOrderByWithDirectionAndNullRecordsOrder() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);
			String fieldName = Account.Type.getDescribe().getName();
			Query.SortDirection direction = Query.SortDirection.DESCENDING;
			Query.SortNullRecords nullRecords = Query.SortNullRecords.LAST;

			Test.startTest();

			soqlAgregateBuilder.orderBy(
				new Query.SortOrder(fieldName, direction, nullRecords)
			);

			Test.stopTest();

			Assert.areEqual(1, soqlAgregateBuilder.sortOrders.size());

			Query.SortOrder sortOrder = soqlAgregateBuilder.sortOrders[0];
			Assert.areEqual(fieldName, sortOrder.fieldName);
			Assert.areEqual(direction, sortOrder.direction);
			Assert.areEqual(nullRecords, sortOrder.nullRecords);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderScopeLimit() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);
			Integer scopeLimit = 100;

			Test.startTest();

			soqlAgregateBuilder.scopeLimit(scopeLimit);

			Test.stopTest();

			Assert.areEqual(scopeLimit, soqlAgregateBuilder.numberOfRows);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderOffset() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
				objectType
			);
			Integer offset = 100;

			Test.startTest();

			soqlAgregateBuilder.offset(offset);

			Test.stopTest();

			Assert.areEqual(offset, soqlAgregateBuilder.offset);
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderBuildSOQLAgregateQuery() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
					objectType
				)
				.count('Id')
				.whereCondition(
					new Query.Condition().greaterThan('AnnualRevenue', 1000)
				)
				.groupBy('Type')
				.orderBy(new Query.SortOrder('Type'))
				.scopeLimit(10)
				.offset(0);

			Test.startTest();

			SOQLAgregate query = soqlAgregateBuilder.build();

			Test.stopTest();

			String expectedQueryString = 'SELECT COUNT(Id), Type FROM Account WHERE (AnnualRevenue > 1000) GROUP BY Type ORDER BY Type LIMIT 10 OFFSET 0';
			Assert.areEqual(expectedQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderBuildSOQLQueryGroupByRollup() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
					objectType
				)
				.count('Id')
				.whereCondition(
					new Query.Condition().greaterThan('AnnualRevenue', 1000)
				)
				.havingCondition(
					new Query.Condition().greaterThan('COUNT(Id)', 2)
				)
				.groupByRollup('Type')
				.orderBy(new Query.SortOrder('Type'))
				.scopeLimit(10)
				.offset(0);

			Test.startTest();

			SOQLAgregate query = soqlAgregateBuilder.build();

			Test.stopTest();

			String expectedQueryString = 'SELECT COUNT(Id), Type, GROUPING(Type) FROM Account WHERE (AnnualRevenue > 1000) GROUP BY ROLLUP(Type) HAVING (COUNT(Id) > 2) ORDER BY Type LIMIT 10 OFFSET 0';
			Assert.areEqual(expectedQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderBuildSOQLQueryGroupByCube() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();
			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
					objectType
				)
				.count('Id')
				.whereCondition(
					new Query.Condition().greaterThan('AnnualRevenue', 1000)
				)
				.groupByCube('Type')
				.orderBy(new Query.SortOrder('Type'))
				.scopeLimit(10)
				.offset(0);

			Test.startTest();

			SOQLAgregate query = soqlAgregateBuilder.build();

			Test.stopTest();

			String expectedQueryString = 'SELECT COUNT(Id), Type, GROUPING(Type) FROM Account WHERE (AnnualRevenue > 1000) GROUP BY CUBE(Type) ORDER BY Type LIMIT 10 OFFSET 0';
			Assert.areEqual(expectedQueryString, query.getQueryString());
		}
	}

	@IsTest
	private static void testSOQLAgregateBuilderToStringOverride() {
		User admin = selectTestUser();
		System.runAs(admin) {
			String objectType = Account.SObjectType.getDescribe().getName();

			Test.startTest();

			SOQLAgregate.Builder soqlAgregateBuilder = new SOQLAgregate.Builder(
					objectType
				)
				.count('Id')
				.whereCondition(
					new Query.Condition().greaterThan('AnnualRevenue', 1000)
				)
				.groupByCube('Type')
				.orderBy(new Query.SortOrder('Type'))
				.scopeLimit(10)
				.offset(0);

			Test.stopTest();

			Assert.areEqual(
				JSON.serialize(soqlAgregateBuilder),
				soqlAgregateBuilder.toString()
			);
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