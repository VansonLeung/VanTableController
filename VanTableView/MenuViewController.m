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
     [UIColor colorWithRed:226.0f/255.0f
                     green:29.0f/255.0f
                      blue:38.0f/255.0f
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
    
    if ([item.groupName isEqualToString:@"root"] && ![item isExpanded])
    {
        [cell.contentView setBackgroundColor:
         [UIColor colorWithRed:226.0f/255.0f
                         green:29.0f/255.0f
                          blue:38.0f/255.0f
                         alpha:1]];
        
        [cell.textLabel setTextColor: [UIColor whiteColor]];
        [cell.detailTextLabel setTextColor: [UIColor whiteColor]];
        [cell.textLabel setFont: [UIFont fontWithName:@"HelveticaNeue" size:16]];
    }
    else
    {
        [cell.contentView setBackgroundColor:
         [UIColor colorWithRed:255.0f/255.0f
                         green:255.0f/255.0f
                          blue:255.0f/255.0f
                         alpha:1]];

        [cell.textLabel setTextColor: [UIColor grayColor]];
        [cell.detailTextLabel setTextColor: [UIColor grayColor]];
        [cell.textLabel setBackgroundColor: [UIColor clearColor]];
        [cell.detailTextLabel setBackgroundColor: [UIColor clearColor]];
        [cell setBackgroundColor: [UIColor clearColor]];
        
        if ([item.groupName isEqualToString:@"root"])
        {
            UIImageView * shadow = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"shadow_top.png"]];
            [shadow setFrame:CGRectMake(0, 0,
                                           cell.bounds.size.width, 5)];
            [shadow setContentMode:UIViewContentModeScaleToFill];
            [shadow setTag: -101];
            [cell addSubview: shadow];
            
            [cell.textLabel setFont: [UIFont fontWithName:@"HelveticaNeue" size:16]];
        }
        else
        {
            if (item.isLast)
            {
                UIImageView * shadow = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"shadow_bottom.png"]];
                [shadow setFrame:CGRectMake(0, 38 - 5,
                                               cell.bounds.size.width, 5)];
                [shadow setContentMode:UIViewContentModeScaleToFill];
                [shadow setTag: -102];
                [cell addSubview: shadow];
            }
            
            [cell.textLabel setFont: [UIFont fontWithName:@"HelveticaNeue" size:13]];
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    VanTableViewMenuItem * item = [menuController_.array objectAtIndex:indexPath.row];

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
