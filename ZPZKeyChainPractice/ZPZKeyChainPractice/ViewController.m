//
//  ViewController.m
//  ZPZKeyChainPractice
//
//  Created by zhoupengzu on 2017/12/19.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configUI];
}

- (void)configUI {
    CGFloat margin = 15;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 2 * margin;
    CGFloat height = 50;
    CGFloat beginY = 20;

    UIButton * addButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"添加" andSEL:@selector(saveBasicInfo)];
    [self.view addSubview:addButton];
    beginY = CGRectGetMaxY(addButton.frame) + 20;
    UIButton * matchButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"查找" andSEL:@selector(keychainMatching)];
    [self.view addSubview:matchButton];
    beginY = CGRectGetMaxY(matchButton.frame) + 20;
    UIButton * deleteButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"直接删除" andSEL:@selector(deleteItemDirect)];
    [self.view addSubview:deleteButton];
    beginY = CGRectGetMaxY(deleteButton.frame) + 20;
    UIButton * delQueryButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"先查再删除" andSEL:@selector(deleteItemWithQuery)];
    [self.view addSubview:delQueryButton];
    beginY = CGRectGetMaxY(delQueryButton.frame) + 20;
    UIButton * updateButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"更新" andSEL:@selector(updateItem)];
    [self.view addSubview:updateButton];
    beginY = CGRectGetMaxY(updateButton.frame) + 20;
    UIButton * updateQueryButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"先查再更新" andSEL:@selector(updateItemAfterSearch)];
    [self.view addSubview:updateQueryButton];
    beginY = CGRectGetMaxY(updateQueryButton.frame) + 20;
    UIButton * shareButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"数据共享" andSEL:@selector(addKeyChainForShare)];
    [self.view addSubview:shareButton];
}

- (void)addKeyChainForShare {
    CFMutableDictionaryRef mutableDicRef = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(mutableDicRef, kSecClass, kSecClassGenericPassword);  //类型
    NSString *perfix = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"AppIdentifierPrefix"];
    CFStringRef groupRef = (__bridge_retained CFStringRef)[perfix stringByAppendingString:@"pengzuzhou.ZPZKeyChainPractice.personal"];
    CFDictionarySetValue(mutableDicRef, kSecAttrAccessGroup, groupRef);
    CFDateRef dateRef = CFDateCreate(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent());
    CFDictionarySetValue(mutableDicRef, kSecAttrCreationDate, dateRef);  //创建时间
    CFStringRef strRef = CFSTR("save generic password 2");
    CFDictionarySetValue(mutableDicRef, kSecAttrDescription, strRef);  //描述
    CFStringRef commentStrRef = CFSTR("generic password comment 2");
    CFDictionarySetValue(mutableDicRef, kSecAttrComment, commentStrRef); //备注、注释
    CFNumberRef creatorRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberCharType, "zhou");
    CFDictionarySetValue(mutableDicRef, kSecAttrCreator, creatorRef);  //创建者，只能是四个字符长度
    CFNumberRef typeRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberCharType, "type");
    CFDictionarySetValue(mutableDicRef, kSecAttrType, typeRef);   // 类型
    CFStringRef labelRef = CFSTR("label 2");
    CFDictionarySetValue(mutableDicRef, kSecAttrLabel, labelRef); //标签，用户可以看到
    CFDictionarySetValue(mutableDicRef, kSecAttrIsInvisible, kCFBooleanTrue);  //是否不可见、是否隐藏（kCFBooleanTrue、kCFBooleanFalse）
    CFDictionarySetValue(mutableDicRef, kSecAttrIsNegative, kCFBooleanFalse); //标记是否有密码（kCFBooleanTrue、kCFBooleanFalse）
    CFStringRef accountRef = CFSTR("zhoupengzu_basic 2");
    CFDictionarySetValue(mutableDicRef, kSecAttrAccount, accountRef);  //账户
    CFStringRef serviceRef = CFSTR("service");
    CFDictionarySetValue(mutableDicRef, kSecAttrService, serviceRef);  //所具有的服务
    CFMutableDataRef genericRef = CFDataCreateMutable(kCFAllocatorDefault, 0);
    char * generic_char = "personal generic 2";
    CFDataAppendBytes(genericRef, (const UInt8 *)generic_char, sizeof("personal generic 2"));
    CFDictionarySetValue(mutableDicRef, kSecAttrGeneric, genericRef);  //用户自定义
    CFDictionarySetValue(mutableDicRef, kSecValueData, genericRef);  //保存值
    OSStatus status = SecItemAdd(mutableDicRef, nil);  //相同的东西只能添加一次，不能重复添加，重复添加会报错
    if (status == errSecSuccess) {
        NSLog(@"success");
    } else {
        NSLog(@"%@",@(status));
    }
    if (accountRef) {
        CFRelease(accountRef);
    }
    if (serviceRef) {
        CFRelease(serviceRef);
    }
    if (genericRef) {
        CFRelease(genericRef);
    }
    if (labelRef) {
        CFRelease(labelRef);
    }
    if (typeRef) {
        CFRelease(typeRef);
    }
    if (creatorRef) {
        CFRelease(creatorRef);
    }
    if (commentStrRef) {
        CFRelease(commentStrRef);
    }
    if (strRef) {
        CFRelease(strRef);
    }
    if (dateRef) {
        CFRelease(dateRef);
    }
    if (mutableDicRef) {
        CFRelease(mutableDicRef);
    }
}

