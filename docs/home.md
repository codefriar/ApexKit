### [FF](featureflag/FF.md)

Convenience class for checking feature flags. This is purely Syntactic sugar.

### [FeatureFlag](featureflag/FeatureFlag.md)

Provides a unified, simple and testable api for feature flags

### [FeatureFlagDataProvider](featureflag/FeatureFlagDataProvider.md)

This class is responsible for querying / fetching FeatureFlag data. This is separate from the
FeatureFlag flag class to facilitate proper unit testing. (and just good design)

## Miscellaneous

### [ULID](miscellaneous/ULID.md)

This class implements the ULID spec in Apex.
You can find that standard here: https://github.com/ulid/spec
ULID &#x3D;&#x3D;&#x3D; Universally Unique Lexicographically Sortable Identifier
Think of them as a UUIDv4, but sortable. Similar to UUIDv7.
These are, effectively a universally unique identifier
but one that is _sortable_.

This class is a port of the Javascript ULID
reference implementation.

### [ULIDTests](miscellaneous/ULIDTests.md)

This seems like a woefully inadequate test class.
However, the ULID class contains no branching logic to test.
The single public method is fully tested by this class&#x27; method.
Because ULIDs are intentionally random, there&#x27;s no way to test
deterministic output.

### [CustomMetadataUtilDeploymentCallback](miscellaneous/CustomMetadataUtilDeploymentCallback.md)

Callback implementation for Custom Metadata deployment operations

### [CustomMetadataUtilities](miscellaneous/CustomMetadataUtilities.md)

Utility class for creating and updating Custom Metadata records programmatically

### [CustomMetadataUtilDeployCallbackTests](miscellaneous/CustomMetadataUtilDeployCallbackTests.md)

Test class for CustomMetadataUtilDeploymentCallback

### [CustomMetadataUtilitiesTests](miscellaneous/CustomMetadataUtilitiesTests.md)

Test class for CustomMetadataUtilities

### [FeatureFlagCommonTests](miscellaneous/FeatureFlagCommonTests.md)

Class serves to DRY code for various testing methods that
require it. It is not intended to be used directly.

### [FeatureFlagDataProviderTests](miscellaneous/FeatureFlagDataProviderTests.md)

### [FeatureFlagTests](miscellaneous/FeatureFlagTests.md)

### [Log](miscellaneous/Log.md)

Generic logging framework that persists across DML reversions by publishing a Platform Event

### [LogException](miscellaneous/LogException.md)

This is a custom exception class for logging purposes.
I create a custom exception for every feature of ApexKit. While
this exception isn&#x27;t yet used, it&#x27;s here as a nod to consistency.

### [LogMessage](miscellaneous/LogMessage.md)

A class for automatically attaching metadata to log messages
like Quiddity and RequestID

### [LogTriggerHandler](miscellaneous/LogTriggerHandler.md)

Class handles the post-insert processing of Log events
&lt;br&gt;Extends the TriggerFramework class
&lt;br&gt;Enables the user to define if this handler should silently
ignore errors thrown by dml, or if it should throw a log
exception

### [LogTests](miscellaneous/LogTests.md)

### [CachePartitionType](miscellaneous/CachePartitionType.md)

Enum for partition type.

### [OrgShape](miscellaneous/OrgShape.md)

Class contains static methods for determining if specific
platform features are enabled. For example, do we have platform cache
enabled. You could also write similar methods for experiences.

Shared Code

### [OrgShapeTests](miscellaneous/OrgShapeTests.md)

### [Ouroboros](miscellaneous/Ouroboros.md)

Ouroboros is the ancient mythical symbol of a dragon or serpent eating its own tail. It&#x27;s often
understood as a reference to the circle of life, or the never ending nature life and death. In this case, it&#x27;s a
reference to a Queueable object that enqueues itself when it&#x27;s done executing via a OuroborosFinalizer. This is a
useful pattern when you need to process high volumes of data, but don&#x27;t care if it&#x27;s processed in real time.

### [OuroborosFinalizer](miscellaneous/OuroborosFinalizer.md)

This is the OuroborosFinalizer class. It is responsible for determining if the Ouroboros should
continue to loop, and if so, enqueueing the next iteration. It also ensure passthrough objects are passed to the
next iteration.

### [OuroborosTests](miscellaneous/OuroborosTests.md)

### [FailsafeExceptionHandler](miscellaneous/FailsafeExceptionHandler.md)

This class is a polyfill for the handling exceptions. Rather than writing
boilerplate exception handling code everywhere, this class can be used to log exceptions.

### [Polyfills](miscellaneous/Polyfills.md)

This class is full of methods that _I_ think should be in the Apex language, but aren&#x27;t. It&#x27;s
opinionated, and these represent the best solutions i&#x27;ve found to the gnarly problems i&#x27;ve come across.

