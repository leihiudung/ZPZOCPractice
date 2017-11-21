//
//  ZPZContactGetInfo.swift
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/21.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

import UIKit
import Contacts

@available(iOS 9.0,*)
class ZPZContactGetInfo: NSObject {
    static func printContactInfo(baseInfo: CNContact){
        print("identifier:\(baseInfo.identifier)")
        print("namePrefix:\(baseInfo.namePrefix)")
        print("givenName:\(baseInfo.givenName)")
        let phoneNumbers = baseInfo.phoneNumbers
        for i in 0 ..< phoneNumbers.count{
            let phoneValue: CNLabeledValue = phoneNumbers[i]
            let phoneNum: CNPhoneNumber = phoneValue.value
            print("label:\(phoneValue.label ?? "无"),phone:\(phoneNum.stringValue)")
        }
    }
}
