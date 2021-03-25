# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'TheMovieApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

#  inhibit_all_warnings!
  pod 'Moya/RxSwift'
  pod 'ObjectMapper'
  pod 'RxCocoa', '~> 5.1.1'
  pod 'RxAppState'
  pod 'Kingfisher'
  pod 'Action'
  pod 'XCoordinator/RxSwift', '~> 2.0'
  pod 'Resolver', :git => 'https://github.com/hmlongco/Resolver.git'

  # auto layout
  pod 'SnapKit'

  # control
  pod 'SwiftEntryKit', '1.0.2'
  pod 'DifferenceKit'
  pod 'Cosmos', '~> 23.0'

  # clean code
  pod 'R.swift'
  
  #animation
  pod 'lottie-ios'
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if target.name == 'Resolver'
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '5.1'
              end
          end
      end

      # only use for xcode 14 build on simulator
      installer.pods_project.build_configurations.each do |config|
          config.build_settings[‘EXCLUDED_ARCHS[sdk=iphonesimulator*]’] = ‘arm64’
      end
  end

end
