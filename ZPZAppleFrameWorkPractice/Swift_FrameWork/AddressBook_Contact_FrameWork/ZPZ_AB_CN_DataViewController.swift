//
//  ZPZ_AB_CN_DataViewController.swift
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/21.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

import UIKit
import Contacts
import AddressBook

class ZPZ_AB_CN_DataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.view.backgroundColor = UIColor.white
        configUI()
    }
    func configUI(){
        let button: UIButton = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.orange
        button.frame = CGRect(x: 20, y: 20, width: view.frame.size.width - 2 * 20, height: 50)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.masksToBounds = true
        button.setTitle("开始获取", for: .normal)
        button.addTarget(self, action: #selector(gotoOpenSystemAddressBook), for: .touchUpInside)
        view .addSubview(button)
    }
    
    @objc func gotoOpenSystemAddressBook(){
//        if #available(iOS 9.0, *) {
//            let status = CNContactStore.authorizationStatus(for: .contacts)
//            switch status{
//            case .notDetermined:
//                let contactStore = CNContactStore()
//                contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (isAllow, error) in
//                    DispatchQueue.main.async {
//                        if isAllow{
//                            self.gotoReadData()
//                        }else{
//                            self.showHaveNoPermissionTip()
//                        }
//                    }
//                })
//            case .denied:
//                fallthrough
//            case .restricted:
//                showHaveNoPermissionTip()
//            case .authorized:
//                gotoReadData()
//            }
//        }else{
            let status = ABAddressBookGetAuthorizationStatus()
            switch status{
            case .notDetermined:
                let addressBook = ABAddressBookCreate().takeRetainedValue()
                ABAddressBookRequestAccessWithCompletion(addressBook, { (isAllow, error) in
                    DispatchQueue.main.async {
                        if isAllow{
                            self.gotoReadData()
                        }else{
                            self.showHaveNoPermissionTip()
                        }
                    }
                })
            case .denied,.restricted:
                showHaveNoPermissionTip()
            case .authorized:
                gotoReadData()
            }
//        }
    }
    
    func gotoReadData(){
        if #available(iOS 9.0, *){
            let contactRequest = CNContactFetchRequest.init(keysToFetch: [CNContactPhoneNumbersKey,CNContactNamePrefixKey,CNContactGivenNameKey] as [CNKeyDescriptor])
            let contactStore = CNContactStore.init()

            do{
                try contactStore.enumerateContacts(with: contactRequest, usingBlock: { (contact, stop) in
                    ZPZContactGetInfo.printContactInfo(baseInfo: contact)
                })
            }catch let error as NSError{
                print(error)
            }
        }else{
            let addressBook = ABAddressBookCreate().takeRetainedValue()
            let allPeople:NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray
            for i in 0..<allPeople.count{
                let person = allPeople[i]
                ZPZAddressBookGetInfo.printAddressBookInfo(baseInfo: person as ABRecord)
            }
            //下面这么写有问题？？？？？
//            let addressBook = ABAddressBookCreate().takeRetainedValue()
//            let allPeople:CFArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
//            for i in 0..<CFArrayGetCount(allPeople){
//                let person = CFArrayGetValueAtIndex(allPeople, i)
//                ZPZAddressBookGetInfo.printAddressBookInfo(baseInfo: person as ABRecord)
//            }
        }
    }
    /**
     CFArrayRef peopleArr = ABAddressBookCopyArrayOfAllPeople(ABAddressBookCreate());
     NSLog(@"%@",peopleArr);
     for (NSInteger i = 0; i < CFArrayGetCount(peopleArr); i++) {
     NSLog(@"%@",ABRecordCopyValue(CFArrayGetValueAtIndex(peopleArr, i), kABPersonFirstNameProperty));
     }
     */
    func showHaveNoPermissionTip(){
        let alertVC = UIAlertController.init(title: "提示", message: "您已经拒绝了我们访问您的通讯录，您可以自己去设置里面打开", preferredStyle: .alert)
        let knowAction = UIAlertAction.init(title: "知道了", style: .cancel, handler: nil)
        let openUrl = URL.init(string: UIApplicationOpenSettingsURLString)
        if let tempOpenUrl = openUrl{
            let canOpenSetting = UIApplication.shared.canOpenURL(tempOpenUrl)
            if canOpenSetting {
                let goAction = UIAlertAction.init(title: "去设置", style: .default, handler: { (go) in
                    UIApplication.shared.openURL(tempOpenUrl)
                })
                alertVC.addAction(goAction)
            }
        }
        alertVC.addAction(knowAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
