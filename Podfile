# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Uniletter' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  pod "SnapKit"
  pod "Alamofire"
  pod "Kingfisher"
  pod "MarqueeLabel"
  pod "GoogleSignIn"
  pod "DropDown"
  pod "FSCalendar"
  pod "SwiftMessages"
  pod "Firebase/Messaging"
  pod "Toast-Swift"
  # Pods for Uniletter

  # Delete cocoapods deployment issue
  post_install do |installer|
     installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
           config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
           if config.build_settings['WRAPPER_EXTENSION'] == 'bundle'
	      config.build_settings['DEVELOPMENT_TEAM'] = 'AANGG4Q668'
           end
        end
     end
  end

end
