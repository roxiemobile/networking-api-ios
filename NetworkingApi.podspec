# coding: utf-8
Pod::Spec.new do |s|

# MARK: - Description

  s.name                  = 'NetworkingApi'
  s.summary               = 'Networking API is an HTTP library that makes networking for iOS apps easier.'
  s.version               = '0.0.1'

  s.platform              = :ios
  s.ios.deployment_target = '8.0'
  s.static_framework      = true

  s.authors               = { 'Roxie Mobile Ltd.' => 'sales@roxiemobile.com', 'Alexander Bragin' => 'bragin-av@roxiemobile.com', 'Denis Kolyasev' => 'kolyasevda@ekassir.com' }
  s.license               = { type: 'BSD-4-Clause', file: 'LICENSE.txt' }

  s.homepage              = 'https://github.com/roxiemobile/networking-api.ios'

  s.source                = { git: 'https://github.com/roxiemobile/networking-api.ios.git', tag: "v#{s.version}" }
  s.preserve_path         = 'LICENSE.txt'

  s.pod_target_xcconfig   = { 'ENABLE_BITCODE' => 'NO', 'SWIFT_VERSION' => '4.0' }

  s.default_subspecs      = 'Core/Converters',
                            'Core/Net'

# MARK: - Modules

  # TODO: Write a description
  s.subspec 'Core' do |sc|

    # TODO: Write a description
    sc.subspec 'Converters' do |sp|
      sp.source_files = 'modules/RoxieMobile.NetworkingApi/Core.Converters/Module/**/*.{swift,h,m,c}'

      # Dependencies
      sp.dependency 'NetworkingApi/Core/Net', s.version.to_s
    end

    # TODO: Write a description
    sc.subspec 'Net' do |sp|
      sp.source_files = 'modules/RoxieMobile.NetworkingApi/Core.Net/Module/**/*.{swift,h,m,c}'

      # Dependencies
      sp.dependency 'Alamofire', '~> 4.5.1'
#     sp.dependency 'Dispatch', '~> 2.0.3'
      sp.dependency 'SwiftCommons/Core/Data'
      sp.dependency 'SwiftyJSON', '~> 3.1.4'
    end
  end
end
