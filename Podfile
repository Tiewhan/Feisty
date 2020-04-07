platform :ios, '12.0'

target 'Feisty' do
  use_frameworks!
  pod 'CommonFiles', :git => 'https://github.com/Tiewhan/FeistyCommonFiles.git', :branch => 'develop'
  #pod 'CommonFiles', :path => '/Users/tsmith/Documents/SwiftProjects/FeistyCommonFiles'
  pod 'OHHTTPStubs/Swift'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'

  target 'FeistyTests' do
    inherit! :search_paths
    pod 'CommonFiles', :git => 'https://github.com/Tiewhan/FeistyCommonFiles.git', :branch => 'develop'
    #pod 'CommonFiles', :path => '/Users/tsmith/Documents/SwiftProjects/FeistyCommonFiles'
    pod 'OHHTTPStubs/Swift'
    pod 'Firebase/Analytics'
    pod 'Firebase/Crashlytics'
  end

  target 'FeistyUITests' do
    inherit! :search_paths
    pod 'CommonFiles', :git => 'https://github.com/Tiewhan/FeistyCommonFiles.git', :branch => 'develop'
    #pod 'CommonFiles', :path => '/Users/tsmith/Documents/SwiftProjects/FeistyCommonFiles'
    pod 'OHHTTPStubs/Swift'
    pod 'Firebase/Analytics'
    pod 'Firebase/Crashlytics'
  end

end
