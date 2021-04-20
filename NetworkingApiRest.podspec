# coding: utf-8
Pod::Spec.new do |s|

# MARK: - Description

  s.name                  = 'NetworkingApiRest'
  s.summary               = 'An asynchronous REST API client that makes an access to a RESTful Web Services easier.'
  s.version               = '1.5.0'

  s.platform              = :ios
  s.ios.deployment_target = '12.0'
  s.swift_version         = '5.3'

  s.cocoapods_version     = '>= 1.10.1'
  s.static_framework      = true

  s.homepage              = 'https://github.com/roxiemobile/networking-api.ios'
  s.authors               = { 'Roxie Mobile Ltd.' => 'sales@roxiemobile.com', 'Alexander Bragin' => 'bragin-av@roxiemobile.com', 'Denis Kolyasev' => 'kolyasevda@ekassir.com' }
  s.license               = 'BSD-4-Clause'

# MARK: - Configuration

  s.source = {
    git: 'https://github.com/roxiemobile/networking-api.ios.git',
    tag: s.version.to_s
  }

  base_dir = 'Modules/RoxieMobile.NetworkingApi/Sources/Rest/'
  s.source_files = base_dir + '{Sources,Dependencies}/**/*.swift'

  s.pod_target_xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS' => "$(inherited) NETWORKINGAPI_FRAMEWORK_VERSION=@\\\"#{s.version}\\\""
  }

# MARK: - Dependencies

  s.dependency 'Alamofire', '~> 4.9.1'
  s.dependency 'NetworkingApiHelpers', s.version.to_s
  s.dependency 'NetworkingApiObjC', s.version.to_s
  s.dependency 'SwiftCommons/Data', '~> 1.6.0'
  s.dependency 'SwiftyJSON', '~> 5.0.1'
end
