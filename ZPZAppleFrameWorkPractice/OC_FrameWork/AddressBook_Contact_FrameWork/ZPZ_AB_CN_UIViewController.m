//
//  ZPZ_AB_CN_UIViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZ_AB_CN_UIViewController.h"
#import <ContactsUI/ContactsUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ZPZCommonMethod.h"

@interface ZPZ_AB_CN_UIViewController ()<CNContactPickerDelegate,ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ZPZ_AB_CN_UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    button.frame = CGRectMake(20, 20, self.view.frame.size.width - 2 * 20, 50);
    button.layer.cornerRadius = button.frame.size.height / 2;
    button.layer.masksToBounds = YES;
    [button setTitle:@"打开系统通讯录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickedToOpenUI) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickedToOpenUI{
    if ([ZPZCommonMethod isCurrentVersionGreaterOrEqualVersion:9.0]) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusNotDetermined:
                {
                    CNContactStore * store = [[CNContactStore alloc] init];
                    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (granted) {
                                [self gotoOpenUI];
                            }else{
                                [self showNotAllowedTip];
                            }
                        });
                    }];
                }
                break;
            case CNAuthorizationStatusDenied:
            case CNAuthorizationStatusRestricted:{
                [self showNotAllowedTip];
            }
                break;
            case CNAuthorizationStatusAuthorized:{
                [self gotoOpenUI];
            }
                break;
            default:
                break;
        }
        
    }else{
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusNotDetermined:
                {
                    ABAddressBookRef addressBook = ABAddressBookCreate();
                    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (granted) {
                                [self gotoOpenUI];
                            }else{
                                [self showNotAllowedTip];
                            }
                        });
                    });
                    CFRelease(addressBook);
                }
                break;
            case kABAuthorizationStatusDenied:
            case kABAuthorizationStatusRestricted:{
                [self showNotAllowedTip];
            }
                break;
            case kABAuthorizationStatusAuthorized:{
                [self gotoOpenUI];
            }
                break;
            default:
                break;
        }
    }
}

- (void)gotoOpenUI{
    if ([ZPZCommonMethod isCurrentVersionGreaterOrEqualVersion:9.0]) {
        CNContactPickerViewController * pickerVC = [[CNContactPickerViewController alloc] init];
        pickerVC.delegate = self;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }else{
        //不是这个
//        ABPersonViewController * personVC = [[ABPersonViewController alloc] init];
//        [self presentViewController:personVC animated:YES completion:nil];
        ABPeoplePickerNavigationController * pickerVC = [[ABPeoplePickerNavigationController alloc] init];
        pickerVC.peoplePickerDelegate = self;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }
}

- (void)showNotAllowedTip{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您关闭了我们的权限，您可以去设置中去手动打开" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * knowAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
        UIAlertAction * goAction = [UIAlertAction actionWithTitle:@"去打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alertVC addAction:goAction];
    }
    [alertVC addAction:knowAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    //选中单个就返回
    NSLog(@"%@",contact);
}

//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts{
//    //选中多个，点击完成返回
//}
//
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
//    //选中联系人的某个属性就返回
//}
//
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty *> *)contactProperties{
//    //选中多个联系人，返回多个联系人的该属性，会受到CNContactPickerViewController的predicateForSelectionOfProperty的影响，且需要设置
//}

#pragma mark - ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
    //选中了某个联系人即返回
    NSLog(@"%@",person);
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    //选中了某个联系人的某个属性返回
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
