var Kind, ReactComponent, ReactComponent_Kind, ReactNativeEventEmitter, ReactNativeTagHandles, assert, assertType, combine, isType, ref, registrationNames;

ref = require("type-utils"), assert = ref.assert, assertType = ref.assertType, isType = ref.isType, Kind = ref.Kind;

ReactNativeEventEmitter = require("ReactNativeEventEmitter");

ReactNativeTagHandles = require("ReactNativeTagHandles");

ReactComponent = require("ReactComponent");

combine = require("combine");

registrationNames = ReactNativeEventEmitter.registrationNames;

ReactComponent_Kind = Kind(ReactComponent);

module.exports = function(componentOrTag, registrationName, nativeEvent) {
  var component, rootNodeID, tag, topLevelType;
  assertType(componentOrTag, [ReactComponent_Kind, Number]);
  assertType(registrationName, String);
  assertType(nativeEvent, Object);
  assert(registrationNames[registrationName] != null, {
    reason: "Invalid event name!",
    registrationName: registrationName,
    registrationNames: registrationNames
  });
  topLevelType = registrationName.replace(/^on/, "top");
  if (isType(componentOrTag, ReactComponent_Kind)) {
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
