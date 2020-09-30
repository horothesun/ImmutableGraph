Pod::Spec.new do |s|
  s.name = 'ImmutableGraph'
  s.version = '0.0.1' # updated by the "Deploy to CocoaPods" GitHub Action
  s.summary = 'Functional Swift graph algorithms.'

  s.description = <<-DESC
Functional Swift graph algorithms: DFS, BFS and FindPath on immutable graphs developed using TDD.
DESC

  s.homepage = 'https://github.com/horothesun/ImmutableGraph'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'horothesun' => 'horothesun@gmail.com' }
  s.source = { :git => 'https://github.com/horothesun/ImmutableGraph.git', :tag => s.version.to_s }

  s.swift_versions = '5.0'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.14'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '4.0'

  s.source_files = 'Sources/ImmutableGraph/**/*.swift'
end
