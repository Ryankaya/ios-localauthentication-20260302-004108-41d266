# ios-localauthentication-20260302-004108-41d266

A minimal SwiftUI iOS app that demonstrates **LocalAuthentication**.

## Feature Demonstrated
- Checks authentication availability with `LAContext.canEvaluatePolicy`.
- Prompts for Face ID / Touch ID / passcode using `deviceOwnerAuthentication`.
- Reveals protected content only after successful local authentication.

## Run
1. Open `ios-localauthentication-20260302-004108-41d266.xcodeproj` in Xcode.
2. Run on iOS simulator or device.
3. Tap **Authenticate** and complete the system authentication prompt.

## Apple Documentation
- https://developer.apple.com/documentation/localauthentication
- https://developer.apple.com/documentation/localauthentication/lacontext
- https://developer.apple.com/documentation/localauthentication/lacontext/canevaluatepolicy(_:error:)
