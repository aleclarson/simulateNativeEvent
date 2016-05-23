
ReactNativeEventEmitter = require "ReactNativeEventEmitter"
ReactNativeTagHandles = require "ReactNativeTagHandles"
ReactComponent = require "ReactComponent"
assertType = require "assertType"
combine = require "combine"
isType = require "isType"
assert = require "assert"
Kind = require "Kind"

{ registrationNames } = ReactNativeEventEmitter

module.exports = (componentOrTag, registrationName, nativeEvent) ->

  assertType componentOrTag, [ Number, Kind(ReactComponent) ]
  assertType registrationName, String
  assertType nativeEvent, Object

  assert registrationNames[registrationName]?, { reason: "Invalid event name!", registrationName, registrationNames }

  topLevelType = registrationName.replace /^on/, "top"

  if componentOrTag instanceof ReactComponent
    component = componentOrTag
    rootNodeID = component._reactInternalInstance._rootNodeID
    tag = ReactNativeTagHandles.rootNodeIDToTag[rootNodeID]

  else if isType componentOrTag, Number
    tag = componentOrTag
    rootNodeID = ReactNativeTagHandles.tagToRootNodeID[tag]
    assert rootNodeID?, { reason: "Invalid tag!", tag }

  nativeEvent = combine {}, nativeEvent, { target: tag }

  ReactNativeEventEmitter.handleTopLevel topLevelType, rootNodeID, rootNodeID, nativeEvent, tag
