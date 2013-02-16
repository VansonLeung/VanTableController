//
//  VanTableViewControllerUnitTest.h
//  VanTableView
//
//  Created by Vanson on 16/2/13.
//  Copyright (c) 2013 Vanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VanTableController.h"
#import "VLog.h"
#import "DummyClass.h"

@interface VanTableViewControllerUnitTest : NSObject
<VanTableControllerDataCriteria,
VanTableControllerDelegate>

@property (nonatomic, assign) NSMutableArray * array;
@property (nonatomic, assign) NSMutableArray * indexPathDelete;
@property (nonatomic, assign) NSMutableArray * indexPathInsert;
@property (nonatomic, assign) NSMutableArray * indexPathReload;

-(void)testStringStrictMode:(BOOL)isStrictMode;
-(void)testObjectStrictMode:(BOOL)isStrictMode;

@end
