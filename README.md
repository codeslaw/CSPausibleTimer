CSPausibleTimer
===============

## Description
CSPausibleTimer is a lightweight wrapper class for NSTimer that provides a very simplified interface for pausing and resuming a running timer.

(**note**: UserInfo and repeating timers are supported.)

## Installation
Just copy the CSPausibleTimer.h & CSPausibleTimer.m to your project.
(Don't forget to import (#import "CSPausibleTimer.h"));

## How To Use
#### Allocation & Initialization
```objective-c
CSPausibleTimer *pTimer = [CSPausibleTimer timerWithTimeInterval:5 
                                                          target:self 
                                                        selector:@selector(timerFired:) 
                                                        userInfo:nil 
                                                         repeats:NO];
```

#### Start
```objective-c                                                         
[pTimer start];
```

#### Pause
```objective-c                                                         
[pTimer pause];
```

#### Timer selectors follow the same format as NSTimer:
```objective-c
-(void)timerFired:(CSPausibleTimer *)pTimer
{
    NSLog(@"The time is now!");
}
```

## Note
Currently, the underyling NSTimer object is accessible via the [CSPausibleTimer timer] property.  However, be careful 
when accessing, modifying, or attaching KV observers to the internal NSTimer object, as it will be invalidated and released
before it actually fires IF the CSPausibleTimer has been paused at least once during the current cycle.  This is not
necessarily as important if you are not using a repeating timer.

## Author
codeslaw

## License
CSPausibleTimer is available under the MIT license. See the LICENSE file for more info.
