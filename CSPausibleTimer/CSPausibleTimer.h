//
//  CSPausibleTimer.h
//  uFilmer
//
//  Created by Chris Shaheen on 3/28/13.
//  Copyright (c) 2013 Codeslaw. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface CSPausibleTimer : NSObject


#pragma mark - Properties


//Timer Info
@property (nonatomic) NSTimeInterval timeInterval;
@property (nonatomic, weak) id target;
@property (nonatomic) SEL selector;
@property (nonatomic) id userInfo;
@property (nonatomic) BOOL repeats;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL isPaused;


#pragma mark - Static Methods


+(CSPausibleTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats;


#pragma mark - Public Methods


-(void)pause;
-(void)start;



@end

