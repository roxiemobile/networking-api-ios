# coding: utf-8
Pod::Spec.new do |s|

# MARK: - Description

  s.name                  = 'NetworkingApi'
  s.summary               = 'Networking API is an HTTP library that makes networking for iOS apps easier.'
  s.version               = '1.1.0'

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
                       'ObjC',
                       'Rest'

# MARK: - Modules

  # A collection of useful converters for the asynchronous REST API client.
  s.subspec 'Converters' do |sp|
    sp.dependency 'NetworkingApiConverters', s.version.to_s
  end

  # A collection of utility classes used by other modules of this library.
  s.subspec 'Helpers' do |sp|
    sp.dependency 'NetworkingApiHelpers', s.version.to_s
  end

  # A collection of useful type extensions and utility classes used for communication over HTTP protocol.
  s.subspec 'Http' do |sp|
    sp.dependency 'NetworkingApiHttp', s.version.to_s
  end

  # A collection of Objective-C frameworks, utility classes and 3rd party libraries used by other modules of this library.
  s.subspec 'ObjC' do |sp|
    sp.dependency 'NetworkingApiObjC', s.version.to_s
  end

  # An asynchronous REST API client that makes an access to a RESTful Web Services easier.
  s.subspec 'Rest' do |sp|
    sp.dependency 'NetworkingApiRest', s.version.to_s
  end
end
