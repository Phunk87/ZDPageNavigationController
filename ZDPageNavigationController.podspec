#
# Be sure to run `pod lib lint ZDPageNavigationController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ZDPageNavigationController"
  s.version          = "0.1.3"
  s.summary          = "A pagable NavigationController in Objective-C."
  s.homepage         = "https://github.com/0dayZh/ZDPageNavigationController"
  s.license          = 'MIT'
  s.author           = { "0dayZh" => "0day.zh@gmail.com" }
  s.source           = { :git => "https://github.com/0dayZh/ZDPageNavigationController.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ZDPageNavigationController' => ['Pod/Assets/*.png']
  }

  s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC -all_load -force_load' }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SMPageControl'
end