- (void)saveBasicInfo {
    CFMutableDictionaryRef mutableDicRef = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(mutableDicRef, kSecClass, kSecClassGenericPassword);  //类型
    CFDateRef dateRef = CFDateCreate(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent());
    CFDictionarySetValue(mutableDicRef, kSecAttrCreationDate, dateRef);  //创建时间
    CFStringRef strRef = CFSTR("save generic password 2");
    CFDictionarySetValue(mutableDicRef, kSecAttrDescription, strRef);  //描述
    CFStringRef commentStrRef = CFSTR("generic password comment 2");
    CFDictionarySetValue(mutableDicRef, kSecAttrComment, commentStrRef); //备注、注释
    CFNumberRef creatorRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberCharType, "zhou");
    CFDictionarySetValue(mutableDicRef, kSecAttrCreator, creatorRef);  //创建者，只能是四个字符长度
    CFNumberRef typeRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberCharType, "type");
    CFDictionarySetValue(mutableDicRef, kSecAttrType, typeRef);   // 类型
    CFStringRef labelRef = CFSTR("label 2");
    CFDictionarySetValue(mutableDicRef, kSecAttrLabel, labelRef); //标签，用户可以看到
    CFDictionarySetValue(mutableDicRef, kSecAttrIsInvisible, kCFBooleanTrue);  //是否不可见、是否隐藏（kCFBooleanTrue、kCFBooleanFalse）
    CFDictionarySetValue(mutableDicRef, kSecAttrIsNegative, kCFBooleanFalse); //标记是否有密码（kCFBooleanTrue、kCFBooleanFalse）
    CFStringRef accountRef = CFSTR("zhoupengzu_basic 2");
    CFDictionarySetValue(mutableDicRef, kSecAttrAccount, accountRef);  //账户
    CFStringRef serviceRef = CFSTR("service");
    CFDictionarySetValue(mutableDicRef, kSecAttrService, serviceRef);  //所具有的服务
    CFMutableDataRef genericRef = CFDataCreateMutable(kCFAllocatorDefault, 0);
    char * generic_char = "personal generic 2";
    CFDataAppendBytes(genericRef, (const UInt8 *)generic_char, sizeof("personal generic 2"));
    CFDictionarySetValue(mutableDicRef, kSecAttrGeneric, genericRef);  //用户自定义
    CFDictionarySetValue(mutableDicRef, kSecValueData, genericRef);  //保存值
    OSStatus status = SecItemAdd(mutableDicRef, nil);  //相同的东西只能添加一次，不能重复添加，重复添加会报错
    if (status == errSecSuccess) {
        NSLog(@"success");
    } else {
        NSLog(@"%@",@(status));
    }
    if (accountRef) {
        CFRelease(accountRef);
    }
    if (serviceRef) {
        CFRelease(serviceRef);
    }
    if (genericRef) {
        CFRelease(genericRef);
    }
    if (labelRef) {
        CFRelease(labelRef);
    }
    if (typeRef) {
        CFRelease(typeRef);
    }
    if (creatorRef) {
        CFRelease(creatorRef);
    }
    if (commentStrRef) {
        CFRelease(commentStrRef);
    }
    if (strRef) {
        CFRelease(strRef);
    }
    if (dateRef) {
        CFRelease(dateRef);
    }
    if (mutableDicRef) {
        CFRelease(mutableDicRef);
    }
}

