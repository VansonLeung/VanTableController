//
//  ViewController.m
//  VanTableView
//
//  Created by Vanson on 16/2/13.
//  Copyright (c) 2013 Vanson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUnitTestChangeArray) name:@"[didUnitTestChangeArray]" object:nil];
        
        unitTest_ = [[VanTableViewControllerUnitTest alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelector:@selector(unitTest) withObject:nil afterDelay:1.0];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)unitTest
{
    [unitTest_ testObjectStrictMode:NO];
    
}



-(void)didUnitTestChangeArray
{
    [tableView_ beginUpdates];
    [tableView_ deleteRowsAtIndexPaths: unitTest_.indexPathDelete withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView_ insertRowsAtIndexPaths: unitTest_.indexPathInsert withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView_ reloadRowsAtIndexPaths: unitTest_.indexPathReload withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView_ endUpdates];
    
    [unitTest_.indexPathDelete removeAllObjects];
    [unitTest_.indexPathInsert removeAllObjects];
    [unitTest_.indexPathReload removeAllObjects];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [unitTest_.array count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCell"];
    }
    
    DummyClass * dummy = [unitTest_.array objectAtIndex:indexPath.row];
    [cell.textLabel setText: dummy.stringA];
    
    return cell;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
