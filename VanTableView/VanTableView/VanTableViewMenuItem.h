//
//  VanTableViewMenuItem.h
//  VanTableView
//
//  Created by Van on 13/8/14.
//  Copyright (c) 2014年 Vanson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VanTableViewMenuItem : NSObject
@property (nonatomic, retain) NSMutableString * name;
@property (nonatomic, retain) NSMutableString * key;
@property (nonatomic, retain) NSMutableString * next;
@property (nonatomic, retain) NSMutableString * childOf;
@property (nonatomic, retain) NSMutableString * groupName;
@property (nonatomic, readwrite) BOOL isExpanded;
@property (nonatomic, readwrite) BOOL isModified;
@end
