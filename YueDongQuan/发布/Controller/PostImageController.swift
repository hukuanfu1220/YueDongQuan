//
//  PostImageController.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/24.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import TZImagePickerController
import AssetsLibrary

class PostImageController: UIViewController,CustomTextFieldDelegate,UINavigationControllerDelegate{
    
    let iOS7Later = Float(UIDevice.currentDevice().systemVersion) >= 7.0
    let iOS8Later = Float(UIDevice.currentDevice().systemVersion) >= 8.0
    let iOS9Later = Float(UIDevice.currentDevice().systemVersion) >= 9.0
    let iOS9_1Later = Float(UIDevice.currentDevice().systemVersion) >= 9.1
    
    var sayLabel = UILabel()
    var _selectedPhotos = NSMutableArray()
    var _selectedAssets = NSMutableArray()
    var _isSelectOriginalPhoto = Bool()
    var itemWH : CGFloat = 0
    
    
//    var imagePickerVc : UIImagePickerController!
    
    var imageCollectionView : UICollectionView!
    
    var sayTextField = CustomTextField(frame: CGRect(x: 10, y: 10, width: ScreenWidth - 20, height: 30), placehoder: "说点什么吧....(120字内)", fontSize: UIFont.systemFontOfSize(14))
    
    var showLoactionBtn = UIButton()
    
    lazy var imagePickerVc : UIImagePickerController = {
        let imagePickerVc = UIImagePickerController()
        imagePickerVc.delegate = self
        return imagePickerVc
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setNav()
        self.edgesForExtendedLayout = .None
        sayTextField.textDelegate = self
        self.view.addSubview(sayTextField)
        setUI()
        
    }
    
    func setUI(){
        let layout = LxGridViewFlowLayout()
        itemWH = (self.view.tz_width - 2 * 4 - 4)/3 - 4
        
        layout.itemSize = CGSizeMake(itemWH, itemWH)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        imageCollectionView = UICollectionView(frame: CGRect(x: 0, y: CGRectGetMaxY(sayTextField.frame) + 20, width: self.view.tz_width, height: self.view.tz_width), collectionViewLayout: layout)
        let rgb : CGFloat = 244/255.0
        imageCollectionView.alwaysBounceVertical = true
        imageCollectionView.backgroundColor = UIColor(red: rgb, green: rgb, blue: rgb, alpha: 1.0)
        imageCollectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        self.view.addSubview(imageCollectionView)
        
        imageCollectionView.registerClass(TZTestCell.self, forCellWithReuseIdentifier: "TZTestCell")
        
        
        self.view.addSubview(showLoactionBtn)
//        showLoactionBtn.snp_makeConstraints { (make) in
//            make.left.right.equalTo(0)
//            make.top.equalTo(editPhotoView.snp_bottom).offset(30)
//            make.height.equalTo(30)
//        }
        showLoactionBtn.setTitle("显示地点", forState: UIControlState.Normal)
        showLoactionBtn.setTitleColor(UIColor ( red: 0.1843, green: 0.1843, blue: 0.1882, alpha: 1.0 ), forState: UIControlState.Normal)
        showLoactionBtn.backgroundColor = UIColor ( red: 0.9451, green: 0.949, blue: 0.9569, alpha: 1.0 )
        showLoactionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 100)
        showLoactionBtn.titleLabel?.font = UIFont.systemFontOfSize(10)
    }

    
    func getTextString(text: String) {
        NSLog("text == \(text)")
        
        
//        showLoactionBtn.snp_updateConstraints { (make) in
//            make.left.right.equalTo(0)
//            make.top.equalTo(editPhotoView.snp_bottom).offset(30)
//            make.height.equalTo(30)
//        }
    }
    
    
    
    func setNav(){
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        let imgView = UIImageView(frame:leftView.frame)
        imgView.image = UIImage(named: "CDEditBack.jpg")
        imgView.contentMode = .Center
        leftView.addSubview(imgView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        
        leftView.addGestureRecognizer(tap)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.451, green: 0.6824, blue: 0.3098, alpha: 1.0 )
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    func dismissVC(){
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    
    deinit {
        NSLog("销毁视图控制器")
    }
    
    
    //获取字符串宽高
    private func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        
        return rect;
    }
    
    
   
    
    
    
    
    override func viewWillAppear(animated: Bool) {
//        self.navigationController?.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillDisappear(animated: Bool) {
//        self.navigationController?.hidesBottomBarWhenPushed = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func deleteBtnClick(sender : UIButton){
        _selectedPhotos.removeObjectAtIndex(sender.tag)
        _selectedAssets.removeObjectAtIndex(sender.tag)
        self.imageCollectionView.performBatchUpdates({ 
            let indexPath = NSIndexPath(forItem: sender.tag, inSection: 0)
            self.imageCollectionView.deleteItemsAtIndexPaths([indexPath])
            
        }) { (finished : Bool) in
            self.imageCollectionView.reloadData()
        }
    }
    

}

