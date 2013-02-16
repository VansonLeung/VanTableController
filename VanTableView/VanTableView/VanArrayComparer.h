//
//  VanArrayComparer.h
//  VanTableView
//
//  Created by Vanson on 16/2/13.
//  Copyright (c) 2013 Vanson. All rights reserved.
//

@protocol VanArrayComparerDataCriteria <NSObject>
@required
-(BOOL) VanArrayComparerDataIsModified:(NSObject*)object;
@end

#import <Foundation/Foundation.h>
#import "VLog.h"
@interface VanArrayComparer : NSObject

@property (nonatomic, assign) id<VanArrayComparerDataCriteria> dataCriteria;

-(NSArray*)compareForObjectsDeletedStrictMode:(BOOL)isStrictMode withNextArray:(NSArray*) nextArray withPrevArray:(NSArray*) prevArray;
-(NSArray*)compareForObjectsInsertedStrictMode:(BOOL)isStrictMode withNextArray:(NSArray*) nextArray withPrevArray:(NSArray*) prevArray;
-(NSArray*)compareForObjectsModifiedWithArray:(NSArray*) array;
@end
