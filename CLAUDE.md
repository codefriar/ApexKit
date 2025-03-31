# ApexKit Salesforce Integration - Dev Guide

## Tool Usage

- **Salesforce Operations:** ALWAYS use the `mcp__sfMcp` server tools for ALL Salesforce related work, including:
    - Apex testing: Use `mcp__sfMcp__sf_apex_run_test` instead of local sfdx/sf commands
    - Deployments: Use `mcp__sfMcp__sf_project_deploy_start` instead of local deploy commands
    - Org operations: Use `mcp__sfMcp__sf_org_*` tools for any org-related tasks
    - SOQL/SOSL queries: Use `mcp__sfMcp__sf_data_query` instead of local sfdx/sf commands
- **GitHub/Git Operations:** Use the `mcp__GitHub` server for all GitHub and Git related activities

## Commands (Only use if mcp\_\_sfMcp tools unavailable)

- **Lint:** `npm run lint` (ESLint for JS files)
- **Format:** `npm run prettier` (all files) | `npm run prettier:verify` (check only)
- **Test LWC:** `npm run test` | `npm run test:unit:watch` (watch mode) | `npm run test:unit:debug` (debug)

## Code Style

- **Formatting:** 120 char line limit, 4 space indentation
- **Naming:** camelCase for variables, methods, parameters (start lowercase)
- **Constants:** UPPER_SNAKE_CASE
- **Classes:** Start with uppercase, follow noun convention
- **Apex Tests:** Must include assert messages, use @isTest annotation
- **Security:** No hardcoded credentials, follow CRUD/FLS best practices
- **Documentation:** Required ApexDoc for public/protected methods and properties
- **Error Handling:** Check for null before isEmpty(), avoid triggers with logic

# Requirements

- All unit tests MUST include a system.runAs call, even for basic unit tests that don't interact with permissions.
- The runAs user should be appropriate for the context of the test.
- Each test method should start with system.runAs before any test assertions.
- Where possible, please use the Stub class and builder interface found in force-app/main/default/classes/ApexKit/Stub.cls for building mocks.
- The Stub class uses a fluent API style with a builder pattern. Example usage:
    ```apex
    StubObject fooStub = new StubObject.Builder('foo.class')
      .mockingMethodCall('someMethodName', List<Object> Params)
      .withParameterTypes()
      .returning() || .throwingException() || .throwingException(ExceptionObj)
      .mockingMethodCall('secondMethodName', ...)
      .withParameterTypes()
      .returning() || .throwingException() || .throwingException(ExceptionObj)
      .createStub()
    ```
- Each test method should be named according to the formula <type><UnitUnderTest><Positive/Negative> where Type is either Unit or Functional. Unit tests are not allowed to make actual DML, and must use mocks. Functional Tests can make DML calls through Repo classes.
- All DML (insert, update, upsert, delete, and queries) must take place in Repo classes that extend the BaseRepo class. Each sObject has it's own Repo class named <Sobject>Repo minus any '**c' suffix. For Instance AccountRepo or ContactRepo or for a custom object Foo**c it would be FooRepo.
