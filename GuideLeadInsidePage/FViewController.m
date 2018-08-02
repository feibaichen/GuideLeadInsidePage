//
//  FViewController.m
//  DePurDemo
//
//  Created by Derek on 2018/6/2.
//  Copyright © 2018年 Derek. All rights reserved.
//

#import "FViewController.h"

@interface FViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIView *backBaseView;
@property (nonatomic,strong) UIScrollView *guideScrollView;
@property (nonatomic,strong) UIButton *hideButton;
@property (nonatomic,strong) UIView *indicateView;
@property (nonatomic,assign) CGRect itemFrame;
@end

@implementation FViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemWasClick:) name:@"TabbarItemClick" object:nil];
    
    _itemFrame = [self getTabBarItemFrameWithCount:self.tabBarController.tabBar.items.count index:2];
    
    NSLog(@"itemFrame x: %f y: %f w: %f h: %f",_itemFrame.origin.x,_itemFrame.origin.y,_itemFrame.size.width,_itemFrame.size.height);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults valueForKey:@"itemWasClick"]) {
        
    }else{
        [self.tabBarController.tabBar addSubview:self.indicateView];
    }
    
    if ([defaults valueForKey:@"almostSign"]) {
        
        
    }else{
        
        [self insideGuide];
    }

}
-(void)itemWasClick:(NSNotification *)sender{
    
    NSLog(@"itemWasClick");
    
     __weak __typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.indicateView removeFromSuperview];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:@"Yes" forKey:@"itemWasClick"];
        [defaults synchronize];
    });
}
-(void)insideGuide{
    
    UIWindow *win = [[UIApplication sharedApplication].windows lastObject];
    [win addSubview:self.backBaseView];

    [_backBaseView addSubview:self.guideScrollView];
    
    NSArray *imageArrays = @[@"1.jpg",@"2.jpg",@"3.jpg"];
    for (int i = 0; i < imageArrays.count; i++) {
        UIImageView *imageA = [[UIImageView alloc] initWithFrame:CGRectMake(30 + i * [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - 400,200,200)];
        imageA.image = [UIImage imageNamed:imageArrays[i]];
        imageA.backgroundColor = [UIColor orangeColor];
        imageA.contentMode = UIViewContentModeScaleAspectFill;
        imageA.clipsToBounds = YES;
        [_guideScrollView addSubview:imageA];
    }
    
    [_backBaseView addSubview:self.hideButton];
    
}
-(void)clickToHide{
    
    
    _backBaseView.hidden = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@"yes" forKey:@"almostSign"];
    [defaults synchronize];
    
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
-(UIView *)backBaseView{
    if (!_backBaseView) {
        _backBaseView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backBaseView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"transparency"]];
    }
    return _backBaseView;
}
-(UIScrollView *)guideScrollView{
    if (!_guideScrollView) {
        _guideScrollView = [[UIScrollView alloc] initWithFrame:_backBaseView.frame];
        _guideScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, [UIScreen mainScreen].bounds.size.height);
        _guideScrollView.showsHorizontalScrollIndicator = NO;
        _guideScrollView.pagingEnabled = YES;
        _guideScrollView.delegate = self;
        _guideScrollView.contentOffset = CGPointMake(0, 0);
    }
    return _guideScrollView;
}
-(UIButton *)hideButton{
    
    if (!_hideButton) {
        _hideButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _hideButton.backgroundColor = [UIColor whiteColor];
        _hideButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_hideButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _hideButton.center = CGPointMake(_backBaseView.frame.size.width/2, _backBaseView.frame.size.height/2 + _backBaseView.frame.size.height/3);
        [_hideButton addTarget:self action:@selector(clickToHide) forControlEvents:UIControlEventTouchUpInside];
        [_hideButton setTitle:@"退出引导" forState:UIControlStateNormal];
    }
    return _hideButton;
}
-(UIView *)indicateView{
    if (!_indicateView) {
        _indicateView = [[UIView alloc] initWithFrame:CGRectMake(_itemFrame.origin.x, -50, _itemFrame.size.width - 20, _itemFrame.size.height - 10)];
        _indicateView.backgroundColor = [UIColor purpleColor];
        _indicateView.alpha = 0.4;
    }
    return _indicateView;
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
