//
//  VanTableViewMenuController.h
//  VanTableView
//
//  Created by Van on 13/8/14.
//  Copyright (c) 2014年 Vanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VanTableViewFoundation.h"
#import "VanTableViewMenuItem.h"

@interface VanTableViewMenuController : VanTableViewFoundation
@property (nonatomic, assign) UITableView * tableView;
@property (nonatomic, retain) NSMutableDictionary * menus;

-(void)startMenuFromRoot;
-(void)toggleMenuItemWithKey:(NSString*)key withinGroupNamed:(NSString*)groupName;
-(void)refreshMenuItemWithKey:(NSString*)key withinGroupNamed:(NSString*)groupName;

-(void)expandTargetItem:(VanTableViewMenuItem *)targetItem targetIndex:(int)targetIndex;
-(void)collapseTargetItem:(VanTableViewMenuItem *)targetItem;
@end
