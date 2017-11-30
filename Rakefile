# coding: utf-8
base_dir = File.expand_path('..', __FILE__)

$:.unshift base_dir
require 'bundler'
Dir.glob(File.join(base_dir, 'Tasks', '**', '*.rb'), &method(:require))

FRAMEWORK ||= RoxieMobile::Framework.new(
  name: 'NetworkingApi',
  base_dir: base_dir,
  projects: [
    'Converters',
    'Helpers',
    'Http',
    'ObjC',
    'Rest'
  ]
)

desc 'Bump all versions to match FRAMEWORK_VERSION.'
task :update_version => 'all:update_version'
