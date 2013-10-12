//
//  SlideActionCell.m
//  slideActionCell
//
//  Created by Thomas Cullen on 12/10/2013.
//  Copyright (c) 2013 Thomas Cullen. All rights reserved.
//

#import "SlideActionCell.h"

@implementation SlideActionCell
#define cellHeight 70
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        wrapperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight)];
        [self addSubview:wrapperView];
        
        tint = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight)];
        tint.backgroundColor = [UIColor whiteColor];
        [wrapperView addSubview:tint];
        
        self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight)];
        self.mainView.backgroundColor = [UIColor clearColor];
        [wrapperView addSubview:self.mainView];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.mainView.frame.size.width - 20, cellHeight)];
        [self.title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [self.mainView addSubview:self.title];
        
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setText:(NSString *)text{
    self.title.text = text;
}

-(void)setDelegate:(id)aDelegate{
    delegate = aDelegate;
}

-(void)addLeftAction:(NSString *)aTitle
               color:(UIColor *)color
           textColor:(UIColor *)textColor
               width:(float)aWidth{
    self.leftActionView = [[UIView alloc] initWithFrame:CGRectMake(0 - aWidth, 0, aWidth, self.mainView.frame.size.height)];
    self.leftActionView.backgroundColor = color;
    [wrapperView addSubview:self.leftActionView];
    
    leftActionWidth = aWidth;

    self.leftActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, aWidth, self.mainView.frame.size.height)];
    self.leftActionLabel.text = aTitle;
    self.leftActionLabel.textAlignment = NSTextAlignmentCenter;
    self.leftActionLabel.textColor = textColor;
    [self.leftActionView addSubview:self.leftActionLabel];
    
}

-(void)addLeftActionImage:(UIImage *)anImage
                    color:(UIColor *)color
                    width:(float)aWidth{
    self.leftActionView = [[UIView alloc] initWithFrame:CGRectMake(0 - aWidth, 0, aWidth, self.mainView.frame.size.height)];
    self.leftActionView.backgroundColor = color;
    [wrapperView addSubview:self.leftActionView];
    
    leftActionWidth = aWidth;

    self.leftActionImage = [[UIImageView alloc] initWithImage:anImage];
    self.leftActionImage.frame = CGRectMake(0, 0, aWidth, self.leftActionView.frame.size.height);
    self.leftActionImage.contentMode = UIViewContentModeCenter;
    [self.leftActionView addSubview:self.leftActionImage];
}

-(void)addRightAction:(NSString *)aTitle
                color:(UIColor *)color
            textColor:(UIColor *)textColor
                width:(float)aWidth{
    self.rightActionView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, aWidth, self.mainView.frame.size.height)];
    self.rightActionView.backgroundColor = color;
    [wrapperView addSubview:self.rightActionView];
    
    rightActionWidth = aWidth;
    
    self.rightActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, aWidth, self.mainView.frame.size.height)];
    self.rightActionLabel.text = aTitle;
    self.rightActionLabel.textAlignment = NSTextAlignmentCenter;
    self.rightActionLabel.textColor = textColor;
    [self.rightActionView addSubview:self.rightActionLabel];
}

-(void)addRightActionImage:(UIImage *)anImage
                    color:(UIColor *)color
                    width:(float)aWidth{
    self.rightActionView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, aWidth, self.mainView.frame.size.height)];
    self.rightActionView.backgroundColor = color;
    [wrapperView addSubview:self.rightActionView];
    
    rightActionWidth = aWidth;
    
    self.rightActionImage = [[UIImageView alloc] initWithImage:anImage];
    self.rightActionImage.frame = CGRectMake(0, 0, aWidth, self.rightActionView.frame.size.height);
    self.rightActionImage.contentMode = UIViewContentModeCenter;
    [self.rightActionView addSubview:self.rightActionImage];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    firstTouch = [touch locationInView:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (canSlide == YES){
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        
        CGRect frame = wrapperView.frame;
        CGFloat xPos;
        
        UITableView *parentTableView = [self parentTableView];
        
        if (touchPoint.x > firstTouch.x && self.leftActionView != nil) {
            [parentTableView setScrollEnabled:NO];
            xPos = touchPoint.x - firstTouch.x;
            if (xPos > leftActionWidth) {
                xPos = leftActionWidth;
            }
            if (xPos <= 0) {
                xPos = 0;
            }
            tint.backgroundColor = self.leftActionView.backgroundColor;
            tint.alpha = (xPos / leftActionWidth) / 15;
            self.leftActionView.alpha = xPos / leftActionWidth;
        }
        
        if (touchPoint.x < firstTouch.x && self.rightActionView != nil){
            [parentTableView setScrollEnabled:NO];
            xPos = -(firstTouch.x - touchPoint.x);
            if (xPos < -rightActionWidth) {
                xPos = -rightActionWidth;
            }
            if (xPos >= 0) {
                xPos = 0;
            }
            tint.backgroundColor = self.rightActionView.backgroundColor;
            tint.alpha = (fabsf(xPos) / rightActionWidth) / 15;
            self.rightActionView.alpha = fabsf(xPos) / rightActionWidth;
        }
        
        frame.origin = CGPointMake(xPos, 0);
        wrapperView.frame = frame;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self springBack];
}


-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self springBack];
}


-(void)springBack {
    canSlide = NO;
    tint.backgroundColor = [UIColor clearColor];
    CGRect frame = wrapperView.frame;
    
    if (frame.origin.x > leftActionWidth - 10 ){
        [delegate cellTriggeredLeftAction:self];
    }
    
    if (frame.origin.x < -rightActionWidth + 10){
        [delegate cellTriggeredRightAction:self];
    }
    
    frame.origin = CGPointMake(0, 0);
    
    [UIView animateWithDuration:0.2
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         wrapperView.frame = frame;
                     }
                     completion:^(BOOL finished){
                         UITableView *parentTableView = [self parentTableView];
                         [parentTableView setScrollEnabled:YES];
                         canSlide = YES;
                     }];
}

- (id)parentTableView {
    UIView *v = [self superview];
    UIView *previous = nil;
    while (v && ![v isKindOfClass:[UITableView class]] && v != previous) {
        previous = v;
        v = [v superview];
    }
    return v == previous ? nil : v;
}

@end
