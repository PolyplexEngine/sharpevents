module sev.event.event;
import sev.event.eventargs;

/**
	An easy alias for the EventHandler signature.
*/
alias EventHandler = void delegate(void* sender, EventArgs data);

/**
	An event.
	To add event handlers to the event use ~= or += followed by your event delegate.
	(use EventHandler for an easy signature for the delegate)

	The delegate should take an void* sender and EventArgs argument.

	Use -= to remove an event handler delegate from the event.
*/
public class Event {
	private EventHandler[] handlers;
	this() { }

	void opCall(void* sender, EventArgs data) {
		foreach(EventHandler h; handlers) {
			h(sender, data);
		}
	}

	void opCall(void* sender) {
		foreach(EventHandler h; handlers) {
			h(sender, EventArgs.Empty);
		}
	}

	Event opOpAssign(string op : "+")(EventHandler handler) {
		handlers.length++;
		handlers[$-1] = handler;
		return this;
	}

	Event opOpAssign(string op : "~")(EventHandler handler) {
		handlers.length++;
		handlers[$-1] = handler;
		return this;
	}

	Event opOpAssign(string op : "-")(EventHandler handler) {
		int remove = 0;
		for (int i = 0; i < handlers.length; i++) {
			if (handlers[i] == handler) {
				handlers[i] = null;
				remove++;
			}
			if (handlers[i-1] is null) {
				handlers[i-1] = handlers[i];
				handlers[i] = null;
			}
		}
		handlers.length -= remove;
		return this;
	}
}