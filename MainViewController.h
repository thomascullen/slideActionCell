//
//  MainViewController.h
//  slideActionCell
//
//  Created by Thomas Cullen on 12/10/2013.
//  Copyright (c) 2013 Thomas Cullen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideActionCell.h"

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SlideActionCellDelegate>
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
