//
//  VanTableViewMenuController.m
//  VanTableView
//
//  Created by Van on 13/8/14.
//  Copyright (c) 2014年 Vanson. All rights reserved.
//

#import "VanTableViewMenuController.h"

@implementation VanTableViewMenuController

-(id)init
{
    self = [super init];
    if (self)
    {
        self.menus = [NSMutableDictionary new];
        
        
        
        
        NSDictionary * dict =
        @{@"root" : @[
                  [self makeMenuItemWithName:@"MENU ITEM 1"
                                         key:@"menu1"
                                        next:@"menu1_children"],
                  
                  [self makeMenuItemWithName:@"MENU ITEM 2"
                                         key:@"menu2"
                                        next:@"menu2_children"],
                  
                  [self makeMenuItemWithName:@"MENU ITEM 3"
                                         key:@"menu3"
                                        next:@"menu3_children"],
                  ],
          @"menu1_children" : @[
                  [self makeMenuItemWithName:@"CHILD 1"
                                         key:@"child1"
                                        next:@""],
                  
                  [self makeMenuItemWithName:@"CHILD 2"
                                         key:@"child2"
                                        next:@""],
                  
                  [self makeMenuItemWithName:@"CHILD 3"
                                         key:@"child3"
                                        next:@""],
                  ],
          @"menu2_children" : @[
                  [self makeMenuItemWithName:@"CHILD 1"
                                         key:@"child1"
                                        next:@""],
                  
                  [self makeMenuItemWithName:@"CHILD 2"
                                         key:@"child2"
                                        next:@""],
                  
                  [self makeMenuItemWithName:@"CHILD 3"
                                         key:@"child3"
                                        next:@""],
                  ],
          @"menu3_children" : @[
                  [self makeMenuItemWithName:@"CHILD 1"
                                         key:@"child1"
                                        next:@""],
                  
                  [self makeMenuItemWithName:@"CHILD 2"
                                         key:@"child2"
                                        next:@""],
                  
                  [self makeMenuItemWithName:@"CHILD 3"
                                         key:@"child3"
                                        next:@""],
                  ]
          };
        
        [self.menus setDictionary: dict];
    }
    return self;
}


-(void)dealloc
{
    [self.menus release];
    [super dealloc];
}



-(VanTableViewMenuItem*)makeMenuItemWithName:(NSString*)name key:(NSString*)key next:(NSString*)next
{
    VanTableViewMenuItem * item = [[VanTableViewMenuItem alloc] init];
    [item.name setString: name];
    [item.key setString: key];
    [item.next setString: next];
    item.isExpanded = NO;
    return item;
}




-(void)startMenuFromRoot
{
    NSArray * root = self.menus[@"root"];
    
    for (VanTableViewMenuItem * item in root)
    {
        [item.groupName setString: @"root"];
        [self.array addObject: item];
    }
    
    [controller_ manipulateArray: self.array];
}




-(void)toggleMenuItemWithKey:(NSString*)key withinGroupNamed:(NSString*)groupName
{
    
    VanTableViewMenuItem * targetItem = nil;
    int targetIndex = 0;
    
    for (int i = 0; i < [self.array count]; i++)
    {
        VanTableViewMenuItem * item = [self.array objectAtIndex: i];
        
        if ([item.key isEqualToString: key]
            && [item.groupName isEqualToString: groupName])
        {
            targetItem = item;
            targetIndex = i;
            break;
        }
    }
    
    if (targetItem)
    {
        if (targetItem.isExpanded)
        {
            [self collapseTargetItem: targetItem];
        }
        else
        {
            [self expandTargetItem: targetItem targetIndex: targetIndex];
        }
    }
}




-(void)refreshMenuItemWithKey:(NSString*)key withinGroupNamed:(NSString*)groupName
{
    
    VanTableViewMenuItem * targetItem = nil;
    int targetIndex = 0;
    
    for (int i = 0; i < [self.array count]; i++)
    {
        VanTableViewMenuItem * item = [self.array objectAtIndex: i];
        
        if ([item.key isEqualToString: key]
            && [item.groupName isEqualToString: groupName])
        {
            targetItem = item;
            targetIndex = i;
            break;
        }
    }
    
    if (targetItem)
    {
        targetItem.isModified = YES;
        NSLog(@"Refreshing... %d", targetIndex);
        [controller_ manipulateArray: self.array];
    }
}




-(void)expandTargetItem:(VanTableViewMenuItem *)targetItem targetIndex:(int)targetIndex
{
    NSString * childGroupName = targetItem.next;
    NSArray * childItems = [self.menus objectForKey: childGroupName];
    for (int j = [childItems count] - 1; j >= 0; j--)
    {
        VanTableViewMenuItem * childItem = [childItems objectAtIndex:j];
        [childItem.childOf setString: targetItem.key];
        [childItem.groupName setString: childGroupName];
        
        if (j == [childItems count] - 1)
        {
            childItem.isLast = YES;
        }
        
        else if (j == 0)
        {
            childItem.isFirst = YES;
        }
        
        [self.array insertObject: childItem atIndex: targetIndex + 1];
    }
    
    if ([childItems count] > 0)
    {
        targetItem.isExpanded = YES;
    }
    else
    {
        targetItem.isExpanded = NO;
    }
    targetItem.isModified = YES;

    [controller_ manipulateArray: self.array];
}


-(void)collapseTargetItem:(VanTableViewMenuItem *)targetItem
{
    for (int j = [self.array count] - 1; j >= 0; j--)
    {
        VanTableViewMenuItem * item = [self.array objectAtIndex: j];
        if ([item.childOf isEqualToString: targetItem.key])
        {
            [self.array removeObjectAtIndex: j];
        }
    }
    
    targetItem.isExpanded = NO;
    targetItem.isModified = YES;
    
    [controller_ manipulateArray: self.array];
}




-(BOOL)VanTableControllerDataIsModified:(NSObject*)object
{
    if ([object isKindOfClass: [VanTableViewMenuItem class] ])
    {
        VanTableViewMenuItem *item = (VanTableViewMenuItem*)object;
        if (item.isModified)
        {
            item.isModified = NO;
            return YES;
        }
        return NO;
    }
    return NO;
}


-(void)VanTableControllerDidFinishManipulateArray
{
    if (self.tableView)
    {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths: self.indexPathDelete withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView insertRowsAtIndexPaths: self.indexPathInsert withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView reloadRowsAtIndexPaths: self.indexPathReload withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    
    [self.indexPathDelete removeAllObjects];
    [self.indexPathInsert removeAllObjects];
    [self.indexPathReload removeAllObjects];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"[didChangeMenu]" object:nil];
}



@end
