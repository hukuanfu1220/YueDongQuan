//
//  MyQuanZiViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MyQuanZiViewController: MainViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      self.creatTableView()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false

    }
    func creatTableView()  {
        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view .addSubview(tableView)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新建圈子", style: .Plain, target: self, action: #selector(creatNewQuanZi))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "←｜我的圈子", style: .Plain, target: self, action:  #selector(pop))

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK:新建圈子
    func creatNewQuanZi()  {
        let new = NewQuanZiViewController()
        self.push(new)
    }
 //MARK:表格数据源代理
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
//            return (dataSources["myQuanZi"]?.count)!
            return 1
        }
        else{
//            return (dataSources["myJionQuanZi"]?.count)!
            return 2
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        if indexPath.section == 0 {
//           var cell = tableView.dequeueReusableCellWithIdentifier("cell")!
             let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
            cell.imageView?.image = UIImage(named: "img_message_2x")
            cell.textLabel?.text = "奥体中心"
            cell.detailTextLabel?.text = "128"
            cell.detailTextLabel?.textColor = UIColor.grayColor()
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
            return cell
        }
        else{
//            var cell = tableView.dequeueReusableCellWithIdentifier("cell")!
           let  cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
            cell.imageView?.image = UIImage(named: "img_message_2x")
            cell.textLabel?.text = "奥体中心"
            cell.detailTextLabel?.text = "128"
            cell.detailTextLabel?.textColor = UIColor.grayColor()
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
            return cell
        }
//        return cell
    }
     //MARK：表格代理
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ScreenHeight/15
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headLabel = UILabel(frame: CGRectMake(20, 0, ScreenWidth-20, ScreenHeight/15))
            headLabel.text = "我管理的圈子"
            headLabel.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
            headLabel.textColor = UIColor.grayColor()
            return headLabel
        }
        else{
            let headLabel = UILabel(frame: CGRectMake(20, 0, ScreenWidth-20, ScreenHeight/15))
            headLabel.text = "我加入的圈子"
            headLabel.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
            headLabel.textColor = UIColor.grayColor()
            return headLabel
        }
    }
    //选中某个圈子发起聊天
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //融云聊天
            let chatVC = MJConversationViewController()
                chatVC.targetId = "1003"
                chatVC.userName = "热动"
                chatVC.title = "热动"
                chatVC.conversationType = .ConversationType_GROUP
                push(chatVC)
            }
        }
    }
    //MARK:数据来源
    lazy var dataSources:NSMutableDictionary = {
       var dataSources = NSMutableDictionary()
        
        let myCircleModel = CircleModel()
        myCircleModel.uid = NSUserDefaults.standardUserDefaults().objectForKey("uid")as! String
        let dic = ["VALIDATION_CODE":myCircleModel.VALIDATION_CODE,
                   "uid":myCircleModel.uid]
        MJNetWorkHelper().mycircle(mycircle, mycircleModel: dic, success: { (responseDic, success) in
            
            }, fail: { (error) in
                
        })
        
        return dataSources
    }()

}
