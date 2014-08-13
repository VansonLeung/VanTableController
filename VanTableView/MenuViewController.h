//
//  MenuViewController.h
//  VanTableView
//
//  Created by Van on 13/8/14.
//  Copyright (c) 2014年 Vanson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VanTableViewMenuController.h"

@interface MenuViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView * tableView_;
    VanTableViewMenuController * menuController_;
}
@end
