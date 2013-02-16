//
//  VanArrayComparer.m
//  VanTableView
//
//  Created by Vanson on 16/2/13.
//  Copyright (c) 2013 Vanson. All rights reserved.
//

#import "VanArrayComparer.h"

@implementation VanArrayComparer
@synthesize dataCriteria;

-(NSArray*)compareForObjectsDeletedStrictMode:(BOOL)isStrictMode withNextArray:(NSArray*) nextArray withPrevArray:(NSArray*) prevArray
{
    int count = 0;
    NSMutableArray * indices = [[NSMutableArray new] autorelease];
    
    if ([prevArray count] > 0) for (int p = [prevArray count] - 1; p >= 0; p--)
    {
        NSObject * prevObj = [prevArray objectAtIndex: p];
        
        BOOL objShouldBeDeleted = YES;
        if ([nextArray count] > 0) for (int n = [nextArray count] - 1; n >= 0; n--)
        {
            NSObject * nextObj = [nextArray objectAtIndex: n];
            
            /* compare! */
            if (isStrictMode)
            {
                if (nextObj == prevObj)
                {
                    objShouldBeDeleted = NO;
                    break;
                }
            }
            else
            {
                if ([nextObj isEqual: prevObj])
                {
                    objShouldBeDeleted = NO;
                    break;
                }
            }
        }
        
        if (objShouldBeDeleted)
        {
            // object is present in prevArray BUT not in nextArray
            count ++;
            [indices addObject: [NSNumber numberWithUnsignedInt: p]];
        }
    }
    
    VLog(@"\%@ Compare Array For objects DELETED: \n%d objects DELETED; \nindex list : %@",
         (isStrictMode)?@"STRICT":@"",
         count,
         indices);
    
    return [NSArray arrayWithArray:indices];
}





-(NSArray*)compareForObjectsInsertedStrictMode:(BOOL)isStrictMode withNextArray:(NSArray*) nextArray withPrevArray:(NSArray*) prevArray
{
    int count = 0;
    NSMutableArray * indices = [[NSMutableArray new] autorelease];
    
    if ([nextArray count] > 0) for (int n = [nextArray count] - 1; n >= 0; n--)
    {
        NSObject * nextObj = [nextArray objectAtIndex: n];
        
        BOOL objShouldBeInserted = YES;
        if ([prevArray count] > 0) for (int p = [prevArray count] - 1; p >= 0; p--)
        {
            NSObject * prevObj = [prevArray objectAtIndex: p];
            
            /* compare! */
            if (isStrictMode)
            {
                if (nextObj == prevObj)
                {
                    objShouldBeInserted = NO;
                    break;
                }
            }
            else
            {
                if ([nextObj isEqual: prevObj])
                {
                    objShouldBeInserted = NO;
                    break;
                }
            }
        }
        
        if (objShouldBeInserted)
        {
            // object is present in prevArray BUT not in nextArray
            count ++;
            [indices insertObject: [NSNumber numberWithUnsignedInt: n] atIndex:0];
        }
    }
    
    VLog(@"\%@ Compare Array For objects INSERTED: \n%d objects INSERTED; \nindex list : %@",
         (isStrictMode)?@"STRICT":@"",
         count,
         indices);
    
    return [NSArray arrayWithArray:indices];
}







-(NSArray*)compareForObjectsModifiedWithArray:(NSArray*) array
{
    int count = 0;
    NSMutableArray * indices = [[NSMutableArray new] autorelease];
    
    if ([array count] > 0) for (int n = [array count] - 1; n >= 0; n--)
    {
        NSObject * object = [array objectAtIndex: n];
        
        BOOL objShouldBeTheSame = YES;

        if (dataCriteria)
        {
            if ([dataCriteria respondsToSelector:@selector(VanArrayComparerDataIsModified:)])
            {
                if ([dataCriteria VanArrayComparerDataIsModified:object])
                {
                    objShouldBeTheSame = NO;
                }
            }
        }
        
        if (!objShouldBeTheSame)
        {
            // object is present in prevArray BUT not in nextArray
            count ++;
            [indices insertObject: [NSNumber numberWithUnsignedInt: n] atIndex:0];
        }
    }
    
    VLog(@"\nCompare Array For objects MODIFIED: \n%d objects MODIFIED; \nindex list : %@",
         count,
         indices);
    
    return [NSArray arrayWithArray:indices];
}




@end
