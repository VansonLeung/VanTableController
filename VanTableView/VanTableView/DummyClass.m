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


NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) genRandStringLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}


-(id)init
{
    self = [super init];
    if (self)
    {
        isModified = NO;
        stringA = [NSMutableString new];
        stringB = [NSMutableString new];
        [stringA setString: [self genRandStringLength: 10]];
        [stringB setString: [self genRandStringLength: 5]];
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
