#
# Be sure to run `pod lib lint AMNotificationView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AMNotificationView'
  s.version          = '0.1.0'
  s.summary          = 'Simple Framework for In-App Xib based Notification'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Posix88/AMNotificationView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Antonino Francesco Musolino' => 'ninomusolino@gmail.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/AMNotificationView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Ninomusolino'

  s.ios.deployment_target = '9.3'

  s.source_files = 'AMNotificationView/Classes/**/*'
  s.frameworks = 'AudioToolbox', 'AVFoundation'

  # s.resource_bundles = {
  #   'AMNotificationView' => ['AMNotificationView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
