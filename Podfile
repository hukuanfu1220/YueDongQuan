# Uncomment this line to define a global platform for your project
post_install do |installer| 
installer.pods_project.targets.each do |target| 
target.build_configurations.each do |config| 
config.build_settings[‘SWIFT_VERSION’] = ‘2.3’ 
end 
end 
end 
platform :ios, '8.0'

target 'YueDongQuan' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

	pod 'AFNetworking', '~> 3.1.0'
	pod 'SnapKit', '~> 0.30.0.beta2’
	pod 'SDWebImage', '~> 3.8.1'
	pod 'SwiftyJSON', '~> 2.3.2'
	 pod 'IQKeyboardManagerSwift', '~> 3.3.4'
        pod 'Masonry', '~> 1.0.1'
        #    pod 'Alamofire', '~> 3.1.0'
        pod 'XHImageViewer', '0.1.2'
        #pod 'BaiduMapKit', '~> 3.0.0'
       pod 'TZImagePickerController', '~> 1.6.7'
       pod 'HYBSnapkitAutoCellHeight', '~> 2.0.0'
	pod 'AMapLocation', '~> 2.1.1'
	pod 'AMap2DMap', '~> 4.3.0'
    pod 'RongCloudIMKit', '~> 2.7.2'

pod 'ShareSDK2'
# Mob 公共库(必须) 如果同时集成SMSSDK iOS2.0:可看此注意事项：http://bbs.mob.c om/thread-20051-1-1.html
pod 'MOBFoundation'

pod 'ShareSDK2/UI/Flat'
pod 'ShareSDK2/UI/iPadDefault'

pod 'ShareSDK2/Connection/SinaWeibo'
pod 'ShareSDK2/Connection/WeChat'
pod 'ShareSDK2/Connection/QQ'
  # Pods for YueDongQuan


end
