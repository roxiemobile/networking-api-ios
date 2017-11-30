# coding: utf-8
Pod::Spec.new do |s|

# MARK: - Description

  s.name                  = 'NetworkingApi'
  s.summary               = 'Networking API is an HTTP library that makes networking for iOS apps easier.'
  s.version               = '0.0.1'

  s.platform              = :ios
  s.ios.deployment_target = '8.0'

  s.cocoapods_version     = '>= 1.4.0.beta.2'
  s.static_framework      = true

  s.homepage              = 'https://github.com/roxiemobile/networking-api.ios'
  s.authors               = { 'Roxie Mobile Ltd.' => 'sales@roxiemobile.com', 'Alexander Bragin' => 'bragin-av@roxiemobile.com', 'Denis Kolyasev' => 'kolyasevda@ekassir.com' }
  s.license               = 'BSD-4-Clause'

# MARK: - Configuration

  s.source = {
    git: 'https://github.com/roxiemobile/networking-api.ios.git',
    tag: s.version.to_s
  }

  s.default_subspecs = 'Converters',
                       'Helpers',
                       'Http',
                       'Rest'

# MARK: - Modules

  # TODO: Write a description
  s.subspec 'Converters' do |sp|
    sp.dependency 'NetworkingApiConverters', s.version.to_s
  end

  # TODO: Write a description
  s.subspec 'Helpers' do |sp|
    sp.dependency 'NetworkingApiHelpers', s.version.to_s
  end

  # TODO: Write a description
  s.subspec 'Http' do |sp|
    sp.dependency 'NetworkingApiHttp', s.version.to_s
  end

  # TODO: Write a description
  s.subspec 'Rest' do |sp|
    sp.dependency 'NetworkingApiRest', s.version.to_s
  end
end
