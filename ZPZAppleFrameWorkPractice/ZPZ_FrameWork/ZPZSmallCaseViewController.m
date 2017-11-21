//
//  ZPZSmallCaseViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/20.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZSmallCaseViewController.h"

@interface ZPZSmallCaseViewController ()

@end

@implementation ZPZSmallCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self showTimeZone];
//    [self dateFromStr:@"2017-10-20 10:23:29"];
    [self stringFromDate];
}

/**
 * 时区
 */
- (void)showTimeZone{
    NSTimeZone * localZone = [NSTimeZone localTimeZone];
    NSTimeZone * systemZone = [NSTimeZone systemTimeZone];
    NSTimeZone * defaultZone = [NSTimeZone defaultTimeZone];
    NSLog(@"%@\n%@\n%@\n",localZone.description,systemZone.description,defaultZone.description);//Local Time Zone (Asia/Shanghai (GMT+8) offset 28800)
    //Asia/Shanghai (GMT+8) offset 28800
    //Asia/Shanghai (GMT+8) offset 28800
}

/**
 * 字符串转时间
 */
- (void)dateFromStr:(NSString *)str{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    //什么都不加的时候，此时输出2017-10-20 02:23:29 +0000，和本地时区时输出一样
    
    //添加下面两行，此时输出 2017-10-20 10:23:29 +0000
//    NSTimeZone * zone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//    formatter.timeZone = zone;
    
    //此时输出2017-10-20 02:23:29 +0000
//    NSTimeZone * localZone = [NSTimeZone localTimeZone];
//    formatter.timeZone = localZone;
    NSDate * date = [formatter dateFromString:str];
    NSLog(@"%@\n%@",date.description,[NSDate date].description);
}

- (void)stringFromDate{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    //什么都不加的时候，输出2017-10-20 18:36:23
    //添加下面两行，输出2017-10-20 10:37:01
    NSTimeZone * zone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.timeZone = zone;
    
    NSString * dateStr = [formatter stringFromDate:[NSDate date]]; //date为2017-10-20 18:36:23打印的log
    NSLog(@"%@",dateStr);
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