- (OSStatus)keychainMatching {
    CFMutableDictionaryRef queryDic = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    //查找类型
    CFDictionarySetValue(queryDic, kSecClass, kSecClassGenericPassword);
    //匹配的属性 越详细，越精准
//    CFStringRef strRef = CFSTR("save generic password");
//    CFDictionarySetValue(queryDic, kSecAttrDescription, strRef);  //描述
//    CFStringRef commentStrRef = CFSTR("generic password comment");
//    CFDictionarySetValue(queryDic, kSecAttrComment, commentStrRef); //备注、注释
//    CFNumberRef creatorRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberCharType, "zhou");
//    CFDictionarySetValue(queryDic, kSecAttrCreator, creatorRef);  //创建者，只能是四个字符长度
//    CFNumberRef typeRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberCharType, "type");
//    CFDictionarySetValue(queryDic, kSecAttrType, typeRef);   // 类型
//    CFStringRef labelRef = CFSTR("label");
//    CFDictionarySetValue(queryDic, kSecAttrLabel, labelRef); //标签，用户可以看到
    CFStringRef accountRef = CFSTR("zhoupengzu_basic 2");
    CFDictionarySetValue(queryDic, kSecAttrAccount, accountRef);  //账户
    //查找的参数
    CFDictionarySetValue(queryDic, kSecMatchLimit, kSecMatchLimitOne);  //可以控制当key=kSecReturnAttributes时返回值的个数
    //返回类型
//    CFDictionarySetValue(queryDic, kSecReturnData, kCFBooleanTrue);
    CFDictionarySetValue(queryDic, kSecReturnAttributes, kCFBooleanTrue);
    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching(queryDic, &result);
    if (status == errSecSuccess) {
        NSLog(@"success:%@",result);
        if (CFGetTypeID(result) == CFDictionaryGetTypeID()) { //类型判断
            NSLog(@"label:%@",CFDictionaryGetValue(result, kSecAttrAccessGroup));
        } else if (CFGetTypeID(result) == CFDataGetTypeID()) {
            const UInt8 * str = CFDataGetBytePtr(result);
            NSLog(@"%s",str);
        }
    } else {
        NSLog(@"%@",@(status));
    }
//    if (labelRef) {
//        CFRelease(labelRef);
//    }
//    if (typeRef) {
//        CFRelease(typeRef);
//    }
//    if (creatorRef) {
//        CFRelease(creatorRef);
//    }
//    if (commentStrRef) {
//        CFRelease(commentStrRef);
//    }
//    if (strRef) {
//        CFRelease(strRef);
//    }
    if (queryDic) {
        CFRelease(queryDic);
    }
    return status;
}
//直接删除
- (void)deleteItemDirect {
    //删除CFStringRef accountRef = CFSTR("zhoupengzu_basic 2");
    CFMutableDictionaryRef queryDic = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(queryDic, kSecClass, kSecClassGenericPassword);  //这个不要丢！！！
    CFStringRef accountRef = CFSTR("zhoupengzu_basic 2");
    CFDictionarySetValue(queryDic, kSecAttrAccount, accountRef);
    if (accountRef) {
        CFRelease(accountRef);
    }
    OSStatus delStatus = SecItemDelete(queryDic);
    if (delStatus == errSecSuccess) {
        NSLog(@"delete success");
    } else {
        NSLog(@"%@",@(delStatus));
    }
}
//先查找，再删除 -- 貌似行不通
- (void)deleteItemWithQuery {
    CFMutableDictionaryRef queryDic = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(queryDic, kSecClass, kSecClassGenericPassword);
    CFStringRef accountRef = CFSTR("zhoupengzu_basic 2");
    CFDictionarySetValue(queryDic, kSecAttrAccount, accountRef);
    if (accountRef) {
        CFRelease(accountRef);
    }
    
    CFDictionarySetValue(queryDic, kSecReturnAttributes, kCFBooleanTrue);
    CFDictionarySetValue(queryDic, kSecReturnRef, kCFBooleanTrue);  //这一句话必须要有，否则删除不了
//    CFDictionarySetValue(queryDic, kSecReturnPersistentRef, kCFBooleanTrue);  //不能用这句，这句是做什么用的呢？
    CFTypeRef result = NULL;
    OSStatus queryStatus = SecItemCopyMatching(queryDic, &result);
    if (queryDic) {
        CFRelease(queryDic);
    }
    if (queryStatus != errSecSuccess) {
        NSLog(@"query failed:%@",@(queryStatus));
        return;
    }
    if (CFGetTypeID(result) == CFDictionaryGetTypeID()) {
        OSStatus delStatus = SecItemDelete(result);
        if (delStatus == errSecSuccess) {
            NSLog(@"delete success");
        } else {
            NSLog(@"delete failed:%@",@(delStatus));
        }
    } else if (CFGetTypeID(result) == CFArrayGetTypeID()) {
        CFArrayRef arrRef = result;
        for (CFIndex i = 0; i < CFArrayGetCount(arrRef); i++) {
            OSStatus delStatus = SecItemDelete(CFArrayGetValueAtIndex(arrRef, i));
            if (delStatus == errSecSuccess) {
                NSLog(@"delete success");
            } else {
                NSLog(@"delete failed:%@",@(delStatus));
            }
        }
    }
}
//更新
- (void)updateItem {
    CFMutableDictionaryRef queryDic = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(queryDic, kSecClass, kSecClassGenericPassword);
    CFStringRef accountRef = CFSTR("zhoupengzu_basic 2");
    CFDictionarySetValue(queryDic, kSecAttrAccount, accountRef);
    if (accountRef) {
        CFRelease(accountRef);
    }
    CFMutableDictionaryRef updateDic = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFStringRef strRef = CFSTR("save generic password update");
    CFDictionarySetValue(updateDic, kSecAttrDescription, strRef);  //描述
    OSStatus updateStatus = SecItemUpdate(queryDic, updateDic);
    if (updateStatus == errSecSuccess) {
        NSLog(@"success");
    } else {
        NSLog(@"update Failed:%@",@(updateStatus));
    }
    CFRelease(queryDic);
    CFRelease(updateDic);
}

