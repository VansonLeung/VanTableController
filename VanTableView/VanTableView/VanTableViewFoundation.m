//
//  VanTableViewFoundation.m
//  VanTableView
//
//  Created by Van on 13/8/14.
//  Copyright (c) 2014年 Vanson. All rights reserved.
//

#import "VanTableViewFoundation.h"

@implementation VanTableViewFoundation
@synthesize array;
@synthesize indexPathDelete;
@synthesize indexPathInsert;
@synthesize indexPathReload;

-(id)init
{
    self = [super init];
    if (self)
    {
        controller_ = [[VanTableController alloc] init];
        array = [NSMutableArray new];
        indexPathDelete = [NSMutableArray new];
        indexPathInsert = [NSMutableArray new];
        indexPathReload = [NSMutableArray new];
        
        controller_.dataCriteria = self;
        controller_.delegate = self;
        controller_.isStrictMode = NO;
    }
    return self;
}

-(void)dealloc
{
    [controller_ release];
    [array release];
    [indexPathDelete release];
    [indexPathInsert release];
    [indexPathReload release];
    [super dealloc];
}




-(BOOL)VanTableControllerDataIsModified:(NSObject*)object
{
    return NO;
}



-(void)VanTableControllerDataIndicesDeleted:(NSArray *)indicesDeleted indicesInserted:(NSArray *)indicesInserted indicesModified:(NSArray *)indicesModified
{
    
    for (NSNumber * index in indicesDeleted)
    {
        uint uIndex = [index unsignedIntValue];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:uIndex inSection:0];
        [indexPathDelete insertObject:indexPath atIndex:0];
    }
    for (NSNumber * index in indicesInserted)
    {
        uint uIndex = [index unsignedIntValue];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:uIndex inSection:0];
        [indexPathInsert addObject:indexPath];
    }
    for (NSNumber * index in indicesModified)
    {
        uint uIndex = [index unsignedIntValue];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:uIndex inSection:0];
        
        BOOL isUnique = YES;
        for (NSIndexPath * _indexPath in indexPathDelete)
        {
            if (indexPath.length == _indexPath.length && indexPath.section == _indexPath.section && indexPath.row == _indexPath.row)
            {
                isUnique = NO;
                break;
            }
        }
        
        if (isUnique)
        {
            [indexPathReload addObject:indexPath];
        }
    }
    
    VLog(@"D %@ I %@ R %@", indexPathDelete, indexPathInsert, indexPathReload);
}


-(void)VanTableControllerDidFinishManipulateArray
{

}

@end
