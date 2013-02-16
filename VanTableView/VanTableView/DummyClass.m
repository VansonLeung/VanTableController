//
//  DummyClass.m
//  VanTableView
//
//  Created by Vanson on 16/2/13.
//  Copyright (c) 2013 Vanson. All rights reserved.
//

#import "DummyClass.h"

@implementation DummyClass

@synthesize isModified;
@synthesize stringA, stringB;

-(id)init
{
    self = [super init];
    if (self)
    {
        isModified = NO;
        stringA = [NSMutableString new];
        stringB = [NSMutableString new];
    }
    return self;
}



-(void)dealloc
{
    [stringA release];
    [stringB release];
    [super dealloc];
}



@end
