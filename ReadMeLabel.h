//
//  ReadMeLabel.h
//  ReadMe
//
//  Created by Benoît Layer on 09/03/2014.
//  Copyright (c) 2014 Benoît Layer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadMe.h"

@interface ReadMeLabel : UILabel <ReadMeDelegate>

// The color to be used for OPR. (Letter emphasis).
@property (nonatomic, strong) UIColor *orpColor;

- (void)readText:(NSString *)text;
- (void)stopReading;

@end
