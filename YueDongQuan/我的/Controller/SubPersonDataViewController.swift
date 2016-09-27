//
//  SubPersonDataViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class SubPersonDataViewController: MainViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       self.tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view .addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: tableViewDelege tableViewDatasurce

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            break
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        cell?.accessoryType = .DisclosureIndicator
        
        switch indexPath.section {
        case 0:
            var biVcell = SubPersonCell?()
            biVcell = tableView.dequeueReusableCellWithIdentifier(cellId) as? SubPersonCell
            biVcell = SubPersonCell(style: .Default, reuseIdentifier: cellId)
            biVcell!.accessoryType = .DisclosureIndicator
            biVcell?.textLabel?.text = "个人头像"
            biVcell?.headImage.backgroundColor = UIColor.greenColor()
//            headImage.layer.cornerRadius = (biVcell?.accessoryView?.bounds.size.width)!/2
//            headImage.layer.masksToBounds = true
           
            return biVcell!
        case 1:
            let array = ["姓名","性别","年龄"]
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellId)
            cell?.textLabel?.text = array[indexPath.row]
            cell?.detailTextLabel?.text = array[indexPath.row]
            cell?.accessoryType = .DisclosureIndicator
            return cell!
        default:
            break
        }
        
        
     return cell!
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        }else{
            return 44
        }
   
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        
        if  indexPath.section == 0 {
            let mjAlertView =  MJAlertView(title: nil, message: nil, cancelButtonTitle: "拍照", sureButtonTitle: "手机选择")
            mjAlertView.show()
        }
        if indexPath.section == 1 {
            let changeName = ChangeNameViewController()
            if indexPath.row == 0 {
                 self.navigationController?.pushViewController(changeName, animated: true)
            }
            if indexPath.row == 1 {
                let sexSelect = MJAlertView(title: nil, message: nil, cancelButtonTitle: "男", sureButtonTitle: "女")
                sexSelect.show()
                sexSelect.clickIndexClosure({ (index) in
                    //选择男女
                })
            }
            if indexPath.row == 2 {
                let datePiker = MJDatePikerView(title: "出生日期", cancelButtonTitle: "取消", sureButtonTitle: "确定")
                datePiker.show()
            }
         
        }
        
    }
}
