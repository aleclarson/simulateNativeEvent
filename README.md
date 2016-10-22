
# simulateNativeEvent v1.0.0 [![stable](http://badges.github.io/stability-badges/dist/stable.svg)](http://github.com/badges/stability-badges)

Simulate a native event in [React Native](http://github.com/facebook/react-native).

Tested with **react-native 0.35.0**

```coffee
simulateNativeEvent = require "simulateNativeEvent"

simulateNativeEvent componentOrTag, registrationName, nativeEvent
```

The `componentOrTag` is either an instance of `ReactComponent` or the `Number` returned by `findNodeHandle`.

All available `registrationName`s can be found in `ReactNativeEventEmitter.registrationNames`.

The `nativeEvent` must be an `Object`. It will be passed to the `ResponderSyntheticEvent` constructor.
