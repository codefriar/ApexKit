### [AsyncRestClient](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/AsyncRestClient)

wraps a restlib backed api call in a queueable context

### [AsyncRestLibFinalizer](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/AsyncRestLibFinalizer)

Abstract class defining a common interface with default implementation for finalizers handling
AsyncRestApi calls

### [BulkCallable](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/BulkCallable)

Provides a similar interface to Callable, but bulkified to handle multiple sets of parameters.

### [CAssert](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/CAssert)

### [CachePartitionType](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/CachePartitionType)

Enum for partition type.

### [CanTheUser](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/CanTheUser)

A reusable, intuitive library for determining whether or not the
current use can create, read, edit, or delete objects as well as
determining if the user has access or update permissions on specific fields.
This class name was chosen to facilitate easy-to-understand and read code.
Whenever you need&hellip;

### [CanTheUserTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/CanTheUserTests)

### [CrudType](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/CrudType)

### [CustomInvocable](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/CustomInvocable)

This class is an example of how to implement the Invocable Abstract Class.
It doesn't do much, but it does illustrate how BulkCallable, Invocable, UniversalInvocable, UniversalFlowInputOutput and
UniversalFlowInputOutputParameter work together to expose multiple methods to Flow.
Please understand t&hellip;

### [EnqueueNextQueueableProcessStep](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/EnqueueNextQueueableProcessStep)

This class implements the Apex Transaction Finalizer interface. It's used to implement promises. This
class is constructed with a list of QueueableProcess Objects, and any passthrough data. The first promise in the list
is executed. The QueueableProcess class automatically attaches this finalizer t&hellip;

### [ExampleQueueableProcessSteps](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/ExampleQueueableProcessSteps)

This class contains two inner classes used for testing the QueueableProcess framework.

### [FLSType](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/FLSType)

### [FailsafeExceptionHandler](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/FailsafeExceptionHandler)

This class is a polyfill for the handling exceptions. Rather than writing
boilerplate exception handling code everywhere, this class can be used to log exceptions.

### [FailsafeExceptionHandlerTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/FailsafeExceptionHandlerTests)

### [FeatureFlagCommonTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/FeatureFlagCommonTests)

Class serves to DRY code for various testing methods that
require it. It is not intended to be used directly.

### [FeatureFlagDataProviderTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/FeatureFlagDataProviderTests)

### [FeatureFlagTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/FeatureFlagTests)

### [FieldSelection](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/FieldSelection)

### [HttpCalloutMockFactory](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/HttpCalloutMockFactory)

### [HttpVerb](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/HttpVerb)

This ENUM lists possible HTTP Verbs. Note: 'Delete' is an Apex Keyword (DML)
and as a result, the ENUM value 'DEL' is used for delete.

### [IdFactory](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/IdFactory)

A factory class for generating bogus Ids for testing purposes.

### [InvokeMetadataDrivenTriggerFramework](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/InvokeMetadataDrivenTriggerFramework)

class exists to allow the Metadata Trigger Framework to be invoked from a Flow

### [Log](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/Log)

Generic logging framework that persists across DML reversions by publishing a Platform Event

### [LogException](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/LogException)

This is a custom exception class for logging purposes.
I create a custom exception for every feature of ApexKit. While
this exception isn't yet used, it's here as a nod to consistency.

### [LogMessage](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/LogMessage)

A class for automatically attaching metadata to log messages
like Quiddity and RequestID

### [LogTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/LogTests)

### [LogTriggerHandler](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/LogTriggerHandler)

Class handles the post-insert processing of Log events
<br>Extends the TriggerFramework class
<br>Enables the user to define if this handler should silently
ignore errors thrown by dml, or if it should throw a log
exception

### [MetadataTriggerFramework](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/MetadataTriggerFramework)

A metadata driven extension of the TriggerFramework class

### [MetadataTriggerFrameworkException](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/MetadataTriggerFrameworkException)

An exception that is thrown when the MetadataTriggerFramework encounters an error.

### [MetadataTriggerFrameworkTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/MetadataTriggerFrameworkTests)

### [MetadataTriggerQueryService](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/MetadataTriggerQueryService)

