# Using the Log class

## What is this?

Apex Kit's Log class is designed to provide developers a simple way to persist log information that is immune to
database transaction rollbacks.
This means you can safely Log things using this library and not worry about the log being rolled back if the transaction
fails.

## Design

Log is built as a singleton. This means you cannot construct an instance of Log, nor can you have multiple instances of
Log in a single transaction.
Instead, you'll use the Log.get() method to get an existing instance of Log if one exists, and create a new one if it
doesn't.

At a high level, this logger works by constructing a platform event and publishing it. A trigger on the platform event
then takes the log entry and persists it to the database.

## Usage

There are two main methods of operation for the Log class. The first is to simply publish a log entry immediately. The
second is to queue up log entries and publish them all at once. The Log class has been written with several overriden
methods to make it easy to use. Here are some common use cases.

> Note, you'll want to use the Log's queue methods to separate out the logging of events and the publishing of those
> events when making callouts.

### Publish Immediately

#### How do I get a Log instance?

```apex
Log log = Log.get();
```

#### How do I log a string immediately?

```apex
Log log = Log.get().publish('your string here');
```

#### How do I log a string with a custom log level?

```apex
Log log = Log.get().publish(LogLevel.INFO, 'your string here');
```

#### How do I log an exception?

```apex
Log log = Log.get().publish(yourExceptionObjectHere);
```

### Queue up log entries and publish them all at once

#### How do I log a string?

```apex
Log log = Log.get();
log.add('your string here');
log.publish();
```

#### How do I log a string with a custom log level?

```apex
Log log = Log.get();
log.add('your string here', LogLevel.DEBUG);
log.publish();
```

#### How do I log an exception?

```apex
Log log = Log.get();
log.add(yourExceptionObjectHere);
log.publish();
```

#### Can I mix and match exceptions and strings? YES!

```apex
Log log = Log.get();
log.add('your string here');
log.add(yourExceptionObjectHere);
log.publish();
```
