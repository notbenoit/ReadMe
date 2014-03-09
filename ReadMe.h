//
//  ReadMe.h
//  ReadMe
//
//  Created by Benoît Layer on 08/03/2014.
//  Copyright (c) 2014 Benoît Layer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ReadMe;

@protocol ReadMeDelegate <NSObject>
/**
 Called on the delegate when a new word should be diplayed. This method is called on the main thread.
 @param readMe The readme object.
 @param newWord The word to be diplayed.
 @param orp Optimal recognition point. The place where the eyes should focus. Usually resulting in a colored letter. Index starting to 0 for first letter
 */
- (void)readMe:(ReadMe *)readMe didReadWord:(NSString *)newWord withORP:(int)orp;

/**
 Called when ReadMe has finished parsing a text.
 @param readMe The readme object.
 */
- (void)readMeDidFinishReading:(ReadMe *)readMe;
@end

@interface ReadMe : NSObject

@property (nonatomic, weak) id<ReadMeDelegate>  delegate;
@property (nonatomic)       int                 wordsPerMinute;

/**
 Returns the ReadMe singleton.
 @return The readme singleton.
 */
+ (instancetype)sharedInstance;

/**
 Stops the readme process.
 */
- (void)stopReading;

/**
 Starts the readme process.
 @param text The whole text to read.
 */
- (void)readText:(NSString *)text;

@end
