#!/bin/sh

pod trunk push --synchronous NetworkingApiObjC.podspec
pod trunk push --synchronous NetworkingApiHttp.podspec
pod trunk push --synchronous NetworkingApiHelpers.podspec
pod trunk push --synchronous NetworkingApiRest.podspec
pod trunk push --synchronous NetworkingApiConverters.podspec
pod trunk push --synchronous NetworkingApi.podspec
