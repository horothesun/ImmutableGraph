#
# Be sure to run `pod lib lint ImmutableGraph.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ImmutableGraph'
  s.version          = '0.1.3'
  s.summary          = 'Functional Swift graph algorithms.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Functional Swift graph algorithms: DFS, BFS and FindPath on immutable graphs developed using TDD.
                       DESC

  s.homepage         = 'https://github.com/horothesun/ImmutableGraph'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'horothesun' => 'horothesun@gmail.com' }
  s.source           = { :git => 'https://github.com/horothesun/ImmutableGraph.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_versions = '5.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'ImmutableGraph/Classes/**/*'

  # s.resource_bundles = {
  #   'ImmutableGraph' => ['ImmutableGraph/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
