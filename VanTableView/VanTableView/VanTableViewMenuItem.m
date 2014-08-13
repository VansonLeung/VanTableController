//
//  VanTableViewMenuItem.m
//  VanTableView
//
//  Created by Van on 13/8/14.
//  Copyright (c) 2014年 Vanson. All rights reserved.
//

#import "VanTableViewMenuItem.h"

@implementation VanTableViewMenuItem

-(id)init
{
    self = [super init];
    if (self)
    {
        self.name = [NSMutableString new];
        self.key = [NSMutableString new];
        self.next = [NSMutableString new];
        self.childOf = [NSMutableString new];
        self.groupName = [NSMutableString new];
    }
    return self;
}

-(void)dealloc
{
    [self.name release];
    [self.key release];
    [self.next release];
    [self.childOf release];
    [self.groupName release];
    [super dealloc];
}

@end
