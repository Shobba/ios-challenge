# iOS code challenge

## Description
The goal of this challenge is to query the [Giphy random roulette
API](https://github.com/Giphy/GiphyAPI#sticker-roulette-random-endpoint) and
display the resulting image in the playground either by simply assigning an
NSImage/UIImage to a variable or by instantiating an image view in the
playground's live view. Use
[ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) for this task.
It's perfectly okay to check out ReactiveCocoa and code away in their sandbox.
It has everything you need.
However you can also setup a new project and include the framework through Carthage or CocoaPods.

If you have any questions or problems drop me a message and I'll try to help you.

## Hints
Since the code is asynchronous by nature you should set indefinite execution on
the playground like so:
```
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
```

Code readability is key in FRP, so please structure your code in a way other
people can understand what's going on easily.
