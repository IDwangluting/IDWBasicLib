#
# Be sure to run `pod lib lint WWBasicLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'WWBasicLib'
  s.version               = '0.0.2'
  s.summary               = 'WWBasicLib is tool lib.'
  s.description           = <<-DESC
                                WWBasicLib is tool lib to use
                              DESC

  s.homepage              = 'https://github.com/IDwangluting/WWBasicLib'
  s.license               = 'MIT'
  s.author                = { 'IDwangluting' => 'm13051699286@163.com' }
  s.source                = { :git => 'https://github.com/IDwangluting/WWBasicLib.git', :tag => s.version.to_s }
  # s.social_media_url    = 'https://twitter.com/<TWITTER_USERNAME>'
  # s.screenshots         = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'

  s.ios.deployment_target = '8.0'
  s.frameworks            = 'UIKit','Foundation'
  s.source_files          = 'WWBasicLib/Classes/**/*'
  
  s.subspec 'NetworkingTool' do |ss|
    ss.source_files             = 'WWBasicLib/Classes/NetworkingTool/**/*'
    ss.dependency 'YYCache'     , '~> 1.0.4'
    ss.dependency 'AFNetworking', '~>3.2.1'
    ss.dependency 'YYModel'     , '~> 1.0.4'
    ss.dependency 'YYCategories', '~> 1.0.4'
  end
  
  s.subspec 'Foundation' do |ss|
     ss.source_files          = 'WWBasicLib/Classes/Foundation/**/*'
  end
   
  s.subspec 'Foundation' do |ss|
     ss.source_files          = 'WWBasicLib/Classes/Catagroy/**/*'
  end

end
