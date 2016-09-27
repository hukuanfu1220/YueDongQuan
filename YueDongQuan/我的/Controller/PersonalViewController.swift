//
//  PersonalViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit

class PersonalViewController: MainViewController,UITableViewDelegate,UITableViewDataSource {

    var headerBgView = UIView()
    lazy var userHeadView = UIImageView()
    lazy var renZhengView = UIImageView()
    var isSelected = Bool()
    var needRefresh = Bool()
    var MainBgTableView = UITableView()
    
    override func loadView() {
        super.loadView()
        self.needRefresh = true;
        
        self.navigationItem.title = "朋友圈";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "我的"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self .creatViewWithSnapKit()
        self.creatViewWithSnapKit("ic_lanqiu", secondBtnImageString: "ic_search", thirdBtnImageString: "ic_shezhi")
    }
    
    override func viewWillAppear(animated: Bool) {
//        self.downloadData()
        MainBgTableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    /*搭建界面*/
    
    func creatViewWithSnapKit()  {
        self.clickButtonTagClosure { (ButtonTag) in
            if ButtonTag == 3{
                let set = SettingViewController ()
                self.push(set)
            }
          
        }
        // 头部视图
        
        MainBgTableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Grouped)
        MainBgTableView.delegate = self
        MainBgTableView.dataSource = self
//        MainBgTableView.backgroundColor = UIColor.brownColor()
        self.view .addSubview(MainBgTableView)

    }
   /*
    lazy var dataSource:NSMutableArray = {
        var dataSource = NSMutableArray()
        dataSource = NSMutableArray()
        return dataSource
    }()
    
    lazy var dateFormatter:NSDateFormatter = {
    var dateFormatter = NSDateFormatter()
    dateFormatter = NSDateFormatter()
    dateFormatter.dateFromString("MM月dd日 hh:mm")
        
        return dateFormatter
    }()
    lazy var postComment:CommentModel = {
       var postComment = CommentModel()
        postComment = CommentModel()
        return postComment
    }()
    */
    /* 点击左上角按钮 */
    func ClickLeftButton() {
       
    }
    
    func clickTheFourButton(buttonTag:UIButton) {
        
       
   
    }
    //下载数据
   /* func downloadData()  {
      
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            if(self.needRefresh){
                self.dataSource.removeAllObjects()
                var fakes = NSMutableArray()
                fakes = NSMutableArray()
                for index in 0...11{
                    
                 fakes.addObjectsFromArray(self.fakeDatasource as [AnyObject])
                    
                }
                for index in 0...fakes.count-1{
                    let statusModel:StatusModel = StatusModel.modelWithJSON(fakes[index]) as! StatusModel
                    let layout = self.layoutWithStatusModel(statusModel, index: index)
                    self.dataSource .addObject(layout)
                   
                }
                print(self.dataSource)
            }
            
            dispatch_async(dispatch_get_main_queue(), { 
             //上啦下啦刷新
            })
        }
    }

    */
  /*  func layoutWithStatusModel(statusModel:StatusModel, index:NSInteger) -> CellLayout {
        let layout = CellLayout(statusModel: statusModel, index: index, dateFormatter: self.dateFormatter)
        return layout
    }*/
    //1.1默认返回一组
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3;
        
    }
    
    
    
    // 1.2 返回行数
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            
            return 0;
            
        }else if (section == 1){
            
            return 1;
            
        }else{
//            return self.dataSource.count
        }
        return 0
    }
    
    
    
    //1.3 返回行高
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        
        
        if(indexPath.section == 0){
            
            return 1;
            
        }else if (indexPath.section == 1){
            
            return 55;
  
        }else{
           /* if (self.dataSource.count >= indexPath.row) {
                let cellLayout = self.dataSource[indexPath.row]
            
              return cellLayout.height*/
//            }

        }
       return 0
    }
    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        if (section == 0) {
        let bgView = HeaderView()
            
            view.backgroundColor = UIColor.redColor()
            
        return bgView

        }else{
            return view
        }
        
    }
    
    //1.4每组的头部高度
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section == 0) {
            return  ScreenHeight/3
        }else if (section == 1){
            return 5
        }else{
            return 10
        }
        
    }
    
    
    
    //1.5每组的底部高度
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 3;
        
    }
    
    //1.6 返回数据源
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier="identtifier";
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        if(indexPath.section == 0){
            
            
        }else if (indexPath.section == 1){
            var cell = MyDongdouTableViewCell?()
            
            cell=tableView.dequeueReusableCellWithIdentifier(identifier) as? MyDongdouTableViewCell
            if (cell == nil) {
                cell = MyDongdouTableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier);
            }
            
            cell!.imageView?.image = UIImage(named: "ic_shezhi")
            cell?.backgroundColor = UIColor.greenColor()
            cell!.textLabel?.text = "我的动豆"
            cell!.textLabel?.textColor = UIColor(red: 244 / 255,
                                                green: 158 / 255,
                                                blue: 23 / 255,
                                                alpha: 1)
            cell!.accessoryType = .DisclosureIndicator
            cell!.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator;
            return cell!
        }else if(indexPath.section == 2){
           
        }
        
        
        return cell!
        
        
    }
    
    //1.7 表格点击事件
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //取消选中的样式
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);

        print("选中了第几组",indexPath.section)
        if indexPath.section ==  1{
        let dongdou = MyDongDouViewController()
            self.navigationController?.pushViewController(dongdou, animated: true)
        }
        

    }


    
    //假数据
 /*   lazy var fakeDatasource:NSArray = {
       
        var fakeDatasource = NSArray()
        fakeDatasource = [  [ "type": "image",
             "name": "型格志style",
             "avatarUrl": "http://tp4.sinaimg.cn/5747171147/50/5741401933/0",
             "content": "春天卫衣的正确打开方式~\n\n\n\n哈哈哈哈,oops~",
             "date": "1459668442",
             "imgs": [ "http://ww2.sinaimg.cn/mw690/006gWxKPgw1f2jeloxwhnj30fu0g0ta5.jpg",
             "http://ww3.sinaimg.cn/mw690/006gWxKPgw1f2jelpn9bdj30b40gkgmh.jpg",
             "http://ww1.sinaimg.cn/mw690/006gWxKPgw1f2jelriw1bj30fz0g175g.jpg",
             "http://ww3.sinaimg.cn/mw690/006gWxKPgw1f2jelt1kh5j30b10gmt9o.jpg",
             "http://ww4.sinaimg.cn/mw690/006gWxKPgw1f2jeluxjcrj30fw0fz0tx.jpg",
             "http://ww3.sinaimg.cn/mw690/006gWxKPgw1f2jelzxngwj30b20godgn.jpg",
             "http://ww2.sinaimg.cn/mw690/006gWxKPgw1f2jelwmsoej30fx0fywfq.jpg",
             "http://ww4.sinaimg.cn/mw690/006gWxKPgw1f2jem32ccrj30xm0sdwjt.jpg",
             "http://ww4.sinaimg.cn/mw690/006gWxKPgw1f2jelyhutwj30fz0fxwfr.jpg",],
             "statusID": "8",
             "commentList": [[ "from": "SIZE潮流生活",
             "to": "waynezxcv",
             "content": "nice~使用Gallop。支持异步绘制，让滚动如丝般顺滑。"]],
             "isLike": (false),
             "likeList": [ "waynezxcv"]],]

        return fakeDatasource
    }()
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}






