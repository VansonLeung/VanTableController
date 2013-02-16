//
//  VLog.h
//  VanTableView
//
//  Created by Vanson on 16/2/13.
//  Copyright (c) 2013 Vanson. All rights reserved.
//

#ifdef DEBUG
#define VLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define VLog( s, ... )
#endif
