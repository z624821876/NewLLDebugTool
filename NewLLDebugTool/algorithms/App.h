//
//  App.h
//  LLDebugToolDemo
//
//  Created by haleli on 2019/6/5.
//  Copyright © 2019 li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tree.h"
#import "FindElementTree.h"

NS_ASSUME_NONNULL_BEGIN

@interface App : NSObject
@property (nonatomic , strong) NSMutableDictionary<NSString* , Tree*> *trees ;
+ (instancetype)sharedApp;
-(Tree *)getCurrentTree;
-(void) updateTree:(Tree*)tree ;
@end

NS_ASSUME_NONNULL_END
