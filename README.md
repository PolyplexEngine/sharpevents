# sharpevents
Library that adds C#-esque events to D.


## How to use

the Event class is localed in the `sev.event` module (short for sharpevents)

To create a new event, do like this.
```d
public Event MyNewEvent = new Event();
```

An event handler has the signature of void [name] (void* sender, EventArgs args)
```d
public void MyEventHandler (void* sender, EventArgs args) {
	//Do something.
}
```

Subscribe to an event by doing += (like in C#). Remember to use a _pointer_ to the handler.
```d
MyNewEvent += &MyEventHandler;
```

To unsubscribe, use -=
```d
MyNewEvent -= &MyEventHandler;
```

To invoke subscribed event handlers, run the class instance like a function.
Remember to specify sender and arguments (cast to void*)
```d
MyNewEvent(null, null);
```

## Donations
If this small library has been of any help to you, consider [Donating](https://ko-fi.com/clipsey). c:
