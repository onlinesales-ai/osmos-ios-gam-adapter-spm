#
# Be sure to run `pod lib lint osmos-ios-gam-adapter-spm.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "osmos-ios-gam-adapter-spm"
  s.module_name      = "OsmosGAMAdapter"
  s.version          = "1.0.0"
  s.summary          = "Google Ad Manager adapter for the OSMOS iOS SDK."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                          Google Ad Manager adapter for the OSMOS iOS SDK, enabling OSMOS demand to be served through Google Ad Manager. For more information see the OSMOS SDK implementation docs at https://developers.onlinesales.ai/docs/init-ios-sdk.
                       DESC

  s.homepage         = "https://www.osmos.ai/"
  s.license          = 'Apache 2.0'
  s.author           = { "osmos.ai" => "api@osmos.ai" }
  s.source           = { :http => "https://github.com/onlinesales-ai/osmos-ios-gam-adapter/releases/download/1.0.0/OsmosGAMAdapter-1.0.0.zip" }
  s.vendored_frameworks = "OsmosGAMAdapter.xcframework"

  s.platform     = :ios, '15.0'
  s.requires_arc = true

  s.swift_versions = ['5.5']

  s.dependency 'Google-Mobile-Ads-SDK', '>= 11.0.0'
  s.dependency 'osmos-network-ad-core-spm', '>= 1.0.0'
end
