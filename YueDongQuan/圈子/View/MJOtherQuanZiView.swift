//
//  MJOtherQuanZiView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import MapKit
class MJOtherQuanZiView: UIView,UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKLocationServiceDelegate {
lazy var  whiteView = UIView()
    lazy var label = UILabel()
    lazy var tableView = UITableView(frame: CGRectZero, style: .Plain)
    //地图试图
    lazy var mapView = BMKMapView()
    //定位服务
    var localTion = BMKLocationService()
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
        
        
        mapView.frame = CGRectMake(ScreenWidth,
                                   0,
                                   ScreenWidth,
                                   ScreenHeight-ScreenHeight/3)
        mapView.tag = 10
        mapView.zoomLevel = 21
        self .addSubview(mapView)
        //给地图添加长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressOnMapView))
        mapView .addGestureRecognizer(longPress)
        
        localTion = BMKLocationService()
        localTion.delegate = self
        localTion.distanceFilter = 100
        localTion.desiredAccuracy = 100
        
        localTion.startUserLocationService()

        mapView.showsUserLocation = true
        let userLocaltion = BMKUserLocation()
        mapView.updateLocationData(userLocaltion)
        
        //动画
        UIView.animateWithDuration(0.5, delay: 0,
                                   options: .LayoutSubviews,
                                   animations: {
            self.whiteView.frame = CGRectMake(0, ScreenHeight/3*2,
                                            ScreenWidth ,ScreenHeight/3 )
            }, completion: nil)
        
        UIView.animateWithDuration(0.5) {
           self.mapView.frame = CGRectMake(0,
                                       0,
                                       ScreenWidth,
                                       ScreenHeight-ScreenHeight/3)
        }
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:表格代理
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
    //MARK:自定义大头针
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        //红色大头针
        if annotation.isKindOfClass(MJRedAnnotation) {
            var redAnno = mapView.dequeueReusableAnnotationViewWithIdentifier("redAnnotion")
            if redAnno == nil {
                redAnno = MJAnnotationView(annotation: annotation, reuseIdentifier: "redAnnotion", viewType: MJAnnotationViewType.Red)
                redAnno.tag = 1
                
            }else{
                redAnno.removeFromSuperview()
            }

            return redAnno
            
        }
        //绿色大头针
        else if annotation.isKindOfClass(MJGreenAnnotation){
            var greenAnno = mapView.dequeueReusableAnnotationViewWithIdentifier("greenAnnotion")
            if greenAnno == nil {
                greenAnno = MJAnnotationView(annotation: annotation, reuseIdentifier: "greenAnnotion", viewType: MJAnnotationViewType.Green)
            }else{
                greenAnno.removeFromSuperview()
            }
            return greenAnno
        }
        return nil
    }

    
    //MARK: 定位服务代理
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
        mapView.showsUserLocation = true
        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: userLocation.location.coordinate.latitude,
            longitude: userLocation.location.coordinate.longitude),
                                    animated: true)
        
        
        
    }
    func myAwesomeMethod(placemark: CLPlacemark) {
       //国家
        let  country = placemark.country
        //街道
        let thoroughfare = placemark.thoroughfare
//        let name = placemark.name
//        let subThoroughfare = placemark.subThoroughfare
        //省市区
        let locality = placemark.locality
        //城市
        let subLocality = placemark.subLocality
     
        
        print("\(country) \(locality) \(subLocality) \(thoroughfare)      ")
        
        
       
    }
    
    //动态添加大头针
    func longPressOnMapView(longpress:UILongPressGestureRecognizer) {
        if longpress.state == .Began {
            //第二次长按时移除上一个大头针
            let redView = self.viewWithTag(10)?.viewWithTag(1)
            if redView != nil {
                redView?.removeFromSuperview()
            }
            //获取point
            let point = longpress.locationInView(mapView)
            //将地图上的point转化为经纬度
            let coordinate = mapView.convertPoint(point, toCoordinateFromView: mapView)
            //红色大头针
            let redPointAnno = MJRedAnnotation()
            redPointAnno.coordinate = coordinate
            //绿色大头针
            let greenPointAnno = MJGreenAnnotation()
            greenPointAnno.coordinate = coordinate
            
            //反地理编码
            let gecoder = CLGeocoder()
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            gecoder.reverseGeocodeLocation(location, completionHandler: { (placemark:[CLPlacemark]?, error:NSError?) in
                if error != nil {
                    print("Geocode failed with error: (error.localizedDescription)")
                }
                if placemark!.count > 0 {
                    let myPlacemark = placemark![0]
                    self.myAwesomeMethod(myPlacemark)
                    if redPointAnno.isKindOfClass(MJRedAnnotation){
                        redPointAnno.title = myPlacemark.locality
                        redPointAnno.subtitle = myPlacemark.thoroughfare
                        self.mapView.delegate = self
                        self.mapView .addAnnotations([redPointAnno])
                    }
                    
                } else {
                    print("No placemark")
                }
            })

            
        }
    }
}
