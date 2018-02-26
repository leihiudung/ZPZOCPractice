//
//  ViewController.m
//  ZPZPhotoPractice
//
//  Created by zhoupengzu on 2018/2/26.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZAssetViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)gotoAssetViewController:(id)sender {
    ZPZAssetViewController * assetVC = [[ZPZAssetViewController alloc] init];
    [self.navigationController pushViewController:assetVC animated:YES];
}



@end
