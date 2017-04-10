# coding: utf-8
Pod::Spec.new do |s|

  s.name                  = 'NetworkingApi'
  s.summary               = 'Networking API is an HTTP library that makes networking for iOS apps easier.'
  s.version               = '0.7.2'

  s.platform              = :ios
  s.ios.deployment_target = '8.0'

  s.authors               = { 'Alexander Bragin' => 'bragin-av@roxiemobile.com', 'Denis Kolyasev' => 'kolyasevda@ekassir.com' }

  s.license               = { type: 'BSD-4-Clause', file: 'LICENSE.txt' }

  s.homepage              = 'https://github.com/roxiemobile/networking-api.ios'

  s.source                = { git: 'https://github.com/roxiemobile/networking-api.ios.git', tag: s.version.to_s }
  s.source_files          = 'modules/networking-api/NetworkingApi/**/*.{h,m,swift}'
  s.preserve_path         = 'LICENSE.txt'

  s.pod_target_xcconfig   = { 'ENABLE_BITCODE' => 'NO' }

  # External dependencies
  s.dependency 'SwiftCommons', '~> 0.7.2'
  s.dependency 'Alamofire', '~> 4.4'

end
