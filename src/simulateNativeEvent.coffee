
ReactNativeComponentTree = require "ReactNativeComponentTree"
ReactNativeEventEmitter = require "ReactNativeEventEmitter"
ReactComponent = require "ReactComponent"
assertType = require "assertType"
combine = require "combine"
isType = require "isType"
Kind = require "Kind"

simulateNativeEvent = (reactTag, registrationName, nativeEvent) ->

  assertType reactTag, Number.or Kind ReactComponent
  assertType registrationName, String
  assertType nativeEvent, Object

  if not ReactNativeEventEmitter.registrationNames[registrationName]?
    throw Error "Invalid event name: #{registrationName}"

  topLevelType = registrationName.replace /^on/, "top"

  if not isType reactTag, Number
    reactTag = ReactNativeComponentTree.getTagFromInstance reactTag

  nativeEvent = combine {}, nativeEvent, {target: reactTag}
  ReactNativeEventEmitter.receiveEvent reactTag, topLevelType, nativeEvent
  return

module.exports = simulateNativeEvent
