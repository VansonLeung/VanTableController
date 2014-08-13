//
//  VanTableViewFoundation.h
//  VanTableView
//
//  Created by Van on 13/8/14.
//  Copyright (c) 2014年 Vanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VanTableController.h"

@interface VanTableViewFoundation : NSObject
<VanTableControllerDataCriteria,
VanTableControllerDelegate>
{
    VanTableController * controller_;
}
@property (nonatomic, assign) NSMutableArray * array;
@property (nonatomic, assign) NSMutableArray * indexPathDelete;
@property (nonatomic, assign) NSMutableArray * indexPathInsert;
@property (nonatomic, assign) NSMutableArray * indexPathReload;

@end
