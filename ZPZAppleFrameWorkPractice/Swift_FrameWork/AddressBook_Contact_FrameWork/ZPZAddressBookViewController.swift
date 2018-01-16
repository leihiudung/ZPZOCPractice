//
//  ZPZAddressBookViewController.swift
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/19.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

import UIKit

private enum ContactsEntryType: String{
    case ADDRESS_BOOK_CONTACTS_UI = "AddressBook和Contacts--联系人UI"
    case ADDRESS_BOOK_CONTACTS_DATA = "AddressBook和Contacts--联系人数据"
}

class ZPZAddressBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private let listType = "type"
    var tableView: UITableView?
    var dataSource: [[String:Any]]{
        get {
            return [
                [listType:ContactsEntryType.ADDRESS_BOOK_CONTACTS_UI],
                [listType:ContactsEntryType.ADDRESS_BOOK_CONTACTS_DATA]
            ];
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        configTableView()
    }

    func configTableView(){
        guard tableView == nil else {
            return
        }
        tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), style: UITableViewStyle.plain)
        tableView?.backgroundColor = UIColor.white
        tableView?.estimatedRowHeight = 0
        tableView?.estimatedSectionFooterHeight = 0
        tableView?.estimatedSectionHeaderHeight = 0
        tableView?.tableFooterView = UIView()
        tableView?.delegate = self
        tableView?.dataSource = self
        view .addSubview(tableView!)
    }
    
    //MARK: UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flag = "contact"
        var cell = tableView.dequeueReusableCell(withIdentifier: flag)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: flag)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
        if indexPath.row >= dataSource.count {
            return cell!
        }
        let type: ContactsEntryType = dataSource[indexPath.row][listType] as! ContactsEntryType
        cell?.textLabel?.text = type.rawValue
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= dataSource.count {
            return
        }
        let type: ContactsEntryType = dataSource[indexPath.row][listType] as! ContactsEntryType
        switch type {
        case .ADDRESS_BOOK_CONTACTS_UI:
            print("\(type.rawValue)")
            let addressBookUIVC: ZPZAddressBookUIViewController = ZPZAddressBookUIViewController()
            navigationController?.pushViewController(addressBookUIVC, animated: true)
        case .ADDRESS_BOOK_CONTACTS_DATA:
            let dataVC = ZPZ_AB_CN_DataViewController()
            navigationController?.pushViewController(dataVC, animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
