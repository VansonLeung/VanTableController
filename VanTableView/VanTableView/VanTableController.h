//
//  VanTableViewController.h
//  VanTableView
//
//  Created by Vanson on 16/2/13.
//  Copyright (c) 2013 Vanson. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "VLog.h"
#import "VanArrayComparer.h"

@protocol VanTableControllerDataCriteria <NSObject>
@required
-(BOOL) VanTableControllerDataIsModified:(NSObject*)object;
@end

@protocol VanTableControllerDelegate <NSObject>
@required
-(void) VanTableControllerDataIndicesDeleted:(NSArray*)indicesDeleted indicesInserted:(NSArray*)indicesInserted indicesModified:(NSArray*)indicesModified;
-(void) VanTableControllerDidFinishManipulateArray;
@end

@interface VanTableController : NSObject
<VanArrayComparerDataCriteria>
{
    VanArrayComparer * arrayComparer;
}


@property (nonatomic, assign) id<VanTableControllerDataCriteria> dataCriteria;
@property (nonatomic, assign) id<VanTableControllerDelegate> delegate;

@property (nonatomic, readwrite) BOOL isStrictMode;

@property (nonatomic, assign) NSMutableArray * nextArray;
@property (nonatomic, assign) NSMutableArray * prevArray;

-(void)manipulateArray:(NSArray*)array;

@end