- (void)updateItemAfterSearch {
    CFMutableDictionaryRef queryDic = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(queryDic, kSecClass, kSecClassGenericPassword);
    CFStringRef accountRef = CFSTR("zhoupengzu_basic 2");
    CFDictionarySetValue(queryDic, kSecAttrAccount, accountRef);
    if (accountRef) {
        CFRelease(accountRef);
    }
    
    CFDictionarySetValue(queryDic, kSecReturnAttributes, kCFBooleanTrue);
    CFDictionarySetValue(queryDic, kSecReturnRef, kCFBooleanTrue);  //这一句话必须要有，否则删除不了
    //    CFDictionarySetValue(queryDic, kSecReturnPersistentRef, kCFBooleanTrue);  //不能用这句，这句是做什么用的呢？
    CFTypeRef result = NULL;
    OSStatus queryStatus = SecItemCopyMatching(queryDic, &result);
    if (queryDic) {
        CFRelease(queryDic);
    }
    if (queryStatus != errSecSuccess) {
        NSLog(@"query failed");
        return;
    }
    if (CFGetTypeID(result) != CFDictionaryGetTypeID()) {
        return;
    }
    CFMutableDictionaryRef updateDic = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFStringRef strRef = CFSTR("save generic password update with query");
    CFDictionarySetValue(updateDic, kSecAttrDescription, strRef);  //描述
    OSStatus updateStatus = SecItemUpdate(result, updateDic);
    if (updateStatus == errSecSuccess) {
        NSLog(@"success");
    } else {
        NSLog(@"update Failed:%@",@(updateStatus));
    }
    CFRelease(updateDic);
}

- (UIButton *)createButtonWithFrame:(CGRect)frame andTitle:(NSString *)title andSEL:(SEL)sel {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
