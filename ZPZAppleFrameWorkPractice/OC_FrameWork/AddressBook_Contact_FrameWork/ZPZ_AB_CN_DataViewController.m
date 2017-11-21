//
//  ZPZ_AB_CN_DataViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/25.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZ_AB_CN_DataViewController.h"
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import "ZPZCommonMethod.h"

@interface ZPZ_AB_CN_DataViewController ()

@end

@implementation ZPZ_AB_CN_DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    readButton.backgroundColor = [UIColor orangeColor];
    readButton.frame = CGRectMake(20, 20, self.view.frame.size.width - 2 * 20, 50);
    readButton.layer.cornerRadius = readButton.frame.size.height / 2;
    readButton.layer.masksToBounds = YES;
    [readButton setTitle:@"read" forState:UIControlStateNormal];
    [readButton addTarget:self action:@selector(clickedReadLocalData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readButton];
}

- (void)clickedReadLocalData{
    if ([ZPZCommonMethod isNeedNewContactFrameWork]) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusNotDetermined:{
                CNContactStore * store = [[CNContactStore alloc] init];
                [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (granted) {
                            [self gotoReadData];
                        }else{
                            [self showNotAllowedTip];
                        }
                    });
                }];
            }
                break;
            case CNAuthorizationStatusAuthorized:{
                [self gotoReadData];
            }
                break;
            case CNAuthorizationStatusDenied:
            case CNAuthorizationStatusRestricted:{
                [self showNotAllowedTip];
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
                            [self gotoReadData];
                        }else{
                            [self showNotAllowedTip];
                        }
                    });
                });
                CFRelease(addressBook);
            }
                break;
            case kABAuthorizationStatusAuthorized:{
                [self gotoReadData];
            }
                break;
            case kABAuthorizationStatusDenied:
            case kABAuthorizationStatusRestricted:{
                [self showNotAllowedTip];
            }
            default:
                break;
        }
    }
}

- (void)gotoReadData{
    if ([ZPZCommonMethod isNeedNewContactFrameWork]) {
        CNContactStore * store = [[CNContactStore alloc] init];
        CNContactFetchRequest * request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactGivenNameKey,CNContactNicknameKey,CNContactPhoneNumbersKey]];
        BOOL isEnume = [store enumerateContactsWithFetchRequest:request error:NULL usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            NSLog(@"phone:%@",contact.phoneNumbers);
        }];
        if (!isEnume) {
            NSLog(@"read error");
        }
    }else{
        ABAddressBookRef addressBook = ABAddressBookCreate();
        CFArrayRef recordArr = ABAddressBookCopyArrayOfAllPeople(addressBook);
        for (CFIndex i = 0; i < CFArrayGetCount(recordArr); i++) {
            ABRecordRef multiValue = CFArrayGetValueAtIndex(recordArr, i);
            NSLog(@"%@",ABRecordCopyValue(multiValue, kABPersonLastNameProperty));
        }
        NSLog(@"%@",recordArr);
        CFRelease(recordArr);
        CFRelease(addressBook);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
