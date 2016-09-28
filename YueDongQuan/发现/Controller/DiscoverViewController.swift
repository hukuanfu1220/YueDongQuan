//
//  DiscoverViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SwiftyJSON

class DiscoverViewController: UIViewController {
    let titleArray = ["最新", "附近", "关注", "招募", "求加入", "图片", "视频", "Eight"]
    var segementControl : HMSegmentedControl!
    //底部容器(用于装tableview)
    private var scrollContentView = UIScrollView()
    private var tableViews = [UITableView]()
    
    var dataArray = [CellModel]()
    
    

    
    
    override func viewWillAppear(animated: Bool) {
        getdata()
    }
 

    override func viewDidLoad() {
        super.viewDidLoad()
//        getdata()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_lanqiu"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 24.0 / 255, green: 90.0 / 255, blue: 172.0 / 255, alpha: 1.0)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 32))
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        searchBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(searchBtn)
        let addBtn = UIButton(frame: CGRect(x: 33, y: 0, width: 32, height: 32))
        addBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(addBtn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
        
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        segementControl = HMSegmentedControl(sectionTitles: titleArray )
        segementControl.autoresizingMask = [.FlexibleRightMargin, .FlexibleWidth]
        segementControl.frame = CGRect(x: 0, y: 60, width: ScreenWidth, height: 40)
        segementControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        segementControl.selectionStyle = .FullWidthStripe
        segementControl.selectionIndicatorLocation = .Down
        segementControl.verticalDividerEnabled = true
        segementControl.verticalDividerWidth = 1
        segementControl.verticalDividerColor = UIColor.whiteColor()
        segementControl.selectedSegmentIndex = 0
        
        segementControl.indexChangeBlock = { (index) in
            NSLog("index == \(index)")
            
        }
        segementControl.addTarget(self, action: #selector(DiscoverViewController.segmentedControlChangedValue(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segementControl)
        
        setScrollContentView()
       // self.view.addSubview(commentView)
        downLoadData()
    }
    
    func downLoadData(){
        let strPath : String = NSBundle.mainBundle().pathForResource("dataTest", ofType: "geojson")!
        let parseJason = try! String(contentsOfFile: strPath, encoding: NSUTF8StringEncoding)
        NSLog("parseJson = \(parseJason)")
        if let dataFromString = parseJason.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            NSLog("dict=\(json)")
        }
        
    }
    
    func setScrollContentView()  {
        self.view.addSubview(scrollContentView)
        
        scrollContentView.showsHorizontalScrollIndicator = true
        scrollContentView.showsVerticalScrollIndicator = false
        scrollContentView.pagingEnabled = true
        scrollContentView.scrollEnabled = false
        scrollContentView.frame = CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104 - 49)
//        scrollContentView.snp_makeConstraints { (make) in
//            make.left.equalTo(0)
//            make.right.equalTo(0)
//            make.top.equalTo(0).offset(106)
//            //make.bottom.equalTo(self.view.snp_bottom).offset(-44)
//            make.bottom.equalTo(self.view.snp_bottom).offset(-49)
//        }
//        let startY = segementControl.frame.maxY + 2
//        let endY = self.scrollContentView.frame.maxY
        NSLog("frame = \(scrollContentView.frame)")
        
        scrollContentView.contentSize = CGSize(width: ScreenWidth*CGFloat(titleArray.count), height: scrollContentView.frame.height )
        scrollContentView.delegate = self
        scrollContentView.backgroundColor = UIColor.redColor()
        
        
        for i in 0..<titleArray.count {
            let testTable = UITableView(frame: CGRect(x: 0 + ScreenWidth*CGFloat(i), y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
            testTable.delegate = self
            testTable.dataSource = self
            testTable.registerClass(DynamicCell.self, forCellReuseIdentifier: "DynamicCell")
            testTable.tag = i + 1
            scrollContentView.addSubview(testTable)
            tableViews.append(testTable)
        }
        
    }

    
    func segmentedControlChangedValue(segemnet : HMSegmentedControl) {
        NSLog("segement = \(segemnet.selectedSegmentIndex)")
        let offSet = ScreenWidth*CGFloat(segemnet.selectedSegmentIndex)
        scrollContentView.contentOffset = CGPoint(x: offSet, y: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getdata(){
        
        
        let content = ["十四年之后再重看《东邪西毒》（编注：写于2008年），不只我看懂了，其他人也看懂了。不知道是不是王家卫的思想领先了我们整整十四年？","十四年前在威尼斯影展，我第一次看《东邪西毒》没看懂。心想：“为什么每个人说话都没有眼神接触？好像个个都对着空气讲话。到底谁爱谁？到底谁跟谁好？这么多人物，谁是谁都搞不清楚，怎么会好看？”看完电影我失望地吐出三个字：“不好看！”","十四年后，经过重新配乐（马友友演奏）和调色，音乐美，颜色浓。每个画面就像是一张完美鲜艳的油画。加上人生阅历多了，对人、对事、对感情的看法也不像从前那么简单，我终于看出了苗头。那年在榆林，每天将近黄昏时刻，所有演员都得把妆化好，在山洞口等天黑。吃完便当，天一黑就得进山洞。就那么一点大的空间，又打灯，又放烟，再加上工作人员抽烟，空气坏得使人几乎窒息。","有一天晚上，在拍戏空档，我坐在洞口躺椅上休息，他走过来告诉我他后脑勺给蝎子螫了。大家傻了眼，蝎子是有毒的，这可怎么了得？","收了工回酒店，见他坐在大厅椅子上低着头，旁边两个黑黑瘦瘦的当地人，拿着一瓶满是蝎子泡的水让他搽，说是比看医生管用。国荣已被吓得六神无主，只有一试。那晚，他一直没敢合眼。第二天就没事了，也不知道是不是以毒攻毒的效果。","第一天到片场，混在所有大牌演员（梁朝伟、张国荣、张学友、梁家辉、张曼玉、刘嘉玲、杨采妮）之间，简直不知道自己该怎么演才好。记得那天是十一月三日，正好是我的生日，公司准备了一个大蛋糕，让所有演员围着蛋糕唱生日快乐歌，可是我一点都快乐不起来。后来听刘嘉玲说，那天我还哭了呢。真丢脸，这点小事……","结果《东邪西毒》里的我，还真的不像东方不败。那是一种……一种带点神秘感的男人味。","二十多年拍了一百部戏，巧的是第一部《窗外》和第一百部《东邪西毒》的版权都在王家卫的手上。”"]
        
        for item in 0..<content.count {
            let model = CellModel()
            model.name = "test"
            model.avator = "ic_wode_0088ff"
            model.title = "头条"
            model.content = content[item]
            model.time = "5分钟"
            model.comemtNum = "100"
            model.zanNum = "123"
            model.imgsss  = "banner_bg,banner_bg,banner_bg,banner_bg,banner_bg,banner_bg,banner_bg,banner_bg,banner_bg"
            model.content = "十四年后，经过重新配乐（马友友演奏）和调色，音乐美，颜色浓。每个画面就像是一张完美鲜艳的油画。加上人生阅历多了，对人、对事、对感情的看法也不像从前那么简单，我终于看出了苗头。那年在榆林，每天将近黄昏时刻，所有演员都得把妆化好，在山洞口等天黑。吃完便当，天一黑就得进山洞。就那么一点大的空间，又打灯，又放烟，再加上工作人员抽烟，空气坏得使人几乎窒息。有一天晚上，在拍戏空档，我坐在洞口躺椅上休息，他走过来告诉我他后脑勺给蝎子螫了。大家傻了眼，蝎子是有毒的，这可怎么了得?"
            
            self.dataArray.append(model)
        }
        
        NSLog("xxxxx = \(self.dataArray.description)===\(self.dataArray.count)")
        
        
        
    }
    
    

    

}

extension DiscoverViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        NSLog("scrollView == \(scrollView.frame)---\(scrollView.contentOffset)")
    }
}


extension DiscoverViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.dataArray[indexPath.row]
        let imgs = model.imgsss.componentsSeparatedByString(",")
        
        return (DynamicCell.cellHeightWithStr(model.content, imgs: imgs))
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : DynamicCell = tableView.dequeueReusableCellWithIdentifier("DynamicCell",forIndexPath: indexPath) as! DynamicCell
        cell.model = self.dataArray[indexPath.row]
        cell.selectionStyle = .None
        return cell
    }
    
    
    
    
}






