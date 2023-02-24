trigger Log on Log__e(after insert) {
	new LogTriggerHandler(Trigger.new, true).run();
}