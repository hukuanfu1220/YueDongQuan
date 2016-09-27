//
//  FieldViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit

class FieldViewController: MainViewController ,BMKMapViewDelegate,BMKLocationServiceDelegate,UITableViewDelegate,UITableViewDataSource{
    var locationService : BMKLocationService?
    var scroViewContent : UIScrollView!
    var fieldTable = UITableView()
    
    var _mapView: BMKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        
        scroViewContent = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        scroViewContent.showsHorizontalScrollIndicator = true
        scroViewContent.showsVerticalScrollIndicator = false
//        scroViewContent.pagingEnabled = true
        scroViewContent.scrollEnabled = true
        scroViewContent.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 243/255, alpha: 1.0)
        
        scroViewContent.contentSize = CGSize(width: ScreenWidth, height: ScreenHeight*2 )
        self.view.addSubview(scroViewContent)
        
        
        
        
        
        locationService = BMKLocationService()
        locationService?.delegate = self
        locationService?.distanceFilter = 10
        locationService?.desiredAccuracy  = 100
        locationService?.startUserLocationService()
        _mapView = BMKMapView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth))
        scroViewContent.addSubview(_mapView!)
        
        _mapView?.showsUserLocation = false;//显示定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeNone
        _mapView?.mapPadding = UIEdgeInsetsMake(0, 0, 28, 0)
        _mapView?.showMapScaleBar = true
        _mapView?.mapScaleBarPosition = CGPointMake(_mapView.frame.width - 60, _mapView.frame.height - 20)
        let param = BMKLocationViewDisplayParam()
        param.accuracyCircleStrokeColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        param.accuracyCircleFillColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3)
        _mapView.updateLocationViewWithParam(param)
        
        fieldTable = UITableView(frame: CGRect(x: 0, y: _mapView.frame.maxY, width: ScreenWidth, height: ScreenHeight*2 - _mapView.frame.maxY - 49 - 64), style: UITableViewStyle.Grouped)
        
        scroViewContent.addSubview(fieldTable)

        fieldTable.registerClass(FieldCell.self, forCellReuseIdentifier: "FieldCell")
        fieldTable.delegate = self
        fieldTable.dataSource = self
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        _mapView?.viewWillAppear()
        _mapView?.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView?.viewWillAppear()
        _mapView?.delegate = nil
    }
    
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        NSLog("didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude)
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        NSLog("didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude)
        _mapView?.updateLocationData(userLocation)
        _mapView.showsUserLocation = true
        _mapView?.setCenterCoordinate(CLLocationCoordinate2D(latitude: userLocation.location.coordinate.latitude, longitude: userLocation.location.coordinate.longitude), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 243/255, alpha: 1.0)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 243/255, alpha: 1.0)
        return footerView
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : FieldCell = tableView.dequeueReusableCellWithIdentifier("FieldCell", forIndexPath: indexPath) as! FieldCell
        cell.index = indexPath
        cell.delegate = self
        return cell
        
    }

    

}


extension FieldViewController : FieldCellDelegate {
    func clickConfirmFieldBtn(indexPath: NSIndexPath) {
        NSLog("点击了预定")
        
        let telNumber = "18798812521"
        
        let alertView = YoYoAlertView(title: "我要订场", message: telNumber, cancelButtonTitle: "取消", sureButtonTitle: "确定")
        
        alertView.show()
        
        alertView.clickIndexClosure { (index) in
            print("点击了第" + "\(index)" + "个按钮")
            
            if index == 2 {
                self.CallTelNumber(telNumber)
            }
            
        }
        
    }
    func clickEditFieldBtn(indexPath: NSIndexPath) {
        NSLog("点击了编辑")
        let vc = EditorFieldViewController()
        vc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(vc, animated: true)
        vc.hidesBottomBarWhenPushed = false
//        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: vc)
//        
//        self.navigationController?.presentViewController(nvc1, animated: true, completion: {
//            
//        })
        
    }
    func clickSiginFieldBtn(indexPath: NSIndexPath) {
        NSLog("点击了签到")
        let signVC = SignRankingCOntroller()
        signVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(signVC, animated: true)
        signVC.hidesBottomBarWhenPushed = false
        
    }
    
    
    func clickQianDaoImageTap(indexPath:NSIndexPath){
        let signvc = SignRankBtnController()
        signvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(signvc, animated: true)
        signvc.hidesBottomBarWhenPushed = false
        
    }
    
    
    //拨打电话
    func CallTelNumber(tel:String){
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(tel)")!)
    }
    
    
}






