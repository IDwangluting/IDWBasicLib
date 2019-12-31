#
# Be sure to run `pod lib lint WWBasicTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'WWBasicTool'
  s.version               = '0.0.1'
  s.summary               = 'WWBasicTool is tool lib.'
  s.description           = <<-DESC
                                WWBasicTool is tool lib to use
                              DESC

  s.homepage              = 'https://github.com/IDwangluting/WWBasicTool'
  s.license               = "Copyright (c) 2018年 wangluitng. All rights reserved."
  s.author                = { 'IDwangluting' => 'm13051699286@163.com' }
  s.source                = { :git => 'https://github.com/IDwangluting/WWBasicTool.git', :tag => s.version.to_s }
  # s.social_media_url    = 'https://twitter.com/<TWITTER_USERNAME>'
  # s.screenshots         = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'

  s.ios.deployment_target = '8.0'
  s.frameworks            = 'UIKit','Foundation'
  s.source_files          = 'WWBasicTool/Classes/**/*'
  
  s.dependency 'YYCache'     , '~> 1.0.4'
  s.dependency 'AFNetworking', '~>3.2.1'
  s.dependency 'YYModel'     , '~> 1.0.4'
  s.dependency 'YYCategories', '~> 1.0.4'

end
