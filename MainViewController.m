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
                      @"First Cell Row with a really long name that probably goes off the cell",
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
    
    [cell addLeftActionImage:[UIImage imageNamed:@"tick"] color:[UIColor colorWithRed:0.157 green:0.761 blue:0.839 alpha:1] width:80];
    
    [cell addRightAction:@"DELETE"
                   color:[UIColor colorWithRed:0.922 green:0.373 blue:0.286 alpha:1]
               textColor:[UIColor whiteColor]
                   width:100];
    
    [cell setDelegate:self];
    
    [cell addFadeEffect];
    [cell addTintEffect];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)cellTriggeredLeftAction:(SlideActionCell *)cell{
    NSLog(@"Left Action Triggered from %@", cell.title.text);
    cell.title.text = @"Left Action Triggered";
}

-(void)cellTriggeredRightAction:(SlideActionCell *)cell{
    NSLog(@"Right Action Triggered from %@", cell.title.text);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableData removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];

}

@end
