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

            System.assertEquals(
                new Query.SearchCondition().find(searchPhrase).toString(),
                builder.searchCondition.toString()
            );
            System.assertEquals(null, builder.searchGroup);
            System.assertEquals(
                new List<Query.ReturningFieldSpec>(),
                builder.returningFieldSpecs
            );
            System.assertEquals(null, builder.division);
            System.assertEquals(
                new List<SOSL.DataCategorySpec>(),
                builder.dataCategorySpecs
            );
            System.assertEquals(null, builder.snippet);
            System.assertEquals(new Set<String>(), builder.networkIds);
            System.assertEquals(null, builder.pricebookId);
            System.assertEquals(false, builder.withHighlight);
            System.assertEquals(null, builder.snippetTargetLength);
            System.assertEquals(null, builder.spellCorrection);
            System.assertEquals(null, builder.numberOfRows);
            System.assertEquals(new Set<String>(), builder.statementUpdate);
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

            System.assertEquals(
                searchCondition.toString(),
                builder.searchCondition.toString()
            );
            System.assertEquals(null, builder.searchGroup);
            System.assertEquals(
                new List<Query.ReturningFieldSpec>(),
                builder.returningFieldSpecs
            );
            System.assertEquals(null, builder.division);
            System.assertEquals(
                new List<SOSL.DataCategorySpec>(),
                builder.dataCategorySpecs
            );
            System.assertEquals(null, builder.snippet);
            System.assertEquals(new Set<String>(), builder.networkIds);
            System.assertEquals(null, builder.pricebookId);
            System.assertEquals(false, builder.withHighlight);
            System.assertEquals(null, builder.snippetTargetLength);
            System.assertEquals(null, builder.spellCorrection);
            System.assertEquals(null, builder.numberOfRows);
            System.assertEquals(new Set<String>(), builder.statementUpdate);
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

            System.assertEquals(searchGroup, builder.searchGroup);
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

            System.assertEquals(
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

            System.assertEquals(division, builder.division);
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

            System.assertEquals(
                1,
                builder.dataCategorySpecs.size(),
                builder.dataCategorySpecs
            );
            SOSL.DataCategorySpec dataCategorySpec = builder.dataCategorySpecs[0];
            System.assertEquals(groupName, dataCategorySpec.groupName);
            System.assertEquals('AT', dataCategorySpec.operator);
            System.assertEquals(category, dataCategorySpec.category);
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

            System.assertEquals(
                1,
                builder.dataCategorySpecs.size(),
                builder.dataCategorySpecs
            );
            SOSL.DataCategorySpec dataCategorySpec = builder.dataCategorySpecs[0];
            System.assertEquals(groupName, dataCategorySpec.groupName);
            System.assertEquals('ABOVE', dataCategorySpec.operator);
            System.assertEquals(category, dataCategorySpec.category);
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

            System.assertEquals(
                1,
                builder.dataCategorySpecs.size(),
                builder.dataCategorySpecs
            );
            SOSL.DataCategorySpec dataCategorySpec = builder.dataCategorySpecs[0];
            System.assertEquals(groupName, dataCategorySpec.groupName);
            System.assertEquals('BELOW', dataCategorySpec.operator);
            System.assertEquals(category, dataCategorySpec.category);
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

            System.assertEquals(
                1,
                builder.dataCategorySpecs.size(),
                builder.dataCategorySpecs
            );
            SOSL.DataCategorySpec dataCategorySpec = builder.dataCategorySpecs[0];
            System.assertEquals(groupName, dataCategorySpec.groupName);
            System.assertEquals('ABOVE_OR_BELOW', dataCategorySpec.operator);
            System.assertEquals(category, dataCategorySpec.category);
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

            System.assertEquals(
                new Set<String>{ networkId },
                builder.networkIds
            );
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
                'Expected: ' +
                networkIds +
                ', Actual: ' +
                builder.networkIds
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
                'Expected: ' +
                networkIds +
                ', Actual: ' +
                builder.networkIds
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

            System.assertEquals(pricebookId, builder.pricebookId);
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

            System.assertEquals(
                snippetTargetLength,
                builder.snippetTargetLength
            );
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

            System.assertEquals(
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

            System.assertEquals(numberOfRows, builder.numberOfRows);
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

            System.assertEquals(
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

            System.assertEquals(
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
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
            System.assertEquals(
                expectedSoslQueryString,
                query.getQueryString()
            );
        }
    }

    @IsTest
    private static void testSOSLBuilderToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Test.startTest();

            SOSL.Builder builder = new SOSL.Builder('Test');

            Test.stopTest();

            System.assertEquals(JSON.serialize(builder), builder.toString());
        }
    }

    @IsTest
    private static void testSearchConditionConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Test.startTest();

            Query.SearchCondition searchCondition = new Query.SearchCondition();

            Test.stopTest();

            System.assertEquals(
                Query.LogicalOperator.AND_VALUE,
                searchCondition.logicalOperator
            );
            System.assertEquals(
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

            System.assertEquals(
                logicalOperator,
                searchCondition.logicalOperator
            );
            System.assertEquals(
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

            System.assertEquals(1, searchCondition.searchExpressions.size());
            Query.Expression expression = searchCondition.searchExpressions[0];
            System.assert(
                expression instanceof Query.PhraseExpression,
                expression
            );
            System.assertEquals(
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

            System.assertEquals(1, searchCondition.searchExpressions.size());
            Query.Expression expression = searchCondition.searchExpressions[0];
            System.assert(
                expression instanceof Query.SearchExpression,
                expression
            );
            System.assertEquals(
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

            System.assertEquals(1, searchCondition.searchExpressions.size());
            Query.Expression expression = searchCondition.searchExpressions[0];
            System.assert(
                expression instanceof Query.DenialSearchExpression,
                expression
            );
            System.assertEquals(
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

            System.assertEquals(
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
                System.assertEquals(expectedErrorMessage, exc.getMessage());
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

            System.assertEquals(
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

            System.assertEquals(
                objectType.getDescribe().getName(),
                returningFieldSpec.objectTypeName
            );
            System.assertEquals(
                new Set<String>(),
                returningFieldSpec.fieldsToSelect
            );
            System.assertEquals(null, returningFieldSpec.listViewName);
            System.assertEquals(
                new Query.Condition(Query.LogicalOperator.AND_VALUE).toString(),
                returningFieldSpec.whereCondition.toString()
            );
            System.assertEquals(
                new List<Query.SortOrder>(),
                returningFieldSpec.sortOrders
            );
            System.assertEquals(null, returningFieldSpec.numberOfRows);
            System.assertEquals(null, returningFieldSpec.offset);
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

            System.assertEquals(
                objectTypeName,
                returningFieldSpec.objectTypeName
            );
            System.assertEquals(
                new Set<String>(),
                returningFieldSpec.fieldsToSelect
            );
            System.assertEquals(null, returningFieldSpec.listViewName);
            System.assertEquals(
                new Query.Condition(Query.LogicalOperator.AND_VALUE).toString(),
                returningFieldSpec.whereCondition.toString()
            );
            System.assertEquals(
                new List<Query.SortOrder>(),
                returningFieldSpec.sortOrders
            );
            System.assertEquals(null, returningFieldSpec.numberOfRows);
            System.assertEquals(null, returningFieldSpec.offset);
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

            System.assertEquals(
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

            System.assertEquals(listViewName, returningFieldSpec.listViewName);
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

            System.assertEquals(
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

            System.assertEquals(1, returningFieldSpec.sortOrders.size());

            Query.SortOrder sortOrder = returningFieldSpec.sortOrders[0];
            System.assertEquals(fieldName, sortOrder.fieldName);
            System.assertEquals(direction, sortOrder.direction);
            System.assertEquals(nullRecords, sortOrder.nullRecords);
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

            System.assertEquals(scopeLimit, returningFieldSpec.numberOfRows);
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

            System.assertEquals(offset, returningFieldSpec.offset);
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

            System.assertEquals(
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

            System.assertEquals(
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

            System.assertEquals(groupName, dataCategorySpec.groupName);
            System.assertEquals(operator, dataCategorySpec.operator);
            System.assertEquals(category, dataCategorySpec.category);
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
            System.assertEquals(
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

            System.assertEquals(
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

            System.assertEquals(queryString, soslQuery.queryString);
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

            System.assertEquals(queryString, soslQuery.getQueryString());
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
            System.assertEquals(expectedResults, results);
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
            System.assertNotEquals(null, expectedResults);
            System.assertNotEquals(null, results);
            System.assertEquals(
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

            System.assertEquals(
                JSON.serialize(soslQuery),
                soslQuery.toString()
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
