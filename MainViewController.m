//
//  MainViewController.m
//  slideActionCell
//
//  Created by Thomas Cullen on 12/10/2013.
//  Copyright (c) 2013 Thomas Cullen. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableData = [NSMutableArray arrayWithObjects:
                      @"First Cell Row",
                      @"Second Cell Row",
                      @"Third Cell Row",
                      @"Fourth Cell Row",
                      @"Fifth Cell Row",
                      @"Sixth Cell Row",
                      @"Seventh Cell Row",
                      @"Eight Cell Row",
                      @"Ninth Cell Row",
                      @"Tenth Cell Row",
                      @"Cell number 11",
                      @"Cell number 12",
                      @"13",
                      @"14",
                      nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"Cell";
    [self.tableView registerClass:[SlideActionCell class] forCellReuseIdentifier:cellIdentifier];
    
    SlideActionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell){
        cell = [[SlideActionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setText:self.tableData[indexPath.row]];
    
    if (indexPath.row == 2){
        
        [cell addLeftActionImage:[UIImage imageNamed:@"tick"]
                           color:[UIColor colorWithRed:0.157 green:0.761 blue:0.839 alpha:1]
                           width:80];
        
    }else{
        
        [cell addLeftAction:@"YES"
                      color:[UIColor colorWithRed:0.157 green:0.761 blue:0.839 alpha:1]
                  textColor:[UIColor whiteColor]
                      width:100];

    }
    
    [cell addRightAction:@"DELETE"
                   color:[UIColor colorWithRed:0.922 green:0.373 blue:0.286 alpha:1]
               textColor:[UIColor whiteColor]
                   width:100];
    
    [cell setDelegate:self];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)cellTriggeredLeftAction:(SlideActionCell *)cell{
    NSLog(@"Left Action Triggered from %@", cell.title.text);
    
    if ( [cell.title.text  isEqual: @"Complete"]){
        cell.title.text = @"Not Complete";
        cell.leftActionView.backgroundColor = [UIColor colorWithRed:0.529 green:0.855 blue:0.318 alpha:1];
    }else{
        cell.title.text = @"Complete";
        cell.leftActionView.backgroundColor = [UIColor colorWithRed:0.922 green:0.373 blue:0.286 alpha:1];
    }
    
}

-(void)cellTriggeredRightAction:(SlideActionCell *)cell{
    NSLog(@"Right Action Triggered from %@", cell.title.text);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableData removeObjectAtIndex:indexPath.row];
    

}

@end