extension PostImageController : UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._selectedPhotos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : TZTestCell = collectionView.dequeueReusableCellWithReuseIdentifier("TZTestCell", forIndexPath: indexPath) as! TZTestCell
        cell.videoImageView.hidden = true
        
        if indexPath.row == _selectedPhotos.count {
            cell.imageView.image = UIImage(named: "AlbumAddBtn.png")
            cell.deleteBtn.hidden = true
        }else{
            cell.imageView.image = _selectedPhotos[indexPath.row] as? UIImage
            cell.deleteBtn.hidden = false
            cell.asset = _selectedAssets[indexPath.row]
        }
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == _selectedPhotos.count {
            pushImagePickerController()
        }else{
            let asset = _selectedAssets[indexPath.row]
            var isVideo = false
            if (asset.isKindOfClass(PHAsset.self)) {
                let phAsset = asset as! PHAsset
                isVideo = phAsset.mediaType == PHAssetMediaType.Video
                
            }else if (asset.isKindOfClass(ALAsset.self)){
                let alAsset = asset as! ALAsset
                isVideo = alAsset.valueForProperty(ALAssetPropertyType).isEqualToString(ALAssetTypeVideo)
            }
            
            if isVideo {
                let vc = TZVideoPlayerController()
                let model = TZAssetModel.init(asset: asset, type: TZAssetModelMediaTypeVideo, timeLength: "")
                vc.model = model
                self.presentViewController(vc, animated: true, completion: nil)
            }else{
                let imagePickerVC = TZImagePickerController(selectedAssets: _selectedAssets, selectedPhotos: _selectedPhotos, index: indexPath.row)
                imagePickerVC.maxImagesCount = 9
                imagePickerVC.allowPickingOriginalPhoto = true
                imagePickerVC.isSelectOriginalPhoto = _isSelectOriginalPhoto
                
                imagePickerVC.didFinishPickingPhotosHandle = {(photos:[UIImage]!,assets:[AnyObject]!,isSelectOriginalPhoto:Bool) -> Void in
                
                    self._selectedPhotos = NSMutableArray(array: photos)
                    self._selectedAssets = NSMutableArray(array: assets)
                    self._isSelectOriginalPhoto = isSelectOriginalPhoto
                    self.imageCollectionView.reloadData()
                    self.imageCollectionView.contentSize = CGSizeMake(0, CGFloat(self._selectedPhotos.count + 2)/3*(4 + self.itemWH))
                }
                
                self.presentViewController(imagePickerVC, animated: true, completion: nil)
                
            }
            
            
            
            
        }
    }
    

    
    ///LxGridViewDataSource
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.item < _selectedPhotos.count
    }
    
    func collectionView(collectionView: UICollectionView,itemAtIndexPath sourceIndexPath:NSIndexPath,canMoveToIndexPath destinationIndexPath : NSIndexPath) -> Bool {
        return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count)
    }
    
    func collectionView(collectionView: UICollectionView,itemAtIndexPath sourceIndexPath:NSIndexPath,didMoveToIndexPath destinationIndexPath : NSIndexPath){
        
        let image = _selectedPhotos[sourceIndexPath.item]
        _selectedPhotos.removeObjectAtIndex(sourceIndexPath.item)
        _selectedPhotos.insertObject(image, atIndex: destinationIndexPath.item)
        
        let asset = _selectedAssets[sourceIndexPath.item]
        _selectedAssets.removeObjectAtIndex(sourceIndexPath.item)
        _selectedAssets.insertObject(asset, atIndex: destinationIndexPath.item)
        
        
        imageCollectionView.reloadData()
        
    }
    
    
    func pushImagePickerController(){
        let imagePickerVC  = TZImagePickerController(maxImagesCount: 9, columnNumber: 3, delegate: self)
        imagePickerVC.selectedAssets = _selectedAssets
        imagePickerVC.allowTakePicture = true
        imagePickerVC.allowPickingVideo = true
        imagePickerVC.allowPickingImage = true
        imagePickerVC.sortAscendingByModificationDate = true
        
        imagePickerVC.didFinishPickingPhotosHandle = {(photos:[UIImage]!,assets:[AnyObject]!,isSelectOriginalPhoto:Bool) -> Void in
        
        }
        
        self.presentViewController(imagePickerVC, animated: true, completion: nil)
        
    }
    
    func takePhoto(){
        let authStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        if (authStatus == AVAuthorizationStatus.Restricted) || (authStatus == AVAuthorizationStatus.Denied) {
            let alert = UIAlertView(title: "无法使用相机", message: "请在iPhone的设置-隐私-相机中允许访问相机)", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "设置")
            alert.show()
        }else{
            let souceType = UIImagePickerControllerSourceType.Camera
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
                self.imagePickerVc.sourceType = souceType
                self.imagePickerVc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
                self.presentViewController(imagePickerVc, animated: true, completion: nil)
            }else{
                NSLog("模拟器中无法打开照相机,请在真机中使用")
            }
            
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        let type = info[UIImagePickerControllerMediaType] as! NSString
        if (type.isEqualToString("public.image")) {
            let tzImagePickerVC  = TZImagePickerController(maxImagesCount: 9, delegate: self)
            tzImagePickerVC.sortAscendingByModificationDate = true
            tzImagePickerVC.showProgressHUD()
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            TZImageManager().savePhotoWithImage(image, completion: { ( error : NSError!) in
                if (error != nil) {
                    tzImagePickerVC.hideProgressHUD()
                    let alert = UIAlertView(title: "无法保存", message: "请在iPhone的设置-隐私-相册中允许访问相册", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "设置")
                    alert.tag = 1
                    alert.show()
                }else{
                    TZImageManager().getCameraRollAlbum(false, allowPickingImage: true, completion: { (model : TZAlbumModel!) in
                        TZImageManager().getAssetsFromFetchResult(model.result, allowPickingVideo: false, allowPickingImage: true, completion: { (models : [TZAssetModel]!) in
                            tzImagePickerVC.hideProgressHUD()
                            var assetModel = models.first
                            
                            if tzImagePickerVC.sortAscendingByModificationDate{
                                assetModel = models.last
                            }
                            self._selectedAssets.addObject((assetModel?.asset)!)
                            self._selectedPhotos.addObject(image)
                            self.imageCollectionView.reloadData()
                            
                        })
                    })
                }
            })
        }
        
    }
    
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
        _selectedPhotos = NSMutableArray(array: photos)
        _selectedAssets = NSMutableArray(array: assets)
        _isSelectOriginalPhoto = isSelectOriginalPhoto
        self.imageCollectionView.reloadData()
    }
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingVideo coverImage: UIImage!, sourceAssets asset: AnyObject!) {
        _selectedPhotos = NSMutableArray(array: [coverImage])
        _selectedAssets = NSMutableArray(array: [asset])
        self.imageCollectionView.reloadData()
    }
    
    
    
}


