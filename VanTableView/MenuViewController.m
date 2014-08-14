//
//  MenuViewController.m
//  VanTableView
//
//  Created by Van on 13/8/14.
//  Copyright (c) 2014年 Vanson. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeMenu) name:@"[didChangeMenu]" object:nil];
        menuController_ = [[VanTableViewMenuController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [menuController_ setTableView: tableView_];
    [menuController_ startMenuFromRoot];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




-(void)didChangeMenu
{
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuController_.array count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setBackgroundColor:
     [UIColor colorWithRed:238.0f/255.0f
                     green:77.0f/255.0f
                      blue:88.0f/255.0f
                     alpha:1]];

    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCell"];
    }
    
    VanTableViewMenuItem * item = [menuController_.array objectAtIndex:indexPath.row];
    [cell.textLabel setText: item.name];
    [cell.detailTextLabel setText: item.groupName];
    
    [[cell viewWithTag: -101] removeFromSuperview];
    [[cell viewWithTag: -102] removeFromSuperview];
    [[cell viewWithTag: -103] removeFromSuperview];
    
    if ([item.groupName isEqualToString:@"root"] && ![item isExpanded])
    {
        if ([menuController_.array count] > indexPath.row + 1)
        {
            VanTableViewMenuItem * nextItem = [menuController_.array objectAtIndex:indexPath.row + 1];
            if ([nextItem.groupName isEqualToString:@"root"] && !nextItem.isExpanded)
            {
                UIImageView * shadow = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"menu_separator.png"]];
                [shadow setFrame:CGRectMake(10, 54.0,
                                            cell.bounds.size.width - 20, 2)];
                [shadow setContentMode:UIViewContentModeScaleToFill];
                [shadow setTag: -103];
                [cell addSubview: shadow];
            }
        }
        
        [cell.contentView setBackgroundColor:
         [UIColor colorWithRed:238.0f/255.0f
                         green:77.0f/255.0f
                          blue:88.0f/255.0f
                         alpha:1]];
        
        [cell.textLabel setTextColor: [UIColor whiteColor]];
        [cell.detailTextLabel setTextColor: [UIColor whiteColor]];
        [cell.textLabel setFont: [UIFont fontWithName:@"HelveticaNeue" size:16]];
    }
    else
    {
        [cell.contentView setBackgroundColor:
         [UIColor colorWithRed:245.0f/255.0f
                         green:245.0f/255.0f
                          blue:245.0f/255.0f
                         alpha:1]];

        [cell.textLabel setBackgroundColor: [UIColor clearColor]];
        [cell.detailTextLabel setBackgroundColor: [UIColor clearColor]];
        [cell setBackgroundColor: [UIColor clearColor]];
        
        if ([item.groupName isEqualToString:@"root"])
        {
            UIImageView * shadow = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"shadow_top.png"]];
            [shadow setFrame:CGRectMake(0, 0,
                                           cell.bounds.size.width, 10)];
            [shadow setContentMode:UIViewContentModeScaleToFill];
            [shadow setTag: -101];
            [cell addSubview: shadow];
            
            [cell.textLabel setFont: [UIFont fontWithName:@"HelveticaNeue" size:16]];
            [cell.textLabel setTextColor: [UIColor grayColor]];
            [cell.detailTextLabel setTextColor: [UIColor grayColor]];
        }
        else
        {
            if (item.isLast)
            {
                UIImageView * shadow = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"shadow_bottom.png"]];
                [shadow setFrame:CGRectMake(0, 38 - 10,
                                               cell.bounds.size.width, 10)];
                [shadow setContentMode:UIViewContentModeScaleToFill];
                [shadow setTag: -102];
                [cell addSubview: shadow];
            }
            
            [cell.textLabel setFont: [UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell.textLabel setTextColor:
             [UIColor colorWithRed:238.0f/255.0f
                             green:77.0f/255.0f
                              blue:88.0f/255.0f
                             alpha:1]];
            [cell.detailTextLabel setTextColor:
             [UIColor colorWithRed:238.0f/255.0f
                             green:77.0f/255.0f
                              blue:88.0f/255.0f
                             alpha:1]];
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    VanTableViewMenuItem * item = [menuController_.array objectAtIndex:indexPath.row];

    if ([item.groupName isEqualToString:@"root"])
    {
        
        for (int i = 0; i < [menuController_.array count]; i++)
        {
            VanTableViewMenuItem * _item = [menuController_.array objectAtIndex:i];
            if (_item.isExpanded
                && (
                    ![_item.key isEqualToString: item.key]
                    || ![_item.groupName isEqualToString: item.groupName]
                    )
                )
            {
                [menuController_ collapseTargetItem: _item];
            }
            
            NSLog(@"%@ %@ %@ %@", _item.key, _item.groupName, item.key, item.groupName);
        }
        
        [menuController_ toggleMenuItemWithKey:item.key withinGroupNamed: item.groupName];

    }
    
    else
    {
        // do something here
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VanTableViewMenuItem * item = [menuController_.array objectAtIndex:indexPath.row];
    
    if ([item.groupName isEqualToString:@"root"])
    {
        return 56.0f;
    }
    else
    {
        return 38.0f;
    }
    
}


@end
