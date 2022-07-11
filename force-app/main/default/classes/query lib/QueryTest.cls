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
public with sharing class QueryTest {
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
    private static void testFieldExpressionConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            String comparisonOperator = '=';
            Object value = 'Test';

            Test.startTest();

            Query.FieldExpression fieldExpression = new Query.FieldExpression(
                fieldName,
                comparisonOperator,
                value
            );

            Test.stopTest();

            System.assertEquals(fieldName, fieldExpression.fieldName);
            System.assertEquals(
                comparisonOperator,
                fieldExpression.comparisonOperator
            );
            System.assertEquals(value, fieldExpression.value);
        }
    }

    @IsTest
    private static void testFieldExpressionValueFormat() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Map<String, Object> expectedValueFormat2Value = new Map<String, Object>{
                'NULL' => null,
                '1' => Integer.valueOf(1),
                '100000000' => 100000000L,
                '1.23' => Double.valueOf(1.23),
                '3.21' => Decimal.valueOf('3.21'),
                'true' => true,
                '2020-06-08' => Date.newInstance(2020, 6, 8),
                '2020-06-08T01:02:03.000+0000' => Datetime.newInstanceGmt(
                    2020,
                    6,
                    8,
                    1,
                    2,
                    3
                ),
                '(\'a\', \'b\', \'c\', \'L\\\'Oreal\')' => new List<String>{
                    'a',
                    'b',
                    'c',
                    'L\'Oreal'
                }, //Single quotes must be escaped.
                '(\'a\', \'b\', \'c\', \'O\\\'Reilly Media\')' => new Set<String>{
                    'a',
                    'b',
                    'c',
                    'O\'Reilly Media'
                }, //Single quotes must be escaped.
                '(\'0055I000000O5b6QAC\', \'0055I000000O5b7QAC\')' => new List<Id>{
                    '0055I000000O5b6QAC',
                    '0055I000000O5b7QAC'
                },
                '(\'0055I000000O5b8QAC\', \'0055I000000O5b9QAC\')' => new Set<Id>{
                    '0055I000000O5b8QAC',
                    '0055I000000O5b9QAC'
                },
                '(2020-06-08, 2020-06-09)' => new List<Date>{
                    Date.newInstance(2020, 6, 8),
                    Date.newInstance(2020, 6, 9)
                },
                '(2020-06-01, 2020-06-02)' => new Set<Date>{
                    Date.newInstance(2020, 6, 1),
                    Date.newInstance(2020, 6, 2)
                },
                '(2020-06-08T00:02:03.000+0000, 2020-06-09T00:02:03.000+0000)' => new List<Datetime>{
                    Datetime.newInstance(2020, 6, 8, 1, 2, 3),
                    Datetime.newInstance(2020, 6, 9, 1, 2, 3)
                }, //Users time zone is (GMT+01:00) Irish Standard Time (Europe/Dublin).
                '(2020-06-01T00:02:03.000+0000, 2020-06-02T00:02:03.000+0000)' => new Set<Datetime>{
                    Datetime.newInstance(2020, 6, 1, 1, 2, 3),
                    Datetime.newInstance(2020, 6, 2, 1, 2, 3)
                }, //Users time zone is (GMT+01:00) Irish Standard Time (Europe/Dublin).
                '(1, 2)' => new List<Integer>{ 1, 2 },
                '(3, 4)' => new Set<Integer>{ 3, 4 },
                '(100000000, 200000000)' => new List<Long>{
                    100000000L,
                    200000000L
                },
                '(300000000, 400000000)' => new Set<Long>{
                    300000000L,
                    400000000L
                },
                '(1.1, 2.2)' => new List<Double>{ 1.1, 2.2 },
                '(3.3, 4.4)' => new Set<Double>{ 3.3, 4.4 },
                '(5.5, 6.6)' => new List<Decimal>{ 5.5, 6.6 },
                '(7.7, 8.8)' => new Set<Decimal>{ 7.7, 8.8 },
                '(\'L\\\'Oreal\', \'PV_2;PV_3;L\\\'Oreal\')' => new Set<Set<String>>{
                    new Set<String>{ 'L\'Oreal' }, //Single quotes must be escaped.
                    new Set<String>{ 'PV_2', 'PV_3', 'L\'Oreal' } //Single quotes must be escaped.
                },
                '(SELECT Id FROM Account)' => new SOQL.Builder('Account'),
                '(SELECT Id FROM Contact)' => new SOQL.Builder('Contact')
                    .build(),
                'LAST_N_DAYS:100' => new Query.DateLiteral('LAST_N_DAYS', 100),
                ':accountIds' => new Query.ScriptVariable('accountIds')
            };
            String fieldName = Account.Name.getDescribe().getName();
            String comparisonOperator = '=';

            Test.startTest();

            for (
                String expectedValueFormat : expectedValueFormat2Value.keySet()
            ) {
                Object value = expectedValueFormat2Value.get(
                    expectedValueFormat
                );
                Query.FieldExpression fieldExpression = new Query.FieldExpression(
                    fieldName,
                    comparisonOperator,
                    value
                );

                System.assertEquals(
                    expectedValueFormat,
                    fieldExpression.formatValue()
                );
            }

            Test.stopTest();
        }
    }

    @IsTest
    private static void testFieldExpressionValueFormatUnsupportedValue() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            String comparisonOperator = '=';
            Query.FieldExpression fieldExpression = new Query.FieldExpression(
                fieldName,
                comparisonOperator,
                admin
            );
            String expectedErrorMessage = 'Unsupported value: ' + admin;

            Test.startTest();

            try {
                fieldExpression.formatValue();
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
    private static void testFieldExpressionToExpressionString() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            String comparisonOperator = '=';
            Object value = 'Test';

            Test.startTest();

            Query.FieldExpression fieldExpression = new Query.FieldExpression(
                fieldName,
                comparisonOperator,
                value
            );

            Test.stopTest();

            String expectedExpressionString =
                fieldExpression.fieldName +
                ' ' +
                fieldExpression.comparisonOperator +
                ' ' +
                fieldExpression.formatValue();
            System.assertEquals(
                expectedExpressionString,
                fieldExpression.toExpressionString()
            );
        }
    }

    @IsTest
    private static void testFieldExpressionToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            String comparisonOperator = '=';
            Object value = 'Test';

            Test.startTest();

            Query.FieldExpression fieldExpression = new Query.FieldExpression(
                fieldName,
                comparisonOperator,
                value
            );

            Test.stopTest();

            System.assertEquals(
                JSON.serialize(fieldExpression),
                fieldExpression.toString()
            );
        }
    }

    @IsTest
    private static void testConditionExpressionConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.Condition condition = new Query.Condition()
                .equals('Name', 'test')
                .equals('Reason', 'Other');

            Test.startTest();

            Query.ConditionExpression conditionExpression = new Query.ConditionExpression(
                condition
            );

            Test.stopTest();

            System.assertEquals(condition, conditionExpression.condition);
        }
    }

    @IsTest
    private static void testConditionExpressionToExpressionString() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.Condition condition = new Query.Condition()
                .equals('Name', 'test')
                .equals('Reason', 'Other');

            Test.startTest();

            Query.ConditionExpression conditionExpression = new Query.ConditionExpression(
                condition
            );

            Test.stopTest();

            String expectedExpressionString =
                '(' +
                condition.toConditionString() +
                ')';
            System.assertEquals(
                expectedExpressionString,
                conditionExpression.toExpressionString()
            );
        }
    }

    @IsTest
    private static void testConditionExpressionToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.Condition condition = new Query.Condition()
                .equals('Name', 'test')
                .equals('Reason', 'Other');

            Test.startTest();

            Query.ConditionExpression conditionExpression = new Query.ConditionExpression(
                condition
            );

            Test.stopTest();

            System.assertEquals(
                JSON.serialize(conditionExpression),
                conditionExpression.toString()
            );
        }
    }

    @IsTest
    private static void testConditionDenialExpressionConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.Condition condition = new Query.Condition()
                .equals('Name', 'test')
                .equals('Reason', 'Other');

            Test.startTest();

            Query.ConditionDenialExpression conditionDenialExpression = new Query.ConditionDenialExpression(
                condition
            );

            Test.stopTest();

            System.assertEquals(condition, conditionDenialExpression.condition);
        }
    }

    @IsTest
    private static void testConditionDenialExpressionToExpressionString() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.Condition condition = new Query.Condition()
                .equals('Name', 'test')
                .equals('Reason', 'Other');

            Test.startTest();

            Query.ConditionDenialExpression conditionDenialExpression = new Query.ConditionDenialExpression(
                condition
            );

            Test.stopTest();

            String expectedExpressionString =
                'NOT(' +
                condition.toConditionString() +
                ')';
            System.assertEquals(
                expectedExpressionString,
                conditionDenialExpression.toExpressionString()
            );
        }
    }

    @IsTest
    private static void testConditionDenialExpressionToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.Condition condition = new Query.Condition()
                .equals('Name', 'test')
                .equals('Reason', 'Other');

            Test.startTest();

            Query.ConditionDenialExpression conditionDenialExpression = new Query.ConditionDenialExpression(
                condition
            );

            Test.stopTest();

            System.assertEquals(
                JSON.serialize(conditionDenialExpression),
                conditionDenialExpression.toString()
            );
        }
    }

    @IsTest
    private static void testDateLiteralConstructorForDateLiteralName() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String dateLiteralName = 'TODAY';

            Test.startTest();

            Query.DateLiteral dateLiteral = new Query.DateLiteral(
                dateLiteralName
            );

            Test.stopTest();

            System.assertEquals(dateLiteralName, dateLiteral.dateLiteralName);
            System.assertEquals(null, dateLiteral.numberOfUnits);
        }
    }

    @IsTest
    private static void testDateLiteralConstructorForDateLiteralNameWithNumberOfUnits() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String dateLiteralName = 'NEXT_N_DAYS';
            Integer numberOfDays = 100;

            Test.startTest();

            Query.DateLiteral dateLiteral = new Query.DateLiteral(
                dateLiteralName,
                numberOfDays
            );

            Test.stopTest();

            System.assertEquals(dateLiteralName, dateLiteral.dateLiteralName);
            System.assertEquals(numberOfDays, dateLiteral.numberOfUnits);
        }
    }

    @IsTest
    private static void testDateLiteralToDateLiteralStringForDateLiteralName() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String dateLiteralName = 'TODAY';

            Test.startTest();

            Query.DateLiteral dateLiteral = new Query.DateLiteral(
                dateLiteralName
            );

            Test.stopTest();

            System.assertEquals(
                dateLiteralName,
                dateLiteral.toDateLiteralString()
            );
        }
    }

    @IsTest
    private static void testDateLiteralToDateLiteralStringForDateLiteralNameWithNumberOfUnits() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String dateLiteralName = 'NEXT_N_DAYS';
            Integer numberOfDays = 100;

            Test.startTest();

            Query.DateLiteral dateLiteral = new Query.DateLiteral(
                dateLiteralName,
                numberOfDays
            );

            Test.stopTest();

            System.assertEquals(
                dateLiteralName +
                ':' +
                numberOfDays,
                dateLiteral.toDateLiteralString()
            );
        }
    }

    @IsTest
    private static void testDateLiteralToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String dateLiteralName = 'NEXT_N_DAYS';
            Integer numberOfDays = 100;

            Test.startTest();

            Query.DateLiteral dateLiteral = new Query.DateLiteral(
                dateLiteralName,
                numberOfDays
            );

            Test.stopTest();

            System.assertEquals(
                JSON.serialize(dateLiteral),
                dateLiteral.toString()
            );
        }
    }

    @IsTest
    private static void testScriptVariableConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String variableName = 'accountIds';

            Test.startTest();

            Query.ScriptVariable scriptVariable = new Query.ScriptVariable(
                variableName
            );

            Test.stopTest();

            System.assertEquals(variableName, scriptVariable.variableName);
        }
    }

    @IsTest
    private static void testScriptVariableToScriptVariableString() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String variableName = 'accountIds';

            Test.startTest();

            Query.ScriptVariable scriptVariable = new Query.ScriptVariable(
                variableName
            );

            Test.stopTest();

            System.assertEquals(
                ':' + variableName,
                scriptVariable.toScriptVariableString()
            );
        }
    }

    @IsTest
    private static void testScriptVariableToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String variableName = 'accountIds';

            Test.startTest();

            Query.ScriptVariable scriptVariable = new Query.ScriptVariable(
                variableName
            );

            Test.stopTest();

            System.assertEquals(
                JSON.serialize(scriptVariable),
                scriptVariable.toString()
            );
        }
    }

    @IsTest
    private static void testConditionDefaultConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Test.startTest();

            Query.Condition condition = new Query.Condition();

            Test.stopTest();

            System.assertEquals(
                QUERY.LogicalOperator.AND_VALUE,
                condition.logicalOperator
            );
            System.assertEquals(
                new List<Query.Expression>(),
                condition.expressions
            );
        }
    }

    @IsTest
    private static void testConditionParametrizedConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.LogicalOperator logicalOperator = QUERY.LogicalOperator.OR_VALUE;

            Test.startTest();

            Query.Condition condition = new Query.Condition(logicalOperator);

            Test.stopTest();

            System.assertEquals(logicalOperator, condition.logicalOperator);
            System.assertEquals(
                new List<Query.Expression>(),
                condition.expressions
            );
        }
    }

    @IsTest
    private static void testConditionEquals() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Name';
            Object value = 'test';

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .equals(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(fieldName, '=', value, condition);
        }
    }

    @IsTest
    private static void testConditionNotEquals() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Name';
            Object value = 'test';

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .notEquals(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(fieldName, '!=', value, condition);
        }
    }

    @IsTest
    private static void testConditionLessThan() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Amount';
            Object value = 1;

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .lessThan(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(fieldName, '<', value, condition);
        }
    }

    @IsTest
    private static void testConditionLessOrEqual() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Amount';
            Object value = 1;

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .lessOrEqual(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(fieldName, '<=', value, condition);
        }
    }

    @IsTest
    private static void testConditionGreaterThan() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Amount';
            Object value = 1;

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .greaterThan(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(fieldName, '>', value, condition);
        }
    }

    @IsTest
    private static void testConditionGreaterOrEquals() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Amount';
            Object value = 1;

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .greaterOrEqual(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(fieldName, '>=', value, condition);
        }
    }

    @IsTest
    private static void testConditionIsLike() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Name';
            Object value = 'A%';

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .isLike(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(fieldName, 'LIKE', value, condition);
        }
    }

    @IsTest
    private static void testConditionIsIn() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Name';
            Object value = new Set<String>{ 'Test_1', 'Test_2' };

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .isIn(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(fieldName, 'IN', value, condition);
        }
    }

    @IsTest
    private static void testConditionIsNotIn() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Name';
            Object value = new Set<String>{ 'Test_1', 'Test_2' };

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .isNotIn(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(
                fieldName,
                'NOT IN',
                value,
                condition
            );
        }
    }

    @IsTest
    private static void testConditionIncludesSetOfValueSets() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Status';
            Set<Set<String>> value = new Set<Set<String>>{
                new Set<String>{ 'PV_1', 'PV_2' }
            };

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .includes(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(
                fieldName,
                'INCLUDES',
                value,
                condition
            );
        }
    }

    @IsTest
    private static void testConditionIncludesValueSet() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Status';
            Set<String> value = new Set<String>{ 'PV_1', 'PV_2' };

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .includes(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(
                fieldName,
                'INCLUDES',
                value,
                condition
            );
        }
    }

    @IsTest
    private static void testConditionExcludesSetOfValueSets() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Status';
            Set<Set<String>> value = new Set<Set<String>>{
                new Set<String>{ 'PV_1', 'PV_2' }
            };

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .excludes(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(
                fieldName,
                'EXCLUDES',
                value,
                condition
            );
        }
    }

    @IsTest
    private static void testConditionExcludesValueSet() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = 'Status';
            Set<String> value = new Set<String>{ 'PV_1', 'PV_2' };

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .excludes(fieldName, value);

            Test.stopTest();

            assertFieldConditionExpression(
                fieldName,
                'EXCLUDES',
                value,
                condition
            );
        }
    }

    private static void assertFieldConditionExpression(
        String fieldName,
        String comparisonOperator,
        Object value,
        Query.Condition condition
    ) {
        System.assertEquals(
            1,
            condition.expressions.size(),
            'Expected only one condition expression.'
        );
        Query.Expression expression = condition.expressions[0];
        System.assert(expression instanceof Query.FieldExpression, expression);

        Query.FieldExpression fieldExpression = (Query.FieldExpression) expression;
        System.assertEquals(fieldName, fieldExpression.fieldName);
        System.assertEquals(
            comparisonOperator,
            fieldExpression.comparisonOperator
        );
        System.assertEquals(value, fieldExpression.value);
    }

    @IsTest
    private static void testConditionWithSubcondition() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.Condition subcondition = new Query.Condition();

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .subcondition(subcondition);

            Test.stopTest();

            System.assertEquals(
                1,
                condition.expressions.size(),
                'Expected only one condition expression.'
            );
            Query.Expression expression = condition.expressions[0];
            System.assert(
                expression instanceof Query.ConditionExpression,
                expression
            );

            Query.ConditionExpression conditionExpression = (Query.ConditionExpression) expression;
            System.assertEquals(subcondition, conditionExpression.condition);
        }
    }

    @IsTest
    private static void testConditionWithNegatedSubcondition() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.Condition subcondition = new Query.Condition();

            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .negateSubcondition(subcondition);

            Test.stopTest();

            System.assertEquals(
                1,
                condition.expressions.size(),
                'Expected only one condition expression.'
            );
            Query.Expression expression = condition.expressions[0];
            System.assert(
                expression instanceof Query.ConditionDenialExpression,
                expression
            );

            Query.ConditionDenialExpression conditionDenialExpression = (Query.ConditionDenialExpression) expression;
            System.assertEquals(
                subcondition,
                conditionDenialExpression.condition
            );
        }
    }

    @IsTest
    private static void testConditionConjunctionToExpressionString() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Test.startTest();

            Query.Condition condition = new Query.Condition()
                .equals('Reason', 'Other');

            Test.stopTest();

            String expectedConditionString = prepareExpectedConditionString(
                condition
            );
            System.assertEquals(
                expectedConditionString,
                condition.toConditionString()
            );
        }
    }

    @IsTest
    private static void testConditionDisjunctionToExpressionString() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Test.startTest();

            Query.Condition condition = new Query.Condition(
                    QUERY.LogicalOperator.OR_VALUE
                )
                .equals('Name', 'test')
                .equals('Reason', 'Other');

            Test.stopTest();

            String expectedConditionString = prepareExpectedConditionString(
                condition
            );
            System.assertEquals(
                expectedConditionString,
                condition.toConditionString()
            );
        }
    }

    @IsTest
    private static void testConditionToExpressionStringUnsupporterOperator() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.Condition condition = new Query.Condition(null)
                .equals('Name', 'test')
                .equals('Reason', 'Other');
            String expectedErrorMessage = 'Unsupported operator: null';

            Test.startTest();

            try {
                condition.toConditionString();
                System.assert(
                    false,
                    'Expected error message: ' + expectedErrorMessage
                );
            } catch (Query.QueryException exc) {
                System.assertEquals(expectedErrorMessage, exc.getMessage());
            }

            Test.stopTest();
        }
    }

    private static String prepareExpectedConditionString(
        Query.Condition condition
    ) {
        List<String> expressionStrings = new List<String>();
        for (Query.Expression e : condition.expressions) {
            expressionStrings.add(e.toExpressionString());
        }
        String expectedConditionString;
        switch on condition.logicalOperator {
            when AND_VALUE {
                expectedConditionString = String.join(
                    expressionStrings,
                    ' AND '
                );
            }
            when OR_VALUE {
                expectedConditionString = String.join(
                    expressionStrings,
                    ' OR '
                );
            }
        }
        return expectedConditionString;
    }

    @IsTest
    private static void testConditionToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Test.startTest();

            Query.Condition condition = new Query.Condition();

            Test.stopTest();

            System.assertEquals(
                JSON.serialize(condition),
                condition.toString()
            );
        }
    }

    @IsTest
    private static void testSortOrderConstructorFieldName() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();

            Test.startTest();

            Query.SortOrder sortOrder = new Query.SortOrder(fieldName);

            Test.stopTest();

            System.assertEquals(fieldName, sortOrder.fieldName);
            System.assertEquals(null, sortOrder.direction);
            System.assertEquals(null, sortOrder.nullRecords);
        }
    }

    @IsTest
    private static void testSortOrderConstructorSortDirection() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            Query.SortDirection sortDirection = Query.SortDirection.ASCENDING;

            Test.startTest();

            Query.SortOrder sortOrder = new Query.SortOrder(
                fieldName,
                sortDirection
            );

            Test.stopTest();

            System.assertEquals(fieldName, sortOrder.fieldName);
            System.assertEquals(sortDirection, sortOrder.direction);
            System.assertEquals(null, sortOrder.nullRecords);
        }
    }

    @IsTest
    private static void testSortOrderConstructorNullRecords() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            Query.SortDirection sortDirection = Query.SortDirection.ASCENDING;
            Query.SortNullRecords sortNullRecords = Query.SortNullRecords.LAST;

            Test.startTest();

            Query.SortOrder sortOrder = new Query.SortOrder(
                fieldName,
                sortDirection,
                sortNullRecords
            );

            Test.stopTest();

            System.assertEquals(fieldName, sortOrder.fieldName);
            System.assertEquals(sortDirection, sortOrder.direction);
            System.assertEquals(sortNullRecords, sortOrder.nullRecords);
        }
    }

    @IsTest
    private static void testSortOrderStringAscendingNullsLast() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            Query.SortDirection sortDirection = Query.SortDirection.ASCENDING;
            Query.SortNullRecords sortNullRecords = Query.SortNullRecords.LAST;

            Test.startTest();

            Query.SortOrder sortOrder = new Query.SortOrder(
                fieldName,
                sortDirection,
                sortNullRecords
            );

            Test.stopTest();

            String expectedSortOrderString = fieldName + ' ASC NULLS LAST';
            System.assertEquals(
                expectedSortOrderString,
                sortOrder.toSortOrderString()
            );
        }
    }

    @IsTest
    private static void testSortOrderStringAscendingNullsFirst() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            Query.SortDirection sortDirection = Query.SortDirection.ASCENDING;
            Query.SortNullRecords sortNullRecords = Query.SortNullRecords.FIRST;

            Test.startTest();

            Query.SortOrder sortOrder = new Query.SortOrder(
                fieldName,
                sortDirection,
                sortNullRecords
            );

            Test.stopTest();

            String expectedSortOrderString = fieldName + ' ASC NULLS FIRST';
            System.assertEquals(
                expectedSortOrderString,
                sortOrder.toSortOrderString()
            );
        }
    }

    @IsTest
    private static void testSortOrderStringDescendingNullsLast() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            Query.SortDirection sortDirection = Query.SortDirection.DESCENDING;
            Query.SortNullRecords sortNullRecords = Query.SortNullRecords.LAST;

            Test.startTest();

            Query.SortOrder sortOrder = new Query.SortOrder(
                fieldName,
                sortDirection,
                sortNullRecords
            );

            Test.stopTest();

            String expectedSortOrderString = fieldName + ' DESC NULLS LAST';
            System.assertEquals(
                expectedSortOrderString,
                sortOrder.toSortOrderString()
            );
        }
    }

    @IsTest
    private static void testSortOrderStringDescendingNullsFirst() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            Query.SortDirection sortDirection = Query.SortDirection.DESCENDING;
            Query.SortNullRecords sortNullRecords = Query.SortNullRecords.FIRST;

            Test.startTest();

            Query.SortOrder sortOrder = new Query.SortOrder(
                fieldName,
                sortDirection,
                sortNullRecords
            );

            Test.stopTest();

            String expectedSortOrderString = fieldName + ' DESC NULLS FIRST';
            System.assertEquals(
                expectedSortOrderString,
                sortOrder.toSortOrderString()
            );
        }
    }

    @IsTest
    private static void testSortOrderToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String fieldName = Account.Name.getDescribe().getName();
            Query.SortDirection sortDirection = Query.SortDirection.DESCENDING;
            Query.SortNullRecords sortNullRecords = Query.SortNullRecords.FIRST;

            Test.startTest();

            Query.SortOrder sortOrder = new Query.SortOrder(
                fieldName,
                sortDirection,
                sortNullRecords
            );

            Test.stopTest();

            System.assertEquals(
                JSON.serialize(sortOrder),
                sortOrder.toString()
            );
        }
    }

    @IsTest
    private static void testPhraseExpressionConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String searchPhrase = 'Test';

            Test.startTest();

            Query.PhraseExpression phraseExpression = new Query.PhraseExpression(
                searchPhrase
            );

            Test.stopTest();

            System.assertEquals(searchPhrase, phraseExpression.searchPhrase);
        }
    }

    @IsTest
    private static void testPhraseExpressionToExpressionString() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String searchPhrase = 'Test';

            Test.startTest();

            Query.PhraseExpression phraseExpression = new Query.PhraseExpression(
                searchPhrase
            );

            Test.stopTest();

            System.assertEquals(
                searchPhrase,
                phraseExpression.toExpressionString()
            );
        }
    }

    @IsTest
    private static void testPhraseExpressionToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String searchPhrase = 'Test';

            Test.startTest();

            Query.PhraseExpression phraseExpression = new Query.PhraseExpression(
                searchPhrase
            );

            Test.stopTest();

            System.assertEquals(
                JSON.serialize(phraseExpression),
                phraseExpression.toString()
            );
        }
    }

    @IsTest
    private static void testSearchExpressionConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.SearchCondition searchCondition = new Query.SearchCondition()
                .find('Test');

            Test.startTest();

            Query.SearchExpression searchExpression = new Query.SearchExpression(
                searchCondition
            );

            Test.stopTest();

            System.assertEquals(
                searchCondition,
                searchExpression.searchCondition
            );
        }
    }

    @IsTest
    private static void testSearchExpressionToExpressionString() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.SearchCondition searchCondition = new Query.SearchCondition()
                .find('Test');

            Test.startTest();

            Query.SearchExpression searchExpression = new Query.SearchExpression(
                searchCondition
            );

            Test.stopTest();

            String expectedExpressionString =
                '(' +
                searchCondition.toConditionString() +
                ')';
            System.assertEquals(
                expectedExpressionString,
                searchExpression.toExpressionString()
            );
        }
    }

    @IsTest
    private static void testSearchExpressionToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.SearchCondition searchCondition = new Query.SearchCondition()
                .find('Test');

            Test.startTest();

            Query.SearchExpression searchExpression = new Query.SearchExpression(
                searchCondition
            );

            Test.stopTest();

            System.assertEquals(
                JSON.serialize(searchExpression),
                searchExpression.toString()
            );
        }
    }

    @IsTest
    private static void testDenialSearchExpressionConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.SearchCondition searchCondition = new Query.SearchCondition()
                .find('Test');

            Test.startTest();

            Query.DenialSearchExpression denialSearchExpression = new Query.DenialSearchExpression(
                searchCondition
            );

            Test.stopTest();

            System.assertEquals(
                searchCondition,
                denialSearchExpression.searchCondition
            );
        }
    }

    @IsTest
    private static void testDenialSearchExpressionToExpressionString() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.SearchCondition searchCondition = new Query.SearchCondition()
                .find('Test');

            Test.startTest();

            Query.DenialSearchExpression denialSearchExpression = new Query.DenialSearchExpression(
                searchCondition
            );

            Test.stopTest();

            String expectedExpressionString =
                'NOT(' +
                searchCondition.toConditionString() +
                ')';
            System.assertEquals(
                expectedExpressionString,
                denialSearchExpression.toExpressionString()
            );
        }
    }

    @IsTest
    private static void testDenialSearchExpressionToStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            Query.SearchCondition searchCondition = new Query.SearchCondition()
                .find('Test');

            Test.startTest();

            Query.DenialSearchExpression denialSearchExpression = new Query.DenialSearchExpression(
                searchCondition
            );

            Test.stopTest();

            System.assertEquals(
                JSON.serialize(denialSearchExpression),
                denialSearchExpression.toString()
            );
        }
    }

    @IsTest
    private static void testTypeOfConstructor() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String polymorphicReference = 'Owner';

            Test.startTest();

            Query.TypeOf typeOf = new Query.TypeOf(polymorphicReference);

            Test.stopTest();

            System.assertEquals(
                polymorphicReference,
                typeOf.polymorphicReference
            );
            System.assertEquals(
                new Map<String, Set<String>>(),
                typeOf.sobjectType2FieldList
            );
            System.assertEquals(new Set<String>(), typeOf.elseFieldList);
        }
    }

    @IsTest
    private static void testTypeOfWhenSObjectTypeWithFieldSet() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String polymorphicReference = 'Owner';
            Map<String, Set<String>> sobjectType2FieldList = new Map<String, Set<String>>{
                User.SObjectType.getDescribe().getName() => new Set<String>{
                    User.Id.getDescribe().getName(),
                    User.Username.getDescribe().getName()
                },
                Group.SObjectType.getDescribe().getName() => new Set<String>{
                    Group.Id.getDescribe().getName(),
                    Group.DeveloperName.getDescribe().getName()
                }
            };

            Query.TypeOf typeOf = new Query.TypeOf(polymorphicReference);

            Test.startTest();

            for (String sobjectType : sobjectType2FieldList.keySet()) {
                Set<String> fields = sobjectType2FieldList.get(sobjectType);
                typeOf.whenSObjectType(sobjectType, fields);
            }

            Test.stopTest();

            System.assertEquals(
                polymorphicReference,
                typeOf.polymorphicReference
            );
            System.assertEquals(
                sobjectType2FieldList,
                typeOf.sobjectType2FieldList
            );
            System.assertEquals(new Set<String>(), typeOf.elseFieldList);
        }
    }

    @IsTest
    private static void testTypeOfWhenSObjectTypeWithFieldList() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String polymorphicReference = 'Owner';
            Map<String, List<String>> sobjectType2FieldList = new Map<String, List<String>>{
                User.SObjectType.getDescribe().getName() => new List<String>{
                    User.Id.getDescribe().getName(),
                    User.Username.getDescribe().getName()
                },
                Group.SObjectType.getDescribe().getName() => new List<String>{
                    Group.Id.getDescribe().getName(),
                    Group.DeveloperName.getDescribe().getName()
                }
            };

            Query.TypeOf typeOf = new Query.TypeOf(polymorphicReference);

            Test.startTest();

            for (String sobjectType : sobjectType2FieldList.keySet()) {
                List<String> fields = sobjectType2FieldList.get(sobjectType);
                typeOf.whenSObjectType(sobjectType, fields);
            }

            Test.stopTest();

            System.assertEquals(
                polymorphicReference,
                typeOf.polymorphicReference
            );
            System.assertEquals(
                JSON.serialize(sobjectType2FieldList),
                JSON.serialize(typeOf.sobjectType2FieldList)
            );
            System.assertEquals(new Set<String>(), typeOf.elseFieldList);
        }
    }

    @IsTest
    private static void testTypeOfElseFieldListWithFieldSet() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String polymorphicReference = 'Owner';
            Set<String> fields = new Set<String>{ 'Id', 'Name' };

            Query.TypeOf typeOf = new Query.TypeOf(polymorphicReference);

            Test.startTest();

            typeOf.elseFieldList(fields);

            Test.stopTest();

            System.assertEquals(
                polymorphicReference,
                typeOf.polymorphicReference
            );
            System.assertEquals(
                new Map<String, Set<String>>(),
                typeOf.sobjectType2FieldList
            );
            System.assertEquals(fields, typeOf.elseFieldList);
        }
    }

    @IsTest
    private static void testTypeOfElseFieldListWithFieldList() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String polymorphicReference = 'Owner';
            List<String> fields = new List<String>{ 'Id', 'Name' };

            Query.TypeOf typeOf = new Query.TypeOf(polymorphicReference);

            Test.startTest();

            typeOf.elseFieldList(fields);

            Test.stopTest();

            System.assertEquals(
                polymorphicReference,
                typeOf.polymorphicReference
            );
            System.assertEquals(
                new Map<String, Set<String>>(),
                typeOf.sobjectType2FieldList
            );
            System.assertEquals(
                JSON.serialize(fields),
                JSON.serialize(typeOf.elseFieldList)
            );
        }
    }

    @IsTest
    private static void testTypeOfElseFieldListWithSingleField() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String polymorphicReference = 'Owner';
            String elseField = 'Id';

            Query.TypeOf typeOf = new Query.TypeOf(polymorphicReference);

            Test.startTest();

            typeOf.elseFieldList(elseField);

            Test.stopTest();

            System.assertEquals(
                polymorphicReference,
                typeOf.polymorphicReference
            );
            System.assertEquals(
                new Map<String, Set<String>>(),
                typeOf.sobjectType2FieldList
            );
            System.assertNotEquals(null, typeOf.elseFieldList);
            System.assertEquals(1, typeOf.elseFieldList.size());
            System.assert(
                typeOf.elseFieldList.contains(elseField),
                typeOf.elseFieldList
            );
        }
    }

    @IsTest
    private static void testTypeOfString() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String polymorphicReference = 'Owner';
            Map<String, List<String>> sobjectType2FieldList = new Map<String, List<String>>{
                User.SObjectType.getDescribe().getName() => new List<String>{
                    User.Id.getDescribe().getName(),
                    User.Username.getDescribe().getName()
                },
                Group.SObjectType.getDescribe().getName() => new List<String>{
                    Group.Id.getDescribe().getName(),
                    Group.DeveloperName.getDescribe().getName()
                }
            };
            String elseField = 'Id';

            Query.TypeOf typeOf = new Query.TypeOf(polymorphicReference);

            Test.startTest();

            for (String sobjectType : sobjectType2FieldList.keySet()) {
                List<String> fields = sobjectType2FieldList.get(sobjectType);
                typeOf.whenSObjectType(sobjectType, fields);
            }
            typeOf.elseFieldList(elseField);

            Test.stopTest();

            String expectedTypeOfString =
                'TYPEOF ' +
                polymorphicReference +
                ' WHEN User THEN Id, Username WHEN Group THEN Id, DeveloperName ELSE Id END';
            System.assertEquals(expectedTypeOfString, typeOf.toTypeOfString());
        }
    }

    @IsTest
    private static void testTypeOftoStringOverride() {
        User admin = selectTestUser();
        System.runAs(admin) {
            String polymorphicReference = 'Owner';
            Map<String, List<String>> sobjectType2FieldList = new Map<String, List<String>>{
                User.SObjectType.getDescribe().getName() => new List<String>{
                    User.Id.getDescribe().getName(),
                    User.Username.getDescribe().getName()
                },
                Group.SObjectType.getDescribe().getName() => new List<String>{
                    Group.Id.getDescribe().getName(),
                    Group.DeveloperName.getDescribe().getName()
                }
            };
            String elseField = 'Id';

            Query.TypeOf typeOf = new Query.TypeOf(polymorphicReference);

            Test.startTest();

            for (String sobjectType : sobjectType2FieldList.keySet()) {
                List<String> fields = sobjectType2FieldList.get(sobjectType);
                typeOf.whenSObjectType(sobjectType, fields);
            }
            typeOf.elseFieldList(elseField);

            Test.stopTest();

            System.assertEquals(JSON.serialize(typeOf), typeOf.toString());
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
