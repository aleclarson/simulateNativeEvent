
{ assert, assertType, isType, Kind } = require "type-utils"

ReactNativeEventEmitter = require "ReactNativeEventEmitter"
ReactNativeTagHandles = require "ReactNativeTagHandles"
ReactComponent = require "ReactComponent"
combine = require "combine"

{ registrationNames } = ReactNativeEventEmitter

ReactComponent_Kind = Kind ReactComponent

module.exports = (componentOrTag, registrationName, nativeEvent) ->

  assertType componentOrTag, [ ReactComponent_Kind, Number ]
  assertType registrationName, String
  assertType nativeEvent, Object

  assert registrationNames[registrationName]?, { reason: "Invalid event name!", registrationName, registrationNames }

  topLevelType = registrationName.replace /^on/, "top"

  if isType componentOrTag, ReactComponent_Kind
    component = componentOrTag
    rootNodeID = component._reactInternalInstance._rootNodeID
    tag = ReactNativeTagHandles.rootNodeIDToTag[rootNodeID]

  else if isType componentOrTag, Number
    tag = componentOrTag
    rootNodeID = ReactNativeTagHandles.tagToRootNodeID[tag]
    assert rootNodeID?, { reason: "Invalid tag!", tag }

  nativeEvent = combine {}, nativeEvent, { target: tag }

  ReactNativeEventEmitter.handleTopLevel topLevelType, rootNodeID, rootNodeID, nativeEvent, tag
