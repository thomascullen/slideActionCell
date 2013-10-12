//
//  SlideActionCell.h
//  slideActionCell
//
//  Created by Thomas Cullen on 12/10/2013.
//  Copyright (c) 2013 Thomas Cullen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SlideActionCell;
@protocol SlideActionCellDelegate <NSObject>

@required
-(void)cellTriggeredLeftAction:(SlideActionCell *)cell;
-(void)cellTriggeredRightAction:(SlideActionCell *)cell;

@end

@interface SlideActionCell : UITableViewCell{
    CGPoint firstTouch;
    UIView *wrapperView;
    UIView *tint;
    BOOL canSlide;
    float leftActionWidth;
    float rightActionWidth;
    id <SlideActionCellDelegate> delegate;
    
}

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UILabel *title;

@property (strong, nonatomic) UIView *leftActionView;
@property (strong, nonatomic) UILabel *leftActionLabel;
@property (strong, nonatomic) UIImageView *leftActionImage;

@property (strong, nonatomic) UIView *rightActionView;
@property (strong, nonatomic) UILabel *rightActionLabel;
@property (strong, nonatomic) UIImageView *rightActionImage;

-(void)setText:(NSString *)text;
-(void)setDelegate:(id)aDelegate;

-(void)addLeftAction:(NSString *)aTitle
               color:(UIColor *)color
           textColor:(UIColor *)textColor
               width:(float)aWidth;

-(void)addLeftActionImage:(UIImage *)anImage
                    color:(UIColor *)color
                    width:(float)aWidth;

-(void)addRightAction:(NSString *)aTitle
               color:(UIColor *)color
            textColor:(UIColor *)textColor
                width:(float)aWidth;

-(void)addRightActionImage:(UIImage *)anImage
                    color:(UIColor *)color
                    width:(float)aWidth;

@end
