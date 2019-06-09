//
//  Element.h
//  LLDebugToolDemo
//
//  Created by haleli on 2019/5/21.
//  Copyright © 2019 li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tree.h"
@class Tree ;
NS_ASSUME_NONNULL_BEGIN

@interface Element : NSObject
@property (copy , nonatomic , nonnull) NSString *elementId ;
@property (copy , nonatomic , nonnull) NSString *elementName ;
@property (nonatomic, assign) NSInteger clickTimes ;
@property (nonatomic ,assign) BOOL isTreeChanged ;
@property (nonatomic , assign) BOOL isJumped ;
@property (nonatomic , assign) BOOL isBack ;
@property (nonatomic , strong) Tree *toTree ;
@property (copy , nonatomic , nonnull) NSString *type ;
- (instancetype)initWithElementId:(NSString*)elementId elementName:(NSString*)elementName type:(NSString*)type;
- (NSInteger) getElementScore ;
@end

@interface IOSElement : Element
@property (copy , nonatomic , nonnull) NSString *accessbilityIdentifier ;
@end

@interface CocosElement:Element

@end

NS_ASSUME_NONNULL_END
