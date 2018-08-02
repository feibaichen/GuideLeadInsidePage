//
//  TViewController.m
//  DePurDemo
//
//  Created by Karl on 2018/6/2.
//  Copyright © 2018年 Derek. All rights reserved.
//

#import "TViewController.h"
#import "HHShootButton.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface TViewController ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) HHShootButton *button;
@property (nonatomic,assign) CGRect itemFrame;
@end

@implementation TViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
//    _itemFrame = [self getTabBarItemFrameWithCount:self.tabBarController.tabBar.items.count index:2];
//    
//    NSLog(@"itemFrame x: %f y: %f w: %f h: %f",_itemFrame.origin.x,_itemFrame.origin.y,_itemFrame.size.width,_itemFrame.size.height);
    
    [self initView];
    [self initAnimationButton];

    
    
    NSUserDefaults *defa = [NSUserDefaults standardUserDefaults];
    
    if ([defa objectForKey:@"coinMustRun"]) {
        
    }else{
        
        [_button sendActionsForControlEvents:UIControlEventTouchUpInside];
        
        [defa setObject:@"No" forKey:@"coinMustRun"];
        [defa synchronize];
        
    }
    
    
}
- (void)initView{
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 20, 20)];
    _iconImageView.image = [UIImage imageNamed:@"coin"];
    [self.view addSubview:_iconImageView];
}

- (void)initAnimationButton{
    
    _button = [[HHShootButton alloc] initWithFrame:CGRectMake(_itemFrame.origin.x, SCREEN_HEIGHT - 49 - 22, 22, 22) andEndPoint:self.iconImageView.center];
    [_button setImage:[UIImage imageNamed:@"coin"] forState:UIControlStateNormal];
    _button.setting.animationType = ShootButtonAnimationTypeLine;
    [self.view addSubview:_button];
    
//    HHShootButton *shootBtn = [[HHShootButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT - 80, 22, 22) andEndPoint:self.iconImageView.center];
//    [shootBtn setImage:[UIImage imageNamed:@"icon_xin"] forState:UIControlStateNormal];
//    shootBtn.setting.animationType = ShootButtonAnimationTypeLine;
//    [self.view addSubview:shootBtn];
}
- (CGRect)getTabBarItemFrameWithCount:(NSInteger)count index:(NSInteger)index
{
    NSInteger i = 0;
    CGRect itemFrame = CGRectZero;
    for (UIView *view in self.tabBarController.tabBar.subviews) {
        if (![NSStringFromClass([view class]) isEqualToString:@"UITabBarButton"]) {
            continue;
        }
        //找到指定的tabBarItem
        if (index == i++) {
            itemFrame = view.frame;
            break;
        }
    }
    
    return itemFrame;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
