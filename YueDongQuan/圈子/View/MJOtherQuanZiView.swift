//
//  MJOtherQuanZiView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit


class MJOtherQuanZiView: UIView,UITableViewDelegate,UITableViewDataSource,MAMapViewDelegate,AMapLocationManagerDelegate{
    lazy var  whiteView = UIView()
    
    lazy var label = UILabel()
    
    lazy var tableView = UITableView(frame: CGRectZero, style: .Plain)
    //地图试图
    lazy var mapView = MAMapView()
    //定位服务
    var locationManager = AMapLocationManager()
    
    var completionBlock: ((location: CLLocation?,
    regeocode: AMapLocationReGeocode?,
    error: NSError?) -> Void)!
    
    let defaultLocationTimeout = 6
    let defaultReGeocodeTimeout = 3
    
    var annotations : NSMutableArray!
    
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
        mapView.delegate = self
        self .addSubview(mapView)
        
//        mapView.showsUserLocation = true
        //MARK:自定义经纬度
        annotations = NSMutableArray()
        let   coordinates = [[29.287746,106.012341],
                             [29.1342223,106.42112],
                             [28.243223,106.927462],
                             [29.4392749,106.3274685],
                             [29.486173,106.846512]]
        for i in 0 ..< coordinates.count {
            if i % 2 == 0 {
                let gren = MJGreenAnnotation()
                let coordate = CLLocationCoordinate2D(latitude: 29.583859 + Double(i), longitude: 106.489968 + Double(i))
                gren.coordinate = coordate
                annotations .addObject(gren)
            }else{
                let red = MJRedAnnotation()
                let coordate = CLLocationCoordinate2D(latitude: 29.287746 - Double(i), longitude: 106.012341 - Double(i))
                red.coordinate = coordate
                annotations .addObject(red)
            }
        }
        
       
        initCompleteBlock()
        
        configLocationManager()
        
        //逆地理编码
        reGeocodeAction()
        
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
    //MARK: - Action Handle
    
    func configLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.locationTimeout = defaultLocationTimeout
        
        locationManager.reGeocodeTimeout = defaultReGeocodeTimeout
    }

    func reGeocodeAction() {
        mapView.removeAnnotations(mapView.annotations)
        
        locationManager.requestLocationWithReGeocode(true, completionBlock: completionBlock)
    }


    func initCompleteBlock() {
        
        completionBlock = { [weak self] (location: CLLocation?, regeocode: AMapLocationReGeocode?, error: NSError?) in
            if let error = error {
                NSLog("locError:{%d - %@};", error.code, error.localizedDescription)
                
                if error.code == AMapLocationErrorCode.LocateFailed.rawValue {
                    return;
                }
            }
            
            if let location = location {
                
                let annotation = MJRedAnnotation()
                annotation.coordinate = location.coordinate
                
                if let regeocode = regeocode {
                    annotation.title = regeocode.formattedAddress
                    annotation.subtitle = "\(regeocode.citycode)-\(regeocode.adcode)-\(location.horizontalAccuracy)m"
                }
                else {
                    annotation.title = String(format: "lat:%.6f;lon:%.6f;", arguments: [location.coordinate.latitude, location.coordinate.longitude])
                    annotation.subtitle = "accuracy:\(location.horizontalAccuracy)m"
                }
                
                self?.addAnnotationsToMapView(annotation)

            }
            
        }
    }
    //添加大头针
    func addAnnotationsToMapView(annotation: MAAnnotation) {
        
        mapView .addAnnotations(annotations as [AnyObject])
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        mapView.setZoomLevel(15.1, animated: false)
        mapView.setCenterCoordinate(annotation.coordinate, animated: true)

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
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        

            if annotation.isKindOfClass(MJGreenAnnotation) {
                let pointReuseIndetifier = "pointReuseIndetifier"
                
                var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(pointReuseIndetifier)
                if annotationView == nil {
                    annotationView = MJGreenAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
                }
                
                annotationView?.canShowCallout  = true
                annotationView?.draggable       = true
                annotationView?.image = UIImage(named: "img_putongquanzi")
                return annotationView
            }
        
        if annotation.isKindOfClass(MJRedAnnotation) {
            let redReuseIndetifier = "red"
            var redAnnotation = mapView.dequeueReusableAnnotationViewWithIdentifier(redReuseIndetifier)
            if redAnnotation == nil {
                redAnnotation = MJRedAnnotationView(annotation: annotation, reuseIdentifier: redReuseIndetifier)
            }
            return redAnnotation

        }
        return nil
    }

    
    //MARK: 定位服务代理
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        NSLog("location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    }
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!) {
        
    }
    
    func didUpdateBMKUserLocation(userLocation: MAUserLocation!) {
    
    }
    func mapView(mapView: MAMapView!, didLongPressedAtCoordinate coordinate: CLLocationCoordinate2D) {

        let pointView = MJGreenAnnotation()
        pointView.coordinate = coordinate
        locationManager.requestLocationWithReGeocode(true) { (location:CLLocation!, regeocode:AMapLocationReGeocode!, error:NSError!) in
            if (regeocode != nil){
                pointView.title = regeocode.formattedAddress
//                pointView.subtitle = regeocode.city
                mapView.delegate = self
                mapView .addAnnotation(pointView)
            }
        }
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
    
}
