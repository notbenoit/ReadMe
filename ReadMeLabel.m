//
//  ReadMeLabel.m
//  ReadMe
//
//  Created by Benoît Layer on 09/03/2014.
//  Copyright (c) 2014 Benoît Layer. All rights reserved.
//

#import "ReadMeLabel.h"

@interface ReadMeLabel () {
    ReadMe *_readMe;
    UIColor *_mainColor;
}

@end

@implementation ReadMeLabel

#pragma mark - Init methods
- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _readMe = [ReadMe sharedInstance];
    _readMe.delegate = self;
    _readMe.wordsPerMinute = 300;     // Customize readmeIfNeeded
    
    _orpColor = [UIColor redColor]; // Default color to red
    _mainColor = self.textColor;
}

#pragma mark - Actions
- (void)readText:(NSString *)text
{
    [_readMe readText:text];
}

- (void)stopReading
{
    [_readMe stopReading];
}

#pragma mark - Delegate methods
- (void)readMe:(ReadMe *)readMe didReadWord:(NSString *)newWord withORP:(int)orp
{
    // Setting a fully red attributed string sets the textcolor to red.
    // We need to keep track of it and reset it everytime.
    self.textColor = _mainColor;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:newWord];
    NSRange beginRange = NSMakeRange(0, orp);
    [string addAttribute:NSForegroundColorAttributeName value:self.textColor range:beginRange];
    NSRange orpRange = NSMakeRange(orp, 1);
    [string addAttribute:NSForegroundColorAttributeName value:self.orpColor range:orpRange];
    NSRange endRange = NSMakeRange(orp+1, newWord.length-(orp+1));
    [string addAttribute:NSForegroundColorAttributeName value:self.textColor range:endRange];
    
    // TODO : center label on ORP point.
    
    self.attributedText = string;
}

- (void)readMeDidFinishReading:(ReadMe *)readMe
{
    self.text = @"";
}

#pragma mark - Properties
- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    _mainColor = textColor;
}

@end