### [FailsafeExceptionHandlerTests](miscellaneous/FailsafeExceptionHandlerTests.md)

### [PolyfillsTests](miscellaneous/PolyfillsTests.md)

### [TestPolyfills](miscellaneous/TestPolyfills.md)

This class is not a unit test of the polyfills class but a
set of polyfills for unit testing.

### [FieldSelection](miscellaneous/FieldSelection.md)

### [Query](miscellaneous/Query.md)

MIT License

Copyright (c) 2020 Rafał Kopaczewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the &quot;Software&quot;), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

### [SOQL](miscellaneous/SOQL.md)

MIT License

Copyright (c) 2020 Rafał Kopaczewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the &quot;Software&quot;), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

### [SOQLAgregate](miscellaneous/SOQLAgregate.md)

MIT License

Copyright (c) 2020 Rafał Kopaczewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the &quot;Software&quot;), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

### [SOSL](miscellaneous/SOSL.md)

MIT License

Copyright (c) 2020 Rafał Kopaczewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the &quot;Software&quot;), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

### [QueryTest](miscellaneous/QueryTest.md)

MIT License

Copyright (c) 2020 Rafał Kopaczewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the &quot;Software&quot;), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

### [SOQLAgregateTest](miscellaneous/SOQLAgregateTest.md)

MIT License

Copyright (c) 2020 Rafał Kopaczewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the &quot;Software&quot;), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

### [SOQLTest](miscellaneous/SOQLTest.md)

MIT License

Copyright (c) 2020 Rafał Kopaczewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the &quot;Software&quot;), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

### [SOSLTest](miscellaneous/SOSLTest.md)

MIT License

Copyright (c) 2020 Rafał Kopaczewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the &quot;Software&quot;), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

### [EnqueueNextQueueableProcessStep](miscellaneous/EnqueueNextQueueableProcessStep.md)

This class implements the Apex Transaction Finalizer interface. It&#x27;s used to implement promises. This
class is constructed with a list of QueueableProcess Objects, and any passthrough data. The first promise in the list
is executed. The QueueableProcess class automatically attaches this finalizer to it&#x27;s execution.

### [QueueableProcess](miscellaneous/QueueableProcess.md)

This class provides a way for developers to create a process of Queueable classes. This implementation
facilitates the handoff of data into the overarching process and from one process step to the next. While
functionally similar to the way a &#x27;Promise&#x27; pattern allows you chain async methods together. However, a true Promise
pattern resolves itself, one way or another, within the same transaction. Therefore, this is not a true Promise
pattern, but an elegant way to logically chain Salesforce Queueables together. As a Developer, you&#x27;ll need to extend
this class, implementing the necessary `execute` method. Your `execute` method will be invoked asynchronously as part
of a Queueable. You can then chain additional Queueables together using the `then` method provided by this class.
&lt;br&gt;
As each &#x27;step&#x27; of the chain is completed the transaction finalizer will be constructed with the remaining steps and
any passthrough data you specify. Passthrough data allows you to pass data between steps.

### [QueueableProcessDataProvider](miscellaneous/QueueableProcessDataProvider.md)

A class that separates concerns between the QueueableProcessManager and doing data lookup/access.
This helps us mock the data access in our unit tests.

### [QueueableProcessMockDataProvider](miscellaneous/QueueableProcessMockDataProvider.md)

### [ExampleQueueableProcessSteps](miscellaneous/ExampleQueueableProcessSteps.md)

This class contains two inner classes used for testing the QueueableProcess framework.

### [QueueableProcessTests](miscellaneous/QueueableProcessTests.md)

This class contains tests used for testing the QueueableProcess framework.

### [QuiddityGuard](miscellaneous/QuiddityGuard.md)

contains methods and static lists for rapid acceptance of a particular set of quiddities.

Note: I am not responsible for the name &#x27;Quiddity&#x27;. Rumor has it the word comes from Sanskrit and means &#x27;essence&#x27;.

### [QuiddityGuardTests](miscellaneous/QuiddityGuardTests.md)

### [AsyncRestClient](miscellaneous/AsyncRestClient.md)

wraps a restlib backed api call in a queueable context

### [AsyncRestLibFinalizer](miscellaneous/AsyncRestLibFinalizer.md)

Abstract class defining a common interface with default implementation for finalizers handling
AsyncRestApi calls

### [HttpVerb](miscellaneous/HttpVerb.md)

This ENUM lists possible HTTP Verbs. Note: &#x27;Delete&#x27; is an Apex Keyword (DML)
and as a result, the ENUM value &#x27;DEL&#x27; is used for delete.

### [RestClient](miscellaneous/RestClient.md)

A virtual class for making REST API calls

### [RestClientLib](miscellaneous/RestClientLib.md)

