# Swift Package Manager Installation

To install SophiTracker with SPM:

1. In Xcode, select File > Swift Packages > Add Package Dependency
2. Add the url where to download the library: https://github.com/globeandmail/sophi-sdk-ios-spm


# Usage

```swift

import SophiSDK

let tracker = SophiTracker.shared

let config = SophiTracker.Config(client: "APP_ID",
                                         deviceType: .mobile,
                                         environment: .dev,
                                         appVersion: "1.0",
                                         userID: nil)
        
 tracker?.setUpTracker(config: config)

```

For more information and examples, please refer to the file `Metrics.swift` in SophiTestApp
