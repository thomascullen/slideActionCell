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
        UIScrollView *cellScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight)];
        cellScrollView.contentSize = CGSizeMake(self.frame.size.width, cellHeight);
        cellScrollView.showsHorizontalScrollIndicator = NO;
        cellScrollView.scrollsToTop=NO;
        cellScrollView.delegate = self;
        wrapperView = cellScrollView;
        [self.contentView addSubview:wrapperView];
        
        self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight)];
        self.mainView.backgroundColor = [UIColor clearColor];
        [wrapperView addSubview:self.mainView];
        
        self.tint = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight)];
        self.tint.backgroundColor = [UIColor whiteColor];
        [self.mainView addSubview:self.tint];

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

- (id)parentTableView {
    UIView *v = [self superview];
    UIView *previous = nil;
    while (v && ![v isKindOfClass:[UITableView class]] && v != previous) {
        previous = v;
        v = [v superview];
    }
    return v == previous ? nil : v;
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
    self.leftActionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, aWidth, self.mainView.frame.size.height)];
    self.leftActionView.backgroundColor = color;
    [wrapperView addSubview:self.leftActionView];
    
    leftActionWidth = aWidth;

    self.leftActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, aWidth, self.mainView.frame.size.height)];
    self.leftActionLabel.text = aTitle;
    self.leftActionLabel.textAlignment = NSTextAlignmentCenter;
    self.leftActionLabel.textColor = textColor;
    [self.leftActionView addSubview:self.leftActionLabel];
    
    wrapperView.contentSize = CGSizeMake(wrapperView.frame.size.width + aWidth, cellHeight);
    wrapperView.contentOffset = CGPointMake(aWidth, 0);
    
    self.mainView.frame = CGRectMake(aWidth, 0, self.frame.size.width, cellHeight);
    
}

-(void)addRightAction:(NSString *)aTitle
                color:(UIColor *)color
            textColor:(UIColor *)textColor
                width:(float)aWidth{
    self.rightActionView = [[UIView alloc] initWithFrame:CGRectMake(wrapperView.contentSize.width, 0, aWidth, self.mainView.frame.size.height)];
    self.rightActionView.backgroundColor = color;
    [wrapperView addSubview:self.rightActionView];
    
    rightActionWidth = aWidth;
    
    self.rightActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, aWidth, self.mainView.frame.size.height)];
    self.rightActionLabel.text = aTitle;
    self.rightActionLabel.textAlignment = NSTextAlignmentCenter;
    self.rightActionLabel.textColor = textColor;
    [self.rightActionView addSubview:self.rightActionLabel];
    
    wrapperView.contentSize = CGSizeMake(wrapperView.contentSize.width + aWidth, cellHeight);
}

-(void)addLeftActionImage:(UIImage *)anImage
                    color:(UIColor *)color
                    width:(float)aWidth{
    self.leftActionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, aWidth, self.mainView.frame.size.height)];
    self.leftActionView.backgroundColor = color;
    [wrapperView addSubview:self.leftActionView];
    
    leftActionWidth = aWidth;
    
    self.leftActionImage = [[UIImageView alloc] initWithImage:anImage];
    self.leftActionImage.frame = CGRectMake(0, 0, aWidth, self.leftActionView.frame.size.height);
    self.leftActionImage.contentMode = UIViewContentModeCenter;
    [self.leftActionView addSubview:self.leftActionImage];
        
    wrapperView.contentSize = CGSizeMake(wrapperView.frame.size.width + aWidth, cellHeight);
    wrapperView.contentOffset = CGPointMake(aWidth, 0);
    
    self.mainView.frame = CGRectMake(aWidth, 0, self.frame.size.width, cellHeight);

}

-(void)addRightActionImage:(UIImage *)anImage
                    color:(UIColor *)color
                    width:(float)aWidth{
    self.rightActionView = [[UIView alloc] initWithFrame:CGRectMake(wrapperView.contentSize.width, 0, aWidth, self.mainView.frame.size.height)];
    self.rightActionView.backgroundColor = color;
    [wrapperView addSubview:self.rightActionView];
    
    rightActionWidth = aWidth;
    
    self.rightActionImage = [[UIImageView alloc] initWithImage:anImage];
    self.rightActionImage.frame = CGRectMake(0, 0, aWidth, self.rightActionView.frame.size.height);
    self.rightActionImage.contentMode = UIViewContentModeCenter;
    [self.rightActionView addSubview:self.rightActionImage];
    
    wrapperView.contentSize = CGSizeMake(wrapperView.contentSize.width + aWidth, cellHeight);
}

-(void)addFadeEffect{
    fadeEffect = YES;
}

-(void)removeFadeEffect{
    fadeEffect = NO;
}

-(void)addTintEffect{
    tintEffect = YES;
}

-(void)removeTintEffect{
    tintEffect = NO;
}

-(CGPoint)calculateOffset{
    CGFloat resetContentOffset;
    if ( self.leftActionView ){
        resetContentOffset = self.leftActionView.frame.size.width;
    }else{
        resetContentOffset = 0;
    }
    return CGPointMake(resetContentOffset, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint contentOffset = wrapperView.contentOffset;
    if ( self.leftActionView && contentOffset.x < self.leftActionView.frame.size.width){
        wrapperView.backgroundColor = self.leftActionView.backgroundColor;
        if ( fadeEffect == YES){
            if(contentOffset.x > 0){
                CGFloat percentage = (leftActionWidth / contentOffset.x) / 10;
                self.leftActionView.alpha = percentage;
                wrapperView.backgroundColor = [wrapperView.backgroundColor colorWithAlphaComponent:percentage];
            }else{
                self.leftActionView.alpha = 1;
                wrapperView.backgroundColor = [wrapperView.backgroundColor colorWithAlphaComponent:1];
            }
        }
    }else{
        wrapperView.backgroundColor = self.rightActionView.backgroundColor;
        if ( fadeEffect == YES ){
            CGFloat percentage = (contentOffset.x - [self calculateOffset].x) / rightActionWidth;
            self.rightActionView.alpha = percentage;
            wrapperView.backgroundColor = [wrapperView.backgroundColor colorWithAlphaComponent:percentage];
        }
    }
    
    if ( tintEffect == YES ){
           self.tint.layer.opacity = .9;
    }
    
    // Prevent right scroll bob if no right action is set
    if (!self.rightActionView && contentOffset.x > leftActionWidth){
        [wrapperView setContentOffset:[self calculateOffset]];
    }
    
    // Prevent Left scroll bob is no left action is set
    if (!self.leftActionView && contentOffset.x < 0){
        [wrapperView setContentOffset:[self calculateOffset]];
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat resetContentOffset;
    
    if ( self.leftActionView ){
        resetContentOffset = self.leftActionView.frame.size.width;
    }else{
        resetContentOffset = 0;
    }
    
    [wrapperView setContentOffset:CGPointMake(resetContentOffset, 0) animated:YES];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self calculateAction];
}

-(void)calculateAction{
    CGFloat resetContentOffset;
    CGPoint contentOffset = wrapperView.contentOffset;
    
    if ( self.leftActionView ){
        resetContentOffset = self.leftActionView.frame.size.width;
    }else{
        resetContentOffset = 0;
    }
    
    if ( self.leftActionView && contentOffset.x < 0){
        [delegate cellTriggeredLeftAction:self];
    }
    
    if ( self.rightActionView && contentOffset.x > (resetContentOffset + rightActionWidth)){
        [delegate cellTriggeredRightAction:self];
    }
    
    [wrapperView setContentOffset:CGPointMake(resetContentOffset, 0) animated:YES];
}

@end
