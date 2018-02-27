# sharpevents
Library that adds C#-esque events to D.


## How to use


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