Class encapsulates the querying of Metadata_Driven_Trigger\_\_mdt records on behalf of the
MetadataTriggerHandlerClass class. It is not intended to be used directly by developers.

### [MetadataTriggerQueryServiceTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/MetadataTriggerQueryServiceTests)

### [MethodSignature](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/MethodSignature)

Class models a callable apex method's 'signature' or combination
of Name, Parameter types and Parameter values. This is separate from a
MockedMethod, because it can be constructed at runtime for comparison against
established MockedMethods.

### [MockedMethod](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/MockedMethod)

Represents a method call that is mocked as part of a Stub
object. This class is marked

### [OrgShape](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/OrgShape)

Class contains static methods for determining if specific
platform features are enabled. For example, do we have platform cache
enabled. You could also write similar methods for experiences.
Shared Code

### [OrgShapeTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/OrgShapeTests)

### [Ouroboros](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/Ouroboros)

Ouroboros is the ancient mythical symbol of a dragon or serpent eating its own tail. It's often
understood as a reference to the circle of life, or the never ending nature life and death. In this case, it's a
reference to a Queueable object that enqueues itself when it's done executing via a Ourobo&hellip;

### [OuroborosFinalizer](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/OuroborosFinalizer)

This is the OuroborosFinalizer class. It is responsible for determining if the Ouroboros should
continue to loop, and if so, enqueueing the next iteration. It also ensure passthrough objects are passed to the
next iteration.

### [OuroborosTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/OuroborosTests)

### [Polyfills](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/Polyfills)

This class is full of methods that _I_ think should be in the Apex language, but aren't. It's
opinionated, and these represent the best solutions i've found to the gnarly problems i've come across.

### [PolyfillsTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/PolyfillsTests)

### [Query](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/Query)

MIT License
Copyright (c) 2020 Rafał Kopaczewski
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modi&hellip;

### [QueryTest](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/QueryTest)

MIT License
Copyright (c) 2020 Rafał Kopaczewski
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modi&hellip;

### [QueueableProcess](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/QueueableProcess)

This class provides a way for developers to create a process of Queueable classes. This implementation
facilitates the handoff of data into the overarching process and from one process step to the next. While
functionally similar to the way a 'Promise' pattern allows you chain async methods togethe&hellip;

### [QueueableProcessDataProvider](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/QueueableProcessDataProvider)

A class that separates concerns between the QueueableProcessManager and doing data lookup/access.
This helps us mock the data access in our unit tests.

### [QueueableProcessMockDataProvider](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/QueueableProcessMockDataProvider)

### [QueueableProcessTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/QueueableProcessTests)

This class contains tests used for testing the QueueableProcess framework.

### [QuiddityGuard](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/QuiddityGuard)

contains methods and static lists for rapid acceptance of a particular set of quiddities.
Note: I am not responsible for the name 'Quiddity'. Rumor has it the word comes from Sanskrit and means 'essence'.

### [QuiddityGuardTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/QuiddityGuardTests)

### [RestClient](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/RestClient)

A virtual class for making REST API calls

### [RestClientLib](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/RestClientLib)

This class is a wrapper around the RestLib class that is intended to be extended by developers
to provide a quick, safe, and reliable way of making REST callouts. By extending this class you're locking your
class to a specific Named Credential, which is a best practice for making callouts, and you'&hellip;

### [RestLib](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/RestLib)

A class providing a library of methods for making REST callouts

### [RestLibApiCall](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/RestLibApiCall)

This class encapsulates the information needed to make a callout except the endpoint which is
specified by named credential in other RestLib classes.

### [RestLibTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/RestLibTests)

### [SOQL](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/SOQL)

MIT License
Copyright (c) 2020 Rafał Kopaczewski
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modi&hellip;

### [SOQLAgregate](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/SOQLAgregate)

MIT License
Copyright (c) 2020 Rafał Kopaczewski
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modi&hellip;

### [SOQLAgregateTest](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/SOQLAgregateTest)

MIT License
Copyright (c) 2020 Rafał Kopaczewski
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modi&hellip;

### [SOQLTest](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/SOQLTest)

MIT License
Copyright (c) 2020 Rafał Kopaczewski
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modi&hellip;

