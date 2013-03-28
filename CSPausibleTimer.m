//
//  CSPausibleTimer.m
//
//  Created by Chris Shaheen on 3/28/13.
//  Copyright (c) 2013 Codeslaw. All rights reserved.
//

#import "CSPausibleTimer.h"

@implementation CSPausibleTimer
{
    NSDate *cycleStartDate;
    NSTimeInterval remainingInterval;
    BOOL hasPaused;
}

+(CSPausibleTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats
{
    
    CSPausibleTimer *new = [[CSPausibleTimer alloc] init];
    new.timeInterval = timeInterval;
    new.target = target;
    new.selector = selector;
    new.userInfo = userInfo;
    new.repeats = repeats;
    
    return new;
}

-(void)start
{
    
    [self.timer invalidate];
    
    if(self.isPaused)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:remainingInterval target:self selector:@selector(timerFired:) userInfo:self.userInfo repeats:self.repeats];
        
    } else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timerFired:) userInfo:self.userInfo repeats:self.repeats];
        
        remainingInterval = self.timeInterval;
    }
    
    self.isPaused = NO;
    cycleStartDate = [NSDate date];
    
}

-(void)pause
{
    if(self.isPaused) return;
    
    self.isPaused = YES;
    hasPaused = YES;
    
    [self.timer invalidate];
    
    //keep track of time left on this cycle
    remainingInterval -= [[NSDate date] timeIntervalSinceDate:cycleStartDate];
}

-(void)timerFired:(NSTimer *)timer
{
    if(self.isPaused) return;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.target performSelector:self.selector withObject:self];
#pragma clang diagnostic pop
    
    //reset remaining time to original value
    remainingInterval = self.timeInterval;
    cycleStartDate = [NSDate date];
    
    if(hasPaused)
    {
        //current timer is running on remainingInterval
        //start will simply reset the timer
        hasPaused = NO;
        
        [self.timer invalidate];
        
        if(self.repeats)
            [self start];
    }
}

-(void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    self.selector = nil;
    self.target = nil;
    self.userInfo = nil;
}



@end
