# Apex Kit

> This readme covers things at a very high level. You can find more information about individual pieces, including design philosophy and code documentation in the wiki.

## What is Apex Kit?

I'm a woodworker by hobby. One of the unique things about woodworking, is we often spend a lot of time making Jigs. Jigs are ... job helpers, designed to make a tricky cut repeatable and safe. Making a tapered table leg? There's a jig for that. Need to drill the same hole in the same spot in 12 pieces of wood? There's a jig for that.

Apex kit is a series of 'jigs' to make Salesforce software development faster, safer and more repeatable. As such, nothing in this repository is truly necessary. You can write triggers without this (or any) trigger framework. You can harness Queueables, make queries and callouts etc. all without Apex kit. That said, Apex kit exists to keep us all from re-inventing the wheel. Can you use triggers without it's trigger framework? Yes, but this will save you time, and effort. Or at least that's the value prop.

That said, Apex Kit consists of a number of 'libraries' that can be used independently of one another, though they're designed to work together.

### Specifically Apex Kit contains:

-   Feature Flags: A library for gating features and functionality for specific users. Supports gating based on org wide on/off, permission sets and custom permissions.
-   Log: a bullet proof logging solution thats guaranteed to log, even when a transaction fails, or an exception occurs.
-   OrgShape: a class for inspecting the current runtime environment, and the features / functionality the org has enabled. This includes a number of polyfill methods to determine or synthesize information about your org.
-   Ouroboros - (Needs a better name): This is a library for developing Queueable jobs that self-re-enqueue until a given condition is met. In other words, this helps you build classes of work that can process massive quantities of data, one chunk at a time.
-   Polyfills: Polyfills contains methods Salesforce should have provided, but doesn't. Look here before implementing a method you _thought_ already existed only to find out Salesforce doesn't provide it.
-   Promises: This library helps you write chainable bits of discrete asynchronous work that are executed in order. Effectively, it provides developers Javascript Promises, but in Apex. Super powerful, and flexible, especially for long-chains of API calls.
-   Query Lib: A library for making SOQL and SOSL queries via a builder-style API / DSL. While not necessary, QueryLib queries enforce CRUD/FLS security. _this library is tightly coupled to Safely(see below), for now_
-   Quiddity: (I didn't name this one. That's on Salesforce) A library for inspecting the runtime execution context of the current transaction. Additionally provides gating functionality allowing developers using it to prevent code paths in select execution contexts. i.e.: don't run this code in a user-driven context.
-   Rest Library: This library provides a consistent abstraction for making REST callouts. Either on a one-off basis, or at on a complete API integration level. (see wiki for examples).
-   Safely: Safely has two parts - first, a user permission checking library called 'canTheUser' which helps developers determine crud and fls at runtime. The second part, 'Safely', wraps DML calls in Apex Security Decision objects - stripping fields and objects the user doesn't have access to. This library makes it super simple to safely make DML calls.
-   Test Utilities: Contains a test data factory, a HTTP Callout Mock factory, and a Stubbing library that enables developers to define a stub/mock declaratively, there in their test. Deprecates so much boilerplate.
-   Trigger Framework: is, well, a trigger framework. This one is controlled entirely through custom metadata and has built in support for per-user bypass. _helpful for mass data imports_
-   ULID: This is a library for generating Universally Unique Lexicographically Sortable Identifiers. These are similar in concept to UUID's but are sortable, because the first 10 digits are a Crockford encoded timestamp.

## Design Philosophy

Apex Kit strives to stick to the following design principes.

1. Be as simple as possible. But no simpler. - Which is to say, you may not find that ApexKit does everything you want, but you are probably unlikely to think Apex Kit's solutions are 'too heavy'.
2. Be as easy to use as possible. To that end, way to much thought has been put into method and class names. The goal is to build as close to an english-sentence like API. At times this isn't exactly possible. For instance, Safely's API for DML Insert sadly can't simply be called `insert` because `insert` is a reserved word. So Safely's method name for insert is `doInsert`.
3. Be as declarative as possible. - Apex Kit makes heavy use of the Builder pattern, or Fluent interface.This makes use of these libraries very expressive and declarative.
4. Where possible, be configurable outside of code. Thus, much of what Apex Kit brings to the table over other libraries is the use of Custom Metadata Type records for configuration.
5. (Working on this one) Consistent api for extensions.

## Why Apex Kit?

There's a ton of really good open source Apex libraries. Stalwarts of the community like NovaLog or FFLib. There's nothing wrong with these and I didn't create Apex Kit because they're bad/wrong/deficient.

Much of Apex Kit started out life as parts of my work for Apex Recipes when I worked as a Salesforce Developer Advocate (I got better). Apex Recipes is designed to be "teaching code". Ie: code that may not be the most useful, in production, but helps teach developers to use the platform and the Apex language. Apex Kit is the production ready version of that teaching code; plus some extras.

I recognize there's plenty of ways to solve just about any problem, and I'm not so arrogant to believe Apex Kit's the best, or only way to solve these problems. I do, however, have enough of an ego to think Apex Kit is a _good set_ of solutions.
