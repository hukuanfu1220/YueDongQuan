//
//  MJOtherQuanZiView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJOtherQuanZiView: UIView,UITableViewDelegate,UITableViewDataSource {
lazy var  whiteView = UIView()
    lazy var label = UILabel()
    lazy var tableView = UITableView(frame: CGRectZero, style: .Plain)
    override init(frame: CGRect) {
        super.init(frame: frame)
        whiteView.frame = CGRectMake(0, ScreenHeight, ScreenWidth ,ScreenHeight/3 )
        self .addSubview(whiteView)
        
        whiteView .addSubview(label)
        label.snp_makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.height.equalTo(15)
            
        }
        label.text = "附近活跃圈子"
        label.textColor = UIColor.grayColor()
        whiteView .addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(label.snp_bottom).offset(5)
            make.bottom.equalTo(0)
            
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.darkGrayColor()
        
        UIView.animateWithDuration(1, delay: 0, options: .LayoutSubviews, animations: {
            self.whiteView.frame = CGRectMake(0, ScreenHeight/3*2, ScreenWidth ,ScreenHeight/3 )
            }, completion: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil{
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        }
        
        cell!.imageView?.image = UIImage(named: "img_message_2x")
        cell!.textLabel?.text = "亚太跆拳道"
        cell!.detailTextLabel?.text = "156 人正在热论"
        let btn = UIButton(type: .Custom)
        btn.frame = CGRectMake(0, 0,50, 20)
        btn.setTitle("加入", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = UIColor(red: 0, green: 125 / 255, blue: 255 / 255, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        cell!.accessoryView = btn
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
}
