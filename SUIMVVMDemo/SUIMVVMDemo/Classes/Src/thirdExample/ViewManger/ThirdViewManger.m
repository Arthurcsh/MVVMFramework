//
//  ThirdViewManger.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdViewManger.h"
#import "FirstVC.h"
#import "ThirdView.h"
#import "UIView+ViewDelegateAdditions.h"

@interface ThirdViewManger ()<SMKViewProtocolDelegate>
@property (nonatomic, weak) ThirdView *thirdView;
@end

@implementation ThirdViewManger

- (ThirdView *)thirdView {
    if (_thirdView == nil) {
        ThirdView *thirdView = [ThirdView svv_loadInstanceFromNib];
        _thirdView = thirdView;
        _thirdView.delegate = self;
    }
    return _thirdView;
}

// 两种消息传递方式，开发时任选其一即可
- (void)smk_viewMangerWithSubView:(UIView *)subView {
    
    __weak typeof(self.thirdView) weakThirdView =  self.thirdView;
    __weak typeof(self) weakSelf = self;
    
    // btnClickBlock
    weakThirdView.btnClickBlock = ^() {
        [weakSelf smk_viewMangerWithHandleOfSubView:weakThirdView info:@"click"];
    };
}

// 两种消息传递方式，开发时任选其一即可
- (void)smk_view:(__kindof UIView *)view withEvents:(NSDictionary *)events {
    
    NSLog(@"----------%@", events);
    
    if ([[events allKeys] containsObject:@"jump"]) {
        FirstVC *firstVC = [UIViewController svv_viewControllerWithStoryBoardName:@"Main" identifier:@"FirstVCID"];
        [view.sui_currentVC.navigationController pushViewController:firstVC animated:YES];
    }
    
}

- (void)smk_viewMangerWithSuperView:(UIView *)superView {
    self.thirdView.frame = CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, 200);
    [superView addSubview:self.thirdView];
}

- (void)smk_viewMangerWithHandleOfSubView:(UIView *)view info:(NSString *)info {
    
    if ([info isEqualToString:@"click"]) {
        [view configureViewWithCustomObj:self.smk_model];
    }
}

@end
