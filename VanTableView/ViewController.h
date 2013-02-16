//
//  ViewController.h
//  VanTableView
//
//  Created by Vanson on 16/2/13.
//  Copyright (c) 2013 Vanson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VanTableViewControllerUnitTest.h"

@interface ViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView * tableView_;
    VanTableViewControllerUnitTest * unitTest_;
}
@end