### [SOSL](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/SOSL)

MIT License
Copyright (c) 2020 Rafał Kopaczewski
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modi&hellip;

### [SOSLTest](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/SOSLTest)

MIT License
Copyright (c) 2020 Rafał Kopaczewski
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modi&hellip;

### [Safely](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/Safely)

Class wraps DML Calls in FLS / Crud checks.

### [SafelyTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/SafelyTests)

### [SampleHandler](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/SampleHandler)

This class is a sample trigger handler for use while testing
the metadataTriggerHandler. Because custom metadata cannot be inserted, and
because the MetadataTriggerHandler instantiates handler classes from custom
metadata records, even when we stub/mock the metadata record retrieval we
still need a&hellip;

### [Stub](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/Stub)

This class helps you construct and manage StubProvider
conforming objects for use in Unit Tests. It, along with it's companion
classes:

-   MockedMethod
-   MethodSignature
    and their builder-pattern inner classes are designed to work together
    with a fluent API style like this:

```apex
StubObject fo&hellip;


### [StubUtilities](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/StubUtilities)


### [TestFactory](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/TestFactory)


### [TestPolyfills](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/TestPolyfills)

This class is not a unit test of the polyfills class but a
set of polyfills for unit testing.



### [TriggerContext](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/TriggerContext)

A class encapsulating the trigger context. Before/after insert/update/delete etc.



### [TriggerFramework](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/TriggerFramework)

An opinionated trigger handler framework.



### [TriggerFrameworkException](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/TriggerFrameworkException)

An exception that is thrown when an error occurs in the Trigger Framework



### [TriggerFrameworkLoopCount](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/TriggerFrameworkLoopCount)

inner class for managing the loop count per handler



### [TriggerFrameworkTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/TriggerFrameworkTests)


### [UFInvocable](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/UFInvocable)

This provides a common interface for classes & methods developers want to expose to flow.
Intrepid developers will note you could just implement the Callable interface in all of your classes.
However, this class provides a few benefits:
- It provides a common interface for all of your classes, whic&hellip;


### [ULID](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/ULID)

This class implements the ULID spec in Apex.
You can find that standard here: https://github.com/ulid/spec
ULID === Universally Unique Lexicographically Sortable Identifier
Think of them as a UUIDv4, but sortable. Similar to UUIDv7.
These are, effectively a universally unique identifier
but one tha&hellip;


### [ULIDTests](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/ULIDTests)

This seems like a woefully inadequate test class.
However, the ULID class contains no branching logic to test.
The single public method is fully tested by this class' method.
Because ULIDs are intentionally random, there's no way to test
deterministic output.



### [UniversalBulkInvocable](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/UniversalBulkInvocable)

This class contains the one and only invocable method that will be displayed in the flow builder.



### [UniversalFlowInputOutput](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/UniversalFlowInputOutput)

This is a common object for passing data from a flow, into a class method, and back out to flow.



### [UniversalFlowInputOutputParameter](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/UniversalFlowInputOutputParameter)

This class contains the object definition used by the Universal Invocable Action. It's designed
to expose variables of every type allowed by the InvocableVariable method in a single object. It uses type detection
to set the correct property on ouput.



### [UniversalInvocable](https://github.com/codefriar/ApexKit/wiki/Miscellaneous/UniversalInvocable)

This class exposes methods from any class that extends Invocable to flows.
By adding 'extends Invocable' to your class and adding the call method, any class' methods can be
invoked by this single invocable method.


## FeatureFlag

### [FF](https://github.com/codefriar/ApexKit/wiki/FeatureFlag/FF)

Convenience class for checking feature flags. This is purely Syntactic sugar.



### [FeatureFlag](https://github.com/codefriar/ApexKit/wiki/FeatureFlag/FeatureFlag)

Provides a unified, simple and testable api for feature flags



### [FeatureFlagDataProvider](https://github.com/codefriar/ApexKit/wiki/FeatureFlag/FeatureFlagDataProvider)

This class is responsible for querying / fetching FeatureFlag data. This is separate from the
FeatureFlag flag class to facilitate proper unit testing. (and just good design)


```
