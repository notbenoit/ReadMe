ReadMe
======

A Spritz like library for iOS. (WIP)

![Sample](http://s30.postimg.org/ugsc0l93l/readme.gif)

### Simple usage
To use it, simply drag and drop the two classes in your Xcode project.
Then, to launch the reading process with the ReadMeLabel just call `readText:` on the label instance. The default reading speed is 300 words per minute. To stop the reading process, simply call `stopReading`. There is no need to call the stop method, the process will stop when it reaches the end of the text.

```
  [myLabel readText:@"This is an amazing text to read."];
  ...
  [myLabel stopReading]; //Optional
```

### Custom control
You can create your custom control by implementing the delegate methods. Feel free to show them to the world !

---

#### ReadMeDelegate Protocol Reference
You can implements these delegate methods to handle your own ReadMe control if you do not want to use ReadMeLabel.

#### Tasks
[`– readMe:didReadWord:withORP:`](https://github.com/notbenoit/ReadMe/edit/master/README.md#readmedidreadwordwithorp) required method 

[`– readMeDidFinishReading:`](https://github.com/notbenoit/ReadMe/edit/master/README.md#readmedidfinishreading) required method

===

#### readMe:didReadWord:withORP:

Called on the delegate when a new word should be diplayed. This method is called on the main thread.

`- (void)readMe:(ReadMe *)readMe didReadWord:(NSString *)newWord withORP:(int)orp`
###### Parameters
**readMe**
The readme object.

**newWord**
The word to be diplayed.

**orp**
Optimal recognition point. The place where the eyes should focus. Usually resulting in a colored letter. Index starting to 0 for first letter

######  Discussion
Called on the delegate when a new word should be diplayed. This method is called on the main thread.

###### Declared In
ReadMe.h

===

### readMeDidFinishReading:

Called when ReadMe has finished parsing a text.

`- (void)readMeDidFinishReading:(ReadMe *)readMe`
###### Parameters
**readMe**
The readme object.

###### Discussion
Called when ReadMe has finished parsing a text.

###### Declared In
ReadMe.h