This class is a wrapper around the RestLib class that is intended to be extended by developers
to provide a quick, safe, and reliable way of making REST callouts. By extending this class you&#x27;re locking your
class to a specific Named Credential, which is a best practice for making callouts, and you&#x27;re inheriting methods
like `get` , `post` , `put` , `patch` , and `del` that make it easy to make callouts without having to worry about
setting headers, or other common tasks.

### [RestLib](miscellaneous/RestLib.md)

A class providing a library of methods for making REST callouts

### [RestLibApiCall](miscellaneous/RestLibApiCall.md)

This class encapsulates the information needed to make a callout except the endpoint which is
specified by named credential in other RestLib classes.

### [RestLibTests](miscellaneous/RestLibTests.md)

### [CanTheUser](miscellaneous/CanTheUser.md)

A reusable, intuitive library for determining whether or not the
current use can create, read, edit, or delete objects as well as
determining if the user has access or update permissions on specific fields.
This class name was chosen to facilitate easy-to-understand and read code.
Whenever you need to check FLS or CRUD access your code reads like this
`if(CanTheUser.read(new account())){}` making the calling and use of this
code easy and intuitive.
&lt;br&gt;
This class&#x27; name was chosen to facilitate easy-to-understand and read
code. Whenever you need to check FLS or CRUD access your code reads like
this
`if(CanTheUser.read(new account())){}` making the calling and use of this
code easy and intuitive.

### [CrudType](miscellaneous/CrudType.md)

### [FLSType](miscellaneous/FLSType.md)

### [Safely](miscellaneous/Safely.md)

Class wraps DML Calls in FLS / Crud checks.

### [CanTheUserTests](miscellaneous/CanTheUserTests.md)

### [SafelyTests](miscellaneous/SafelyTests.md)

### [HttpCalloutMockFactory](miscellaneous/HttpCalloutMockFactory.md)

### [IdFactory](miscellaneous/IdFactory.md)

A factory class for generating bogus Ids for testing purposes.

### [MethodSignature](miscellaneous/MethodSignature.md)

Class models a callable apex method&#x27;s &#x27;signature&#x27; or combination
of Name, Parameter types and Parameter values. This is separate from a
MockedMethod, because it can be constructed at runtime for comparison against
established MockedMethods.

### [MockedMethod](miscellaneous/MockedMethod.md)

Represents a method call that is mocked as part of a Stub
object. This class is marked

### [Stub](miscellaneous/Stub.md)

This class helps you construct and manage StubProvider
conforming objects for use in Unit Tests. It, along with it&#x27;s companion
classes:

- MockedMethod
- MethodSignature
  and their builder-pattern inner classes are designed to work together
  with a fluent API style like this:

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

### [StubUtilities](miscellaneous/StubUtilities.md)

### [TestFactory](miscellaneous/TestFactory.md)

### [InvokeMetadataDrivenTriggerFramework](miscellaneous/InvokeMetadataDrivenTriggerFramework.md)

class exists to allow the Metadata Trigger Framework to be invoked from a Flow

### [MetadataTriggerFramework](miscellaneous/MetadataTriggerFramework.md)

A metadata driven extension of the TriggerFramework class

### [MetadataTriggerFrameworkException](miscellaneous/MetadataTriggerFrameworkException.md)

An exception that is thrown when the MetadataTriggerFramework encounters an error.

### [MetadataTriggerFrameworkTests](miscellaneous/MetadataTriggerFrameworkTests.md)

### [MetadataTriggerQueryService](miscellaneous/MetadataTriggerQueryService.md)

Class encapsulates the querying of Metadata_Driven_Trigger\_\_mdt records on behalf of the
MetadataTriggerHandlerClass class. It is not intended to be used directly by developers.

### [MetadataTriggerQueryServiceTests](miscellaneous/MetadataTriggerQueryServiceTests.md)

### [TriggerContext](miscellaneous/TriggerContext.md)

A class encapsulating the trigger context. Before/after insert/update/delete etc.

### [TriggerFramework](miscellaneous/TriggerFramework.md)

An opinionated trigger handler framework.

### [TriggerFrameworkException](miscellaneous/TriggerFrameworkException.md)

An exception that is thrown when an error occurs in the Trigger Framework

### [TriggerFrameworkLoopCount](miscellaneous/TriggerFrameworkLoopCount.md)

inner class for managing the loop count per handler

### [SampleHandler](miscellaneous/SampleHandler.md)

This class is a sample trigger handler for use while testing
the metadataTriggerHandler. Because custom metadata cannot be inserted, and
because the MetadataTriggerHandler instantiates handler classes from custom
metadata records, even when we stub/mock the metadata record retrieval we
still need an actual class that it can instantiate.

Note, this class is annotated with

### [TriggerFrameworkTests](miscellaneous/TriggerFrameworkTests.md)
