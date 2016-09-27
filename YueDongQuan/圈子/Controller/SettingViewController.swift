//
//  SettingViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
class SettingViewController: MainViewController,UITableViewDelegate,UITableViewDataSource,YXCustomActionSheetDelegate{
      var settingTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        settingTableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Grouped)
        settingTableView.delegate = self
        settingTableView.dataSource = self
        self.view .addSubview(settingTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 2
        case 3:
            return 1
        case 4:
            return 3
        case 5:
            return 1
        default: break
            
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
            var biVcell = SettingCell?()
             biVcell = tableView.dequeueReusableCellWithIdentifier(cellId) as? SettingCell
            biVcell = SettingCell(style: .Default, reuseIdentifier: cellId)
            biVcell!.headImage.backgroundColor = UIColor.grayColor()
            biVcell!.bigV.backgroundColor = UIColor.blueColor()
            biVcell!.userName.text = "姚明"
            biVcell!.userSex.text = "男"
            biVcell!.userAge.text = "34"
            biVcell!.accessoryType = .DisclosureIndicator
            return biVcell!
            
            
            case 1:
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
                if cell == nil {
                    cell = UITableViewCell(style:.Value1, reuseIdentifier: cellId)
                }
               let array = ["产品切换","大 V 认证","企业认证"]
            cell?.textLabel?.text = array[indexPath.row]
               if indexPath.row == 0 {
                cell?.detailTextLabel?.text = "热动篮球"
               }else if indexPath.row == 1{
                cell?.detailTextLabel?.text = "已认证"
               }else{
                cell?.detailTextLabel?.text = "未认证"
                }
            return cell!
            case 2:
                let array = ["短信通知","修改密码"]
                cell?.textLabel?.text = array[indexPath.row]
                if indexPath.row == 0 {
                    let swich = UISwitch(frame: CGRectZero)
                    cell?.accessoryView = swich
                }
                return cell!
            case 3:
              
                cell?.textLabel?.text = "清理缓存"
                return cell!
            case 4:
                let array = ["帮助与反馈","关于运动圈","推荐给好友"]
                cell?.textLabel?.text = array[indexPath.row]
                return cell!
            case 5:
               
                cell?.textLabel?.text = "退出登录"
                return cell!
        default:
            break
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else{
            return 44
    }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //取消选中的样式
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        print("选中了第几组第几行",indexPath.section,indexPath.row)
        if indexPath.section == 2 {
            if indexPath.row == 1 {
                
                let alertView = MJAlertView(title: nil, message: nil, cancelButtonTitle: "验证旧密码", sureButtonTitle: "验证手机")
                alertView.show()
                //获取点击事件
                alertView.clickIndexClosure { (index) in
                    print(index)
                    if index == 1{
                        alertView.removeFromSuperview()
                        let textFeild = ConfirmOldPw(title: "修改密码", message: "请填写原密码", cancelButtonTitle: "取消", sureButtonTitle: "确定")
                        textFeild.show()
                        textFeild.clickIndexClosure({ (index) in
                            if index == 2{
                                let setNewPs = SetNewPasswordViewController()
                                self.navigationController?.pushViewController(setNewPs, animated: true)
                            }
                        })
                    }else{
                        let send = SendPhoneViewController()
                        self.navigationController?.pushViewController(send, animated: true)
                    }
                }

            }
        }
        if indexPath.section == 0 {
            let subPerson = SubPersonDataViewController()
            self.navigationController?.pushViewController(subPerson, animated: true)
        }
        if indexPath.section == 4 {
            if indexPath.row == 2 {
                let customSheet = YXCustomActionSheet()
                let contentArray = [["name": "新浪微博", "icon": "sns_icon_3"], ["name": "QQ空间 ", "icon": "sns_icon_5"], ["name": "QQ ", "icon": "sns_icon_4"], ["name": "微信", "icon": "sns_icon_7"], ["name": "朋友圈", "icon": "sns_icon_8"], ["name": "新浪微博", "icon": "sns_icon_3"], ["name": "QQ空间 ", "icon": "sns_icon_5"], ["name": "微信收藏", "icon": "sns_icon_9"]]
                customSheet.backgroundColor = UIColor.whiteColor()
                customSheet.delegate = self
                customSheet.showInView(UIApplication.sharedApplication().keyWindow, contentArray: contentArray)
            }
        }
        
        
    }
    //MARK: YXCustomActionSheetDelegate
    func customActionSheetButtonClick(btn: YXActionSheetButton!) {
        print("点击了",btn.tag)
    }
}
