# sharpevents
Library that adds C#-esque events to D.


## How to use

the Event class is localed in the `sev` module (short for sharpevents)

To create a new event, do like this.
```d
public Event MyNewEvent = new Event();
```

An event handler has the signature of void [name] (void* sender, void* args)
```d
public void MyEventHandler (void* sender, void* args) {
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
