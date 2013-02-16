//
//  VanTableViewControllerUnitTest.m
//  VanTableView
//
//  Created by Vanson on 16/2/13.
//  Copyright (c) 2013 Vanson. All rights reserved.
//

#import "VanTableViewControllerUnitTest.h"

@implementation VanTableViewControllerUnitTest
@synthesize array;
@synthesize indexPathDelete;
@synthesize indexPathInsert;
@synthesize indexPathReload;

-(id)init
{
    self = [super init];
    if (self)
    {
        array = [NSMutableArray new];
        indexPathDelete = [NSMutableArray new];
        indexPathInsert = [NSMutableArray new];
        indexPathReload = [NSMutableArray new];
    }
    return self;
}

-(void)dealloc
{
    [array release];
    [indexPathDelete release];
    [indexPathInsert release];
    [indexPathReload release];
    [super dealloc];
}

-(void)testStringStrictMode:(BOOL)isStrictMode
{
    VanTableController * controller = [[VanTableController alloc] init];
    controller.isStrictMode = isStrictMode;
    
    [array addObject: @"ABC"];
    [array addObject: @"DEF"];
    [array addObject: @"GHI"];
    [array addObject: @"JKL"];
    
    [controller manipulateArray: array];
    
    [array removeObjectAtIndex:2];
    [array removeObjectAtIndex:0];
    [array addObject: @"ABC"];
    
    [controller manipulateArray: array];
    
    [VanTableController release];
    
    [array release];
    
    
    VLog(@"STRICT ====");
    VLog(@"STRICT ====");
    VLog(@"STRICT ====");
    VLog(@"STRICT ====");
    
    
    controller = [[VanTableController alloc] init];
    [controller setIsStrictMode: YES];
    
    array = [NSMutableArray new];
    [array addObject: @"ABC"];
    [array addObject: @"DEF"];
    [array addObject: @"GHI"];
    [array addObject: @"JKL"];
    
    [controller manipulateArray: array];
    
    [array removeObjectAtIndex:2];
    [array removeObjectAtIndex:0];
    [array addObject: @"ABC"];
    
    [controller manipulateArray: array];
    
    [VanTableController release];
}

-(void)testObjectStrictMode:(BOOL)isStrictMode
{
    VanTableController * controller = [[VanTableController alloc] init];
    controller.dataCriteria = self;
    controller.delegate = self;
    controller.isStrictMode = isStrictMode;

    ///// ROUND 1 - INSERT OBJ
    
    for (int i = 0; i < 5; i++)
    {
        DummyClass * dummy = [[DummyClass alloc] init];
        
        [dummy addObserver:self forKeyPath:@"stringA" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        
        [array addObject: dummy];
    }
    
    [controller manipulateArray: array];

    ///// ROUND 2 - DELETE OBJ , THEN INSERT OBJ
    
    [array removeObjectAtIndex:2];
    [array removeObjectAtIndex:0];
    
    for (int i = 0; i < 5; i++)
    {
        DummyClass * dummy = [[DummyClass alloc] init];
        
        [dummy addObserver:self forKeyPath:@"stringA" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        
        [array addObject: dummy];
    }
    
    for (int i = 0; i < 5; i++)
    {
        DummyClass * dummy = [[DummyClass alloc] init];
        
        [dummy addObserver:self forKeyPath:@"stringA" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        
        [array insertObject: dummy atIndex:0];
    }
    
    [controller manipulateArray: array];
    
    ///// ROUND 3 - MODIFY OBJ
    
    [array setArray: array];
    DummyClass * dummy__ = [array objectAtIndex:2];
    [dummy__.stringA setString: @"ASJKANSDJKSAD"];
    dummy__.isModified = YES;
    
    [controller manipulateArray: array];
    
    
    
    ///// ROUND 4 - DELETE, INSERT, MODIFY OBJ
    
    
    
    
    [array removeObjectAtIndex:12];
    [array removeObjectAtIndex:11];
    [array removeObjectAtIndex:9];
    [array removeObjectAtIndex:7];
    
    for (int i = 0; i < 5; i++)
    {
        DummyClass * dummy = [[DummyClass alloc] init];
        
        [dummy addObserver:self forKeyPath:@"stringA" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        
        [array addObject: dummy];
    }
    
    for (int i = 0; i < 5; i++)
    {
        DummyClass * dummy = [[DummyClass alloc] init];
        
        [dummy addObserver:self forKeyPath:@"stringA" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        
        [array insertObject: dummy atIndex:0];
    }
    
    
    [array setArray: array];
    dummy__ = [array objectAtIndex:3];
    [dummy__.stringA setString: @"ASJKANSDJKSAD"];
    dummy__.isModified = YES;
    
    dummy__ = [array objectAtIndex:5];
    [dummy__.stringB setString: @"ASJKANSDJKSAD"];
    dummy__.isModified = YES;
    
    [controller manipulateArray: array];
    
    
    /// END
    
    [VanTableController release];
}


-(BOOL)VanTableControllerDataIsModified:(NSObject*)object
{
    if ([object isKindOfClass: [DummyClass class] ])
    {
        DummyClass *dummy = (DummyClass*)object;
        if (dummy.isModified)
        {
            dummy.isModified = NO;
            return YES;
        }
        return NO;
    }
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
        [indexPathReload addObject:indexPath];
    }
    
    VLog(@"%@ %@ %@", indexPathDelete, indexPathInsert, indexPathReload);
}


-(void)VanTableControllerDidFinishManipulateArray
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"[didUnitTestChangeArray]" object:nil];
}

@end
