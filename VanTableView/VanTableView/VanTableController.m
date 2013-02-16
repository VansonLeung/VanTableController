//
//  VanTableViewController.m
//  VanTableView
//
//  Created by Vanson on 16/2/13.
//  Copyright (c) 2013 Vanson. All rights reserved.
//

#import "VanTableController.h"

@implementation VanTableController
@synthesize dataCriteria;
@synthesize delegate;
@synthesize nextArray = nextArray_;
@synthesize prevArray = prevArray_;
@synthesize isStrictMode = isStrictMode_;

-(id)init
{
    self = [super init];
    if (self)
    {
        isStrictMode_ = NO;
        nextArray_ = [NSMutableArray new];
        prevArray_ = [NSMutableArray new];
        arrayComparer = [[VanArrayComparer alloc] init];
        [arrayComparer setDataCriteria:self];
    }
    return self;
}

-(void)dealloc
{
    [nextArray_ release];
    [prevArray_ release];
    [super dealloc];
}




-(void)queueNewArray:(NSArray*)array
{
    [nextArray_ setArray: array];
}

-(NSArray*)compareForObjectsDeleted
{
    NSArray *indicesDeleted = [arrayComparer compareForObjectsDeletedStrictMode: isStrictMode_ withNextArray:nextArray_ withPrevArray:prevArray_];
    return indicesDeleted;
}

-(void)deleteIndicesFromPrevArray:(NSArray*)indices
{
    for (NSNumber* index in indices)
    {
        uint uIndex = [index unsignedIntValue];
        [prevArray_ removeObjectAtIndex: uIndex];
    }
}

-(NSArray*)compareForObjectsInserted
{
    NSArray *indicesInserted = [arrayComparer compareForObjectsInsertedStrictMode: isStrictMode_ withNextArray:nextArray_ withPrevArray:prevArray_];
    return indicesInserted;
}


-(void)insertIndicesToPrevArray:(NSArray*)indices
{
    for (NSNumber* index in indices)
    {
        uint uIndex = [index unsignedIntValue];
        NSObject * nextObj = [nextArray_ objectAtIndex: uIndex];
        [prevArray_ insertObject:nextObj atIndex:uIndex];
    }
}



-(NSArray*)compareForObjectsModified
{
    NSArray * indicesModified = [arrayComparer compareForObjectsModifiedWithArray:nextArray_];
    return indicesModified;
}



// VanArrayComparerDataCriteria

-(BOOL)VanArrayComparerDataIsModified:(NSObject *)object
{
    if (dataCriteria)
    {
        if ([dataCriteria respondsToSelector:@selector(VanTableControllerDataIsModified:)] )
        {
            return ([dataCriteria VanTableControllerDataIsModified:object]);
        }
    }
    return NO;
}





-(void)saveCurrentArray
{
    [prevArray_ setArray: nextArray_];
}


#pragma mark - Public Methods

-(void)manipulateArray:(NSArray*)array
{
    [self queueNewArray: array];
    NSArray * indicesDeleted = [self compareForObjectsDeleted];
    [self deleteIndicesFromPrevArray: indicesDeleted];
    NSArray * indicesInserted = [self compareForObjectsInserted];
    [self insertIndicesToPrevArray: indicesInserted];
    NSArray * indicesModified = [self compareForObjectsModified];
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(VanTableControllerDataIndicesDeleted:indicesInserted:indicesModified:)])
        {
            [delegate VanTableControllerDataIndicesDeleted:indicesDeleted
                                           indicesInserted:indicesInserted
                                           indicesModified:indicesModified];
        }
    }
    [self saveCurrentArray];
    if (delegate)
    {
        if ([delegate respondsToSelector:@selector(VanTableControllerDidFinishManipulateArray)])
        {
            [delegate VanTableControllerDidFinishManipulateArray];
        }
    }
}




@end

