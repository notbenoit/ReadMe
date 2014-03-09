//
//  ReadMe.m
//  ReadMe
//
//  Created by Benoît Layer on 08/03/2014.
//  Copyright (c) 2014 Benoît Layer. All rights reserved.
//

#import "ReadMe.h"

dispatch_source_t create_dispatch_timer(double interval, dispatch_queue_t queue, dispatch_block_t block)
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (timer)
    {
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, (1ull * NSEC_PER_SEC) / 10);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    return timer;
}

// Aproximative, based on constatations...
static float ORP = 0.434;

@interface ReadMe () {
    dispatch_source_t _timer;
    NSMutableArray *_splitedText;
}

@end

@implementation ReadMe

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _wordsPerMinute = 300;
    }
    return self;
}

- (void)readText:(NSString *)text
{
    // Split text into array by space character
    _splitedText = [NSMutableArray arrayWithArray:[text componentsSeparatedByString:@" "]];
    
    // Launch a timer to send words (timer on background thread).
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    double secondsToFire = (double)60.f/_wordsPerMinute;
    
    _timer = create_dispatch_timer(secondsToFire, queue, ^{
        if (_splitedText != nil && _splitedText.count > 0)
        {
            NSString *word = _splitedText[0];
            
            // Lot of rules missing here, parse number ? etc...
            NSString *cleanedWord = [word stringByReplacingOccurrencesOfString:@".,?!" withString:@""];
            NSUInteger wordLength = cleanedWord.length;
            int orp = MAX(0, round(wordLength*ORP)-1);
            
            if (_delegate != nil && [_delegate respondsToSelector:@selector(readMe:didReadWord:withORP:)])
            {
                // Call delegate on main thread.
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_delegate readMe:self didReadWord:word withORP:orp];
                });
            }
            [_splitedText removeObjectAtIndex:0];
        }
        else
        {
            if (_delegate != nil && [_delegate respondsToSelector:@selector(readMeDidFinishReading:)])
            {
                // Call delegate on main thread.
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_delegate readMeDidFinishReading:self];
                });
            }
        }
    });
}

- (void)stopReading
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        // Remove this if you are on a Deployment Target of iOS6 or OSX 10.8 and above
        _timer = nil;
    }
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(readMeDidFinishReading:)])
    {
        // Call delegate on main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate readMeDidFinishReading:self];
        });
    }
}


@end
