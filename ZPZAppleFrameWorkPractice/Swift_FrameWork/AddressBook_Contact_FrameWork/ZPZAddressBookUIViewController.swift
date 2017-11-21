//
//  ZPZAddressBookUIViewController.swift
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/19.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

import UIKit
import AddressBookUI
import ContactsUI

class ZPZAddressBookUIViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate, CNContactPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        view.backgroundColor = UIColor.white
        configUI()
    }
    
    func configUI(){
        let button: UIButton = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.orange
        button.frame = CGRect(x: 20, y: 20, width: view.frame.size.width - 2 * 20, height: 50)
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.masksToBounds = true
        button.setTitle("打开系统通讯录", for: .normal)
        button.addTarget(self, action: #selector(gotoOpenSystemAddressBook), for: .touchUpInside)
        view .addSubview(button)
    }
    
    @objc func gotoOpenSystemAddressBook(){
        print("open")
        if #available(iOS 9.0, *){
            let status = CNContactStore.authorizationStatus(for: .contacts)
            switch status{
            case .notDetermined:
                let contactStore = CNContactStore()
                contactStore.requestAccess(for: .contacts, completionHandler: { (isAllow, error) in
                    DispatchQueue.main.async {
                        if isAllow {
                            self.gotoAddressBook()
                        }else{
                            self.showHaveNoPermissionTip()
                        }
                    }
                })
            case .restricted:
                fallthrough
            case .denied:
                self.showHaveNoPermissionTip()
            case .authorized:
                gotoAddressBook()
            }
        }else{
            let status = ABAddressBookGetAuthorizationStatus()
            switch status {
            case .notDetermined:
                let addressBook = ABAddressBookCreate() as ABAddressBook
                ABAddressBookRequestAccessWithCompletion(addressBook, { (isAllow, error) in
                    DispatchQueue.main.async {
                        if isAllow {
                            self.gotoAddressBook()
                        }else{
                            self.showHaveNoPermissionTip()
                        }
                    }
                })
            case .authorized:
                gotoAddressBook()
            case .denied,.restricted:
                showHaveNoPermissionTip()
            }
        }
    }
    func gotoAddressBook(){
        if #available(iOS 9.0, *){
            let contactVC: CNContactPickerViewController = CNContactPickerViewController()
            contactVC.delegate = self
            contactVC.predicateForSelectionOfProperty = NSPredicate.init(format: "key=%@", argumentArray: ["emailAddresses"])
            self.present(contactVC, animated: true, completion: nil)
        }else{
            let peoplePickerVC: ABPeoplePickerNavigationController = ABPeoplePickerNavigationController()
            peoplePickerVC.peoplePickerDelegate = self
            self.present(peoplePickerVC, animated: true, completion: nil)
        }
    }
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
    //MARK: CNContactPickerDelegate
    @available(iOS 9.0, *)
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
    //MARK: 以下两个方法是单选和多选的回调，实现那个，就触发哪个，都会受predicateForSelectionOfContact的影响，如果不设置该值，则可以随心选
//    @available(iOS 9.0, *)
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
//        print(contacts)
//    }
    @available(iOS 9.0, *)
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        ZPZContactGetInfo.printContactInfo(baseInfo: contact)
    }
    //MARK: 以下两个方法是属性单选和多选的回调，实现那个，就触发哪个
    //赋值了predicateForSelectionOfProperty属性值，则只能点击符合的属性才会触发这个回调
//    @available(iOS 9.0,*)
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        print(contactProperty)
//    }
    //需要配合predicateForSelectionOfProperty属性使用，负责返回为空
//    @available(iOS 9.0, *)
//    func contactPicker(_ picker: CNContactPickerViewController, didSelectContactProperties contactProperties: [CNContactProperty]) {
//        print(contactProperties)
//    }
    
//MARK: ABPeoplePickerNavigationControllerDelegate
    func peoplePickerNavigationControllerDidCancel(_ peoplePicker: ABPeoplePickerNavigationController) {
        peoplePicker.dismiss(animated: true, completion: nil)
    }
    //下面的这两个代理回调，第一个优先级高于第二个，且只有在实现了这两个方法中的某一个后，才有选中回调
    //这个是在选中了某个联系人的时候就会触发回调
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        ZPZAddressBookGetInfo.printAddressBookInfo(baseInfo: person)
    }
    //这个是在选中了某个联系人的某个选项（如手机号）的时候就会触发回调
//    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
//        print(person)
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
