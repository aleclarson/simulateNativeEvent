
ReactNativeComponentTree = require "ReactNativeComponentTree"
ReactNativeEventEmitter = require "ReactNativeEventEmitter"
ReactComponent = require "ReactComponent"
assertType = require "assertType"

simulateNativeEvent = (target, registrationName, nativeEvent) ->

  if target instanceof ReactComponent
    target = ReactNativeComponentTree.getNodeFromInstance target

  assertType target, Number
  assertType registrationName, String
  assertType nativeEvent, Object

  unless ReactNativeEventEmitter.registrationNames[registrationName]?
    throw Error "Invalid event name: #{registrationName}"

  topLevelType = registrationName.replace /^on/, "top"

  nativeEvent = Object.assign {}, nativeEvent, {target}
  ReactNativeEventEmitter.receiveEvent target, topLevelType, nativeEvent
  return

module.exports = simulateNativeEvent
