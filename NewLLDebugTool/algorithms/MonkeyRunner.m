//
//  MonkeyRunner.m
//  LLDebugToolDemo
//
//  Created by haleli on 2019/6/5.
//  Copyright © 2019 li. All rights reserved.
//

#import "MonkeyRunner.h"

@implementation MonkeyRunner

- (instancetype)initWithAlgorithm: (id<MonkeyAlgorithmDelegate>) algorithm{
    self = [super init] ;
    if(self){
        _preTree = nil ;
        _curTree = nil ;
        _preElement = nil ;
        _algorithm = algorithm ;
    }
    return self ;
}

/***
 A界面 点击 元素E 跳转到 界面B
 _preTree : A界面
 _preElement : 元素E
 _curTree : 界面B
 ***/
-(void)runOneStep{
    
    Tree* tree =[[App sharedApp] getCurrentTree] ;
    //更新树
    [[App sharedApp] updateTree: tree] ;
    
    if(_preTree && _preElement && tree && [_preTree isSameTreeId:tree]){
        _preElement.isBack = YES ;
        _preTree = nil ;
        _curTree = nil ;
    }
    
    if(_curTree && tree && _preElement && ![_curTree isSameTreeId:tree] && !_preElement.isBack){
        _preElement.isJumped = true ;
        _preElement.toTree = tree ;
    }else if(_curTree && tree && _preElement && ![_curTree isSameTree: tree] && !_preElement.isBack){
        _preElement.isTreeChanged = true ;
    }
    
    if(tree && _curTree && ![tree isSameTreeId:_curTree]){
        _preTree = _curTree ;
    }
    
    _curTree = tree ;
    
    //从树里面选择一个控件
    Element *element = [_algorithm chooseElementFromTree:_curTree] ;
    
    if(element == nil){
        //需要返回上一个界面
        _preElement = nil ;
        _preTree = nil ;
        _curTree = nil ;
        [BackActions back] ;
        
    }else{
        _preElement = element ;
        [self OperateElement:element] ;
        element.clickTimes = element.clickTimes + 1 ;
    }
    
}

-(void)OperateElement:(Element *)element{
    //40%的概率发送UI事件
    //查找控件树
  
    NSString *accessibilityIdentifier = element.elementId;
    NSString *className = element.type ;

    if([className isEqual:@"UITableView"]){
        NSLog(@"haleli >>>> test monkey,UITableView swipe action") ;
        [UITableViewActions swipeTableViewWithAccessibilityIdentifier:accessibilityIdentifier] ;
    }else if([className isEqual:@"UISwitch"]){
        NSLog(@"haleli >>>> test monkey,UISwitch tap action") ;
        [UISwitchActions setSwitchWithAccessibilityIdentifier:accessibilityIdentifier] ;
    }else if([className isEqual:@"UITabBar"]){
        NSLog(@"haleli >>>> test monkey,UITabBar tap action") ;
        [UITabBarActions tapTabBarWithAccessibilityIdentifier:accessibilityIdentifier] ;
    }else if([className isEqual:@"UINavigationBar"]){
        NSLog(@"haleli >>>> test monkey,UINavigationBar tap action") ;
        [UINavigationBarActions tapNavigationBarWithAccessibilityIdentifier:accessibilityIdentifier] ;
    }else if([className isEqual:@"UITextField"]){
        NSLog(@"haleli >>>> test monkey,UITextFieldActions enter text action") ;
        [UITextFieldActions clearTextFromAndThenEnterTextWithAccessibilityIdentifier:accessibilityIdentifier] ;
    }else if([className isEqual:@"UIButton"]){
        NSLog(@"haleli >>>> test monkey,UIButton tap action") ;
        [UIButtonActions tapButtonWithAccessibilityIdentifier:accessibilityIdentifier] ;
    }else if([className isEqual:@"UISegmentedControl"]){
        NSLog(@"haleli >>>> test monkey,UISegmentedControl tap action") ;
        [UISegmentedControlActions tapSegmentedControlWithAccessibilityIdentifier:accessibilityIdentifier] ;
    }else if([className isEqual:@"UICollectionView"]){
        NSLog(@"haleli >>>> test monkey,UICollectionView swipe action") ;
        [UICollectionViewActions swipeCollectionViewWithAccessibilityIdentifier:accessibilityIdentifier] ;
        
    }else if([className isEqual:@"UITableViewCell"]){
        NSLog(@"haleli >>>> test monkey,UITableViewCell tap action") ;
        [UITableViewCellActions tapTableViewCellWithAccessibilityIdentifier:accessibilityIdentifier] ;
    }else if([className isEqual:@"UICollectionViewCell"]){
        NSLog(@"haleli >>>> test monkey,UICollectionViewCell tap action") ;
        [UICollectionViewCellActions tapCollectionViewCellWithAccessibilityIdentifier:accessibilityIdentifier] ;
    }
    else{
        NSLog(@"haleli >>>> test monkey,no support view : %@",className) ;
    }
}
@end
