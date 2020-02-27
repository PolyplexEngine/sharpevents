# sharpevents
Library that adds C#-esque events to D.

## Events

An `Event(T)` is a container for a collection of delegate callbacks. `T` is the data type you want to pass to callbacks.

```d
import events;

struct MyEventData {
	int callbackIntValue;
}

void main() {
	Event!MyEventData event = new Event!MyEventData;

	// The function signature that the event accepts in this case is:
	// void delegate(void*, MyEventData)
	event ~= (sender, args) {
		import std.stdio : writeln;
		writeln(args.callbackIntValue);
	};

	// Pass a null sender and MyEventData to the event.
	event(null, MyEventData(42));

	// Remove all handlers from the event
	event.clear();

	// If you have an instance of the handler available you can also remove a single instance via
	// event -= (handler);
}
```

## Basic Events

Basic events are a bit more like C# events, the event arguments are based of a EventArgs class. But the implementation is slightly limited.

See the unittests in `sev/event.d`