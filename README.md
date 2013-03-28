CSPausibleTimer
===============

Lightweight wrapper class for NSTimer that provides a very simplified interface for pausing and resuming a running timer.

UserInfo and repeating timers are supported.


Allocation mimics NSTimer initialization:
```objective-c

CSPausibleTimer *pTimer = [CSPausibleTimer timerWithTimeInterval:5 
                                                          target:self 
                                                        selector:@selector(timerFired:) 
                                                        userInfo:nil 
                                                         repeats:NO];

[pTimer start];


```

Timer selectors follow the same format as NSTimer:
```objective-c
-(void)timerFired:(CSPausibleTimer *)pTimer
{
    NSLog(@"The time is now!");
}
```


Pausing and resuming is as easy as it should be:
```objective-c

[pTimer start];

//wait 3 seconds

[pTimer pause];

//wait an arbitrary amount of time

[pTimer start];

//2 second delay occurs...

//Output: The time is now!
```


Currently, the underyling NSTimer object is accessible via the [CSPausibleTimer timer] property.  However, be careful 
when accessing, modifying, or attaching KV observers to the internal NSTimer object, as it will be invalidated and released
before it actually fires IF the CSPausibleTimer has been paused at least once during the current cycle.  This is not
necessarily as important if you are not using a repeating timer.


