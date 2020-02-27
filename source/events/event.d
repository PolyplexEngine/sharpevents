module events.event;
import events.eventargs;

/**
	An easy alias for the EventHandler signature.
*/
//alias EventHandler = void delegate(void* sender, EventArgs data);

/**
	An event.
	To add event handlers to the event use ~= or += followed by your event delegate.
	(use EventHandler for an easy signature for the delegate)

	The delegate should take an void* sender and EventArgs argument.

	Use -= to remove an event handler delegate from the event.
*/
public class Event(EventData) {
private:
	alias EventHandler = void delegate(void* sender, EventData data);
	EventHandler[] handlers;
	
public:

	/**
		Gets the amount of handlers that are bound to this event
	*/
	size_t count() {
		return handlers.length;
	}

	/**
		Clears all handlers from the event
	*/
	void clear() {
		handlers.length = 0;
	}

	/**
		Call all event handlers bound to this event
	*/
	void opCall(void* sender, EventData data) {
		foreach(EventHandler handler; handlers) {
			handler(sender, data);
		}
	}

	/**
		Call all event handlers bound to this event
	*/
	void opCall(void* sender) {
		foreach(EventHandler handler; handlers) {
			handler(sender, EventData.init);
		}
	}

	/**
		Add a new handler
	*/
	deprecated("C# style event adding is deprecated, please use ~= instead.")
	Event opOpAssign(string op : "+")(EventHandler handler) {
		handlers.length++;
		handlers[$-1] = handler;
		return this;
	}

	/**
		Add a new handler
	*/
	Event opOpAssign(string op : "~")(EventHandler handler) {
		handlers.length++;
		handlers[$-1] = handler;
		return this;
	}

	/**
		Deletes a handler
	*/
	Event opOpAssign(string op : "-")(EventHandler handler) {
		int remove = 0;
		for (int i = 0; i < handlers.length; i++) {
			if (handlers[i] == handler) {
				handlers[i] = null;
				remove++;
			}

			if (remove == handlers.length) break;

			if (handlers[i-1] is null) {
				handlers[i-1] = handlers[i];
				handlers[i] = null;
			}
		}
		handlers.length -= remove;
		return this;
	}
}

/**
	Test the creation and execution of an event
*/
unittest {

	struct TestEventData { string name; }
	bool wasRun;

	// Test creation
	auto eventHandler = (void* sender, TestEventData args) {
		assert(args.name == "test", "Expected value of event args to be \"Test\"");
		wasRun = true;
	};

	Event!TestEventData testEvent = new Event!TestEventData;
	testEvent ~= eventHandler;

	// Test execution
	testEvent(null, TestEventData("test"));
	assert(wasRun, "Expected event to be executed!");

	// Test deletion of event handler
	testEvent -= eventHandler;
	assert(testEvent.count == 0, "Expected event to have no handlers!");
}

/**
	A basic event that takes an EventArgs as arguments
*/
public class BasicEvent : Event!EventArgs { }

/**
	Test the creation and execution of a basic event
*/
unittest {
	class TestEventArgs : EventArgs {
		string name;

		this(string name) {
			this.name = name;
		}
	}
	bool wasRun;

	// Test creation
	auto eventHandler = (void* sender, EventArgs args) {
		TestEventArgs testArgs = cast(TestEventArgs)args;
		assert(testArgs.name == "test", "Expected value of event args to be \"Test\"");
		wasRun = true;
	};

	BasicEvent testEvent = new BasicEvent;
	testEvent ~= eventHandler;

	// Test execution
	testEvent(null, new TestEventArgs("test"));
	assert(wasRun, "Expected event to be executed!");

	// Test deletion of event handler
	testEvent -= eventHandler;
	assert(testEvent.count == 0, "Expected event to have no handlers!");
}