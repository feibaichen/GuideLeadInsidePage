//
//  MyTabBarController.m
//  GuideLeadInsidePage
//
//  Created by MacOS on 2018/7/16.
//  Copyright © 2018年 MacOS. All rights reserved.
//

#import "MyTabBarController.h"
#import "FViewController.h"
#import "SViewController.h"
#import "TViewController.h"

@interface MyTabBarController ()<UITabBarDelegate>

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FViewController *f = [[FViewController alloc]init];
    UINavigationController * fnav = [[UINavigationController alloc]initWithRootViewController:f];
    SViewController *s = [[SViewController alloc]init];
    UINavigationController * snav = [[UINavigationController alloc]initWithRootViewController:s];
    TViewController *t = [[TViewController alloc]init];
    UINavigationController * tnav = [[UINavigationController alloc]initWithRootViewController:t];
    
    UITabBarItem * fitem = [[UITabBarItem alloc] init];
    fitem.title = @"First";
    f.tabBarItem = fitem;
    UITabBarItem * sitem = [[UITabBarItem alloc] init];
    sitem.title = @"Second";
    s.tabBarItem = sitem;
    UITabBarItem * titem = [[UITabBarItem alloc] init];
    titem.title = @"Three";
    t.tabBarItem = titem;
    
    fitem.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fitem.selectedImage = [[UIImage imageNamed:@"home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    sitem.image = [[UIImage imageNamed:@"news"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    sitem.selectedImage = [[UIImage imageNamed:@"news_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    titem.image = [[UIImage imageNamed:@"my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    titem.selectedImage = [[UIImage imageNamed:@"my_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = @[fnav,snav,tnav];
    
    
    
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

    NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
    
    if ([[Defaults valueForKey:@"itemWasClick"] isEqualToString:@"Yes"]) {
        
    }else{
        if ([item.title isEqualToString:@"Three"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TabbarItemClick" object:nil userInfo:@{@"itemClick":@"2"}];
            NSLog(@"mydidSelectItem = %@",item.title);
        }
    }
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
