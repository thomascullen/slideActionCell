//
//  SlideActionCell.h
//  slideActionCell
//
//  Created by Thomas Cullen on 12/10/2013.
//  Copyright (c) 2013 Thomas Cullen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideActionCell : UITableViewCell{
    CGPoint firstTouch;
    UIView *wrapperView;
    UIView *tint;
    
    UIView *leftActionView;
    UILabel *leftActionLabel;
    
    UIView *rightActionView;
    UILabel *rightActionLabel;
    
    BOOL canSlide;
    
}

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UILabel *title;

-(void)setText:(NSString *)text;

-(void)addLeftAction:(NSString *)aTitle
               color:(UIColor *)color
           textColor:(UIColor *)textColor;

-(void)addRightAction:(NSString *)aTitle
               color:(UIColor *)color
            textColor:(UIColor *)textColor;

@end
