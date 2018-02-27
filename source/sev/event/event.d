module sev.event.event;
import sev.event.eventargs;

alias EventHandler = void delegate(void* sender, EventArgs data);

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

	Event opAddAssign(EventHandler handler) {
		handlers.length++;
		handlers[$-1] = handler;
		return this;
	}

	Event opSubAssign(EventHandler handler) {
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