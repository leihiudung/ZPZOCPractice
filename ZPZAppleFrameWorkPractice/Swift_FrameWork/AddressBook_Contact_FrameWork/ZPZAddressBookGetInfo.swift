//
//  ZPZAddressBookGetInfo.swift
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/19.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

import UIKit
import AddressBook

class ZPZAddressBookGetInfo: NSObject {
    static func printAddressBookInfo(baseInfo: ABRecord){
        let recordID = ABRecordGetRecordID(baseInfo)
        let recordType = ABRecordGetRecordType(baseInfo)
        
        let firstName = ABRecordCopyValue(baseInfo, kABPersonFirstNameProperty).takeRetainedValue()  //名
        let lastName = ABRecordCopyValue(baseInfo, kABPersonLastNameProperty).takeRetainedValue()  //姓
        let middleName = ABRecordCopyValue(baseInfo, kABPersonMiddleNameProperty).takeRetainedValue()
        let preFix = ABRecordCopyValue(baseInfo, kABPersonPrefixProperty).takeRetainedValue()  //联系人前缀
        let suffFix = ABRecordCopyValue(baseInfo, kABPersonSuffixProperty).takeRetainedValue() //联系人称谓后缀
        let nickName = ABRecordCopyValue(baseInfo, kABPersonNicknameProperty).takeRetainedValue() //联系人昵称
        let firstNamePhone = ABRecordCopyValue(baseInfo, kABPersonFirstNamePhoneticProperty).takeRetainedValue() //名的拼音或者音标
        let lastNamePhoetic = ABRecordCopyValue(baseInfo, kABPersonLastNamePhoneticProperty).takeRetainedValue() //姓的拼音或者音标
        let middleNamePhonetic = ABRecordCopyValue(baseInfo, kABPersonMiddleNamePhoneticProperty).takeRetainedValue() //中间字的拼音或者音标
        let organizeName = ABRecordCopyValue(baseInfo, kABPersonOrganizationProperty).takeRetainedValue()  //公司
        let departmentName = ABRecordCopyValue(baseInfo, kABPersonDepartmentProperty).takeRetainedValue()  //部门
        let jobTitle = ABRecordCopyValue(baseInfo, kABPersonJobTitleProperty).takeRetainedValue()  //工作、职位
        print("recordID:\(recordID)\nrecordType:\(recordType)\nfirstName:\(firstName)\nlastName:\(lastName)\nmiddleName:\(middleName)\npreFix:\(preFix)\nsuffFix:\(suffFix)\nnickName:\(nickName)\nfirstNamePhonetic:\(firstNamePhone)\nlastNamePhonetic:\(lastNamePhoetic)\nmiddleNamePhonetic:\(middleNamePhonetic)\norganizeName:\(organizeName)\ndepartmentName:\(departmentName)\njobTitle:\(jobTitle)")
        
        print("邮件：")
        let emailValueArray: ABMultiValue = ABRecordCopyValue(baseInfo, kABPersonEmailProperty).takeRetainedValue() //电邮
        let emilCount: CFIndex = ABMultiValueGetCount(emailValueArray)
        for i in 0..<emilCount{
            print(ABMultiValueCopyValueAtIndex(emailValueArray, i).takeRetainedValue())
        }
        print("公历生日：")
        let birthdayArr = ABRecordCopyValue(baseInfo, kABPersonBirthdayProperty)  //这个方法只能读取到公历生日，读取不到农历生日
        if let _ = birthdayArr {
            print(birthdayArr!.takeRetainedValue())
        }
        print("农历生日：")
        let birthdayArr2 = ABRecordCopyValue(baseInfo, kABPersonAlternateBirthdayProperty)
        if let _ = birthdayArr2{
            let tempBirth: NSDictionary = birthdayArr2!.takeRetainedValue() as! NSDictionary
//            let count = tempBirth.count
            print(tempBirth.value(forKey: kABPersonAlternateBirthdayYearKey as String) ?? "无")
        }
        print("备注：")
        let note = ABRecordCopyValue(baseInfo, kABPersonNoteProperty).takeRetainedValue()
        print(note)
        print("住址：")
        let addressValue = ABRecordCopyValue(baseInfo, kABPersonAddressProperty)
        if let address = addressValue {
            let addressMul: ABMultiValue = address.takeRetainedValue()
            for i in 0..<ABMultiValueGetCount(addressMul){
                let addressInfoDic = ABMultiValueCopyValueAtIndex(addressMul, i).takeRetainedValue() as! NSDictionary
                let street = addressInfoDic.object(forKey: kABPersonAddressStreetKey as String) ?? "无"
                let city = addressInfoDic.object(forKey: kABPersonAddressCityKey as String) ?? "无"
                let state = addressInfoDic.value(forKey: kABPersonAddressStateKey as String) ?? "无"
                let postCode = addressInfoDic.value(forKey: kABPersonAddressZIPKey as String) ?? "无"
                let country = addressInfoDic.value(forKey: kABPersonAddressCountryKey as String) ?? "无"
                let countryCode = addressInfoDic.value(forKey: kABPersonAddressCountryCodeKey as String) ?? "无"
                print("street:\(street),city:\(city),state:\(state),postCode:\(postCode),country:\(country),countryCode:\(countryCode)")
            }
        }
        print("日期：")
        let dateValue = ABRecordCopyValue(baseInfo, kABPersonDateProperty)
        if let date = dateValue{
            let dateMul: ABMultiValue = date.takeRetainedValue()
            for i in stride(from: 0, to: ABMultiValueGetCount(dateMul), by: 1){
                let tempDate = ABMultiValueCopyValueAtIndex(dateMul, i).takeRetainedValue() as! Date
                let tempDateCom = NSCalendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: tempDate)
                let label = ABMultiValueCopyLabelAtIndex(dateMul, i).takeRetainedValue()
                if label == kABPersonAnniversaryLabel{
                    print("label:Anniversary,year:\(tempDateCom.year ?? 0),month:\(tempDateCom.month ?? 0),day:\(tempDateCom.day ?? 0)")
                }else{
                    print("label:Others,year:\(tempDateCom.year ?? 0),month:\(tempDateCom.month ?? 0),day:\(tempDateCom.day ?? 0)")
                }
                
            }
        }
        print("Kind:")
        let kindValue = ABRecordCopyValue(baseInfo, kABPersonKindProperty)
        if let kind = kindValue {
            let kindVal = kind.takeRetainedValue() as! CFNumber
            if CFNumberCompare(kindVal, kABPersonKindOrganization, nil) == .compareEqualTo{
                print("organization")
            }else{
                print("others")
            }
        }
        print("电话：")
        let phoneValue = ABRecordCopyValue(baseInfo, kABPersonPhoneProperty)
        if let phone = phoneValue{
            let phoneVal: ABMultiValue = phone.takeRetainedValue()
            for i in 0..<ABMultiValueGetCount(phoneVal){
                let tempPhone = ABMultiValueCopyValueAtIndex(phoneVal, i).takeRetainedValue()
                let tempPhoneLabel = ABMultiValueCopyLabelAtIndex(phoneVal, i).takeRetainedValue()
                print("label:\(tempPhoneLabel),phone:\(tempPhone)")
            }
        }
    }
}
