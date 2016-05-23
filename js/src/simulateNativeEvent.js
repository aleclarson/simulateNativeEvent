var Kind, ReactComponent, ReactNativeEventEmitter, ReactNativeTagHandles, assert, assertType, combine, isType, registrationNames;

ReactNativeEventEmitter = require("ReactNativeEventEmitter");

ReactNativeTagHandles = require("ReactNativeTagHandles");

ReactComponent = require("ReactComponent");

assertType = require("assertType");

combine = require("combine");

isType = require("isType");

assert = require("assert");

Kind = require("Kind");

registrationNames = ReactNativeEventEmitter.registrationNames;

module.exports = function(componentOrTag, registrationName, nativeEvent) {
  var component, rootNodeID, tag, topLevelType;
  assertType(componentOrTag, [Number, Kind(ReactComponent)]);
  assertType(registrationName, String);
  assertType(nativeEvent, Object);
  assert(registrationNames[registrationName] != null, {
    reason: "Invalid event name!",
    registrationName: registrationName,
    registrationNames: registrationNames
  });
  topLevelType = registrationName.replace(/^on/, "top");
  if (componentOrTag instanceof ReactComponent) {
    component = componentOrTag;
    rootNodeID = component._reactInternalInstance._rootNodeID;
    tag = ReactNativeTagHandles.rootNodeIDToTag[rootNodeID];
  } else if (isType(componentOrTag, Number)) {
    tag = componentOrTag;
    rootNodeID = ReactNativeTagHandles.tagToRootNodeID[tag];
    assert(rootNodeID != null, {
      reason: "Invalid tag!",
      tag: tag
    });
  }
  nativeEvent = combine({}, nativeEvent, {
    target: tag
  });
  return ReactNativeEventEmitter.handleTopLevel(topLevelType, rootNodeID, rootNodeID, nativeEvent, tag);
};

//# sourceMappingURL=../../map/src/simulateNativeEvent.map
