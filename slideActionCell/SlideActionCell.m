//
//  SlideActionCell.m
//  slideActionCell
//
//  Created by Thomas Cullen on 12/10/2013.
//  Copyright (c) 2013 Thomas Cullen. All rights reserved.
//

#import "SlideActionCell.h"

@implementation SlideActionCell
#define DragDist 100.0
#define cellHeight 60
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
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.mainView.frame.size.width, cellHeight)];
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
           textColor:(UIColor *)textColor{
    leftActionView = [[UIView alloc] initWithFrame:CGRectMake(0 - DragDist, 0, DragDist, self.mainView.frame.size.height)];
    leftActionView.backgroundColor = color;
    [wrapperView addSubview:leftActionView];
    
    leftActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, leftActionView.frame.size.width, self.mainView.frame.size.height)];
    leftActionLabel.text = aTitle;
    leftActionLabel.textAlignment = NSTextAlignmentCenter;
    leftActionLabel.textColor = textColor;
    [leftActionView addSubview:leftActionLabel];
    
}

-(void)addRightAction:(NSString *)aTitle
                color:(UIColor *)color
            textColor:(UIColor *)textColor{
    rightActionView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, DragDist, self.mainView.frame.size.height)];
    rightActionView.backgroundColor = color;
    [wrapperView addSubview:rightActionView];
    
    rightActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rightActionView.frame.size.width, self.mainView.frame.size.height)];
    rightActionLabel.text = aTitle;
    rightActionLabel.textAlignment = NSTextAlignmentCenter;
    rightActionLabel.textColor = textColor;
    [rightActionView addSubview:rightActionLabel];
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
        
        if (touchPoint.x > firstTouch.x && leftActionView != nil) {
            [parentTableView setScrollEnabled:NO];
            xPos = touchPoint.x - firstTouch.x;
            if (xPos > DragDist) {
                xPos = DragDist;
            }
            if (xPos <= 0) {
                xPos = 0;
            }
            tint.backgroundColor = leftActionView.backgroundColor;
            tint.alpha = (xPos / DragDist) / 15;
            leftActionView.alpha = xPos / DragDist;
        }
        
        if (touchPoint.x < firstTouch.x && rightActionView != nil){
            [parentTableView setScrollEnabled:NO];
            xPos = -(firstTouch.x - touchPoint.x);
            if (xPos < -DragDist) {
                xPos = -DragDist;
            }
            if (xPos >= 0) {
                xPos = 0;
            }
            tint.backgroundColor = rightActionView.backgroundColor;
            tint.alpha = (fabsf(xPos) / DragDist) / 15;
            rightActionView.alpha = fabsf(xPos) / DragDist;
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
    
    if (frame.origin.x > DragDist - 10 ){
        [delegate cellTriggeredLeftAction:self];
    }
    
    if (frame.origin.x < -DragDist + 10){
        [delegate cellTriggeredRightAction:self];
    }
    
    frame.origin = CGPointMake(0, 0);
    
    [UIView animateWithDuration:0.1
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
