# ios-sdk-integration

# Using the Test App

1. Clone the main branch: git clone git@github.com:poplindata/ios-sdk-integration.git
2. Run Xcode
3. 'Open a project or file' and select the following workspace: SophiSDKTracker.xcworkspace
4. Select the Sophi Test App Scheme (Top left) (or from the Menu: Product > Scheme > SophiTestApp)
5. Hit 'Play' to build and run the test application.
6. Select the device you want to run the test app, could be a simulator or a device connected to your computer
7. Press the Play button
8. The app will show with a list of events
9. Select the event you wish to test

Events in red are still being tested.

# Creating XCFramework for SPM

1. Archive Application
2. Open Menu -> Window -> Organizer
3. Select lates build
4. Click on "Distribure Content", top right
5. Select Archive(Exports file)
6. Select Destination Folder
7. Open terminal
8. Run: xcodebuild -create-xcframework -framework ~/path/to/SophiSDK.framework -output SophiSDK.xcframework
9. Copy xcframework file to SPM repository

# Swift Package Manager Installation

To install SophiTracker with SPM:

1. In Xcode, select File > Swift Packages > Add Package Dependency
2. Add the url where to download the library: https://github.com/poplindata/ios-tracker-spm


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


# Updating the Snowplow SDK

To update the Snowplow SDK, we will need to direclty change the version number defined in the SPM repository.

https://github.com/poplindata/ios-tracker-spm/blob/main/Package.swift

The `package.swift` file definsd the Snowplow SDK dependency.

Please update the following line:

```.package(name: "SnowplowTracker", url: "https://github.com/snowplow/snowplow-objc-tracker", from: "2.2.0")```

Change the version number from 2.2.0 to the new desired version. 

After commiting the changes with the new version number, pull the Sophi Tracker SDK from your project to update to the latest Snowplow SDK.

To force an update in your project, follow the following steps:

1. Open the workspace that includes the Sophi Tracker SDK
2. Go to the project pane, look for `Swift Packaga Dependencies` 
3. Right click the Sophi Tracker SDK
4. Select the `update` option


Xcode will now pull the latest from the SophiTracker SDK


# Provisioning an Apple TV to run the test app

1. On your Apple TV, go to Settings/Remote and Devices/Remote App and Devices(iOS 14). For previous versions, Settings/Remote App and Devices
2. On your Mac, open Xcode, and go to Windows/Devices and Simulators
3. Your Apple TV device will appear in the list of devices
4. Select the device, and then tap connect
5. A six digit code will appear on your TV. Please enter the verification code in Xcode
6. Select the SophiAppleTVApp on the top left scheme selection option
7. Select the Apple TV device just added to the list of devices



