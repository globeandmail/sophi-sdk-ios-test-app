//
//  ContentView.swift
//  SophiSDKTestApp
//
//  Created by Carlos Hernández on 6/9/21.
//

import SwiftUI

struct TrackButton: Identifiable {
    var title: String
    var action: () -> ()
    var disabled: Bool = true
    var addImpressionCounter: Bool = false
    
    var id: String {
        return title
    }
}

struct ContentView: View {
 let buttons: [TrackButton] = [TrackButton(title: "Login", action: {
        Metrics.shared.trackLoginEvent()
    }, disabled: false),
    TrackButton(title: "Logout", action: {
        Metrics.shared.trackLogoutEvent()
    }, disabled: false),
    TrackButton(title: "Registration", action: {
        Metrics.shared.registrationEvent()
    }, disabled: false),
    TrackButton(title: "PageView (article)", action: {
        Metrics.shared.trackPageViewArticleEvent()
    }, disabled: false),
    TrackButton(title: "PageView (section)", action: {
        Metrics.shared.trackPageViewPageEvent()
    }, disabled: false),
    TrackButton(title: "Page Ping (scrollView)", action: {
        Metrics.shared.trackPagePingScrollViewEvent()
    }, disabled: false),
    TrackButton(title: "Page Ping (web view) ", action: {
        Metrics.shared.trackPagePingWebViewEvent()
    }, disabled: false),
    TrackButton(title: "Link Impression", action: {
        Metrics.shared.trackLinkImpressionPageEvent()
    }, disabled: false, addImpressionCounter: true),
    TrackButton(title: "Link Click", action: {
        Metrics.shared.trackLinkClickEvent()
    }, disabled: false),
    TrackButton(title: "Wall Encounter", action: {
        Metrics.shared.trackWallEncounterEvent()
    }, disabled: false),
    TrackButton(title: "Subscription", action: {
        Metrics.shared.trackSubscriptionEvent()
    }, disabled: false),
    TrackButton(title: "Video (play)", action: {
        Metrics.shared.trackVideoPlayEvent()
    }, disabled: false),
    TrackButton(title: "Video (pause)", action: {
        Metrics.shared.trackVideoPauseEvent()
    }, disabled: false),
    TrackButton(title: "Video (end)", action: {
        Metrics.shared.trackVideoEndEvent()
    }, disabled: false),
    TrackButton(title: "Video (forward)", action: {
        Metrics.shared.trackVideoForwardEvent()
    }, disabled: false),
    TrackButton(title: "Video (rewind)", action: {
        Metrics.shared.trackVideoRewindEvent()
    }, disabled: false),
    TrackButton(title: "Change Video ID", action: {
        Metrics.shared.trackChangeVideoIDEvent()
    }, disabled: false),
    TrackButton(title: "Video Ad (load)", action: {
        Metrics.shared.trackVideoAdLoadEvent()
    }, disabled: false),
    TrackButton(title: "Video Ad (play)", action: {
        Metrics.shared.trackVideoAdPlayEvent()
    }, disabled: false),
    TrackButton(title: "Video Ad (pause)", action: {
        Metrics.shared.trackVideoAdPauseEvent()
    }, disabled: false),
    TrackButton(title: "Video Ad (click)", action: {
        Metrics.shared.trackVideoAdClickEvent()
    }, disabled: false),
    TrackButton(title: "Video Ad (end)", action: {
        Metrics.shared.trackAdEndEvent()
    }, disabled: false),
    TrackButton(title: "Video Ad (skip)", action: {
        Metrics.shared.trackVideoAdSkipEvent()
    }, disabled: false)]
    
    var items: [GridItem] = Array(repeating: .init(.flexible(minimum: 100, maximum: 160), spacing: 10, alignment: .center), count: 2)
    
    @ObservedObject public var metrics: Metrics
    
    var body: some View {
        VStack {
            Label("Sophi Event Tracker Test App", systemImage: "star.fill")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            HStack {
                Label("PageViewUUID = \(metrics.pageViewUUID ?? "Undefined")", systemImage: "number.fill")
                    .font(.system(size: 9))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
            }
        }
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: items, spacing: 10) {
                ForEach(buttons) { button in
                    Button(action: {
                        button.action()
                    }) {
                        Text(button.title + (button.addImpressionCounter ? "(\(metrics.impressionCounter))" : ""))
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: 160, maxHeight: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 12))
                            .padding()
                            .background(button.disabled ? Color.red : Color.blue)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                    }.disabled(button.disabled)
                }
            }
            .padding(.horizontal)
          }
    }
}

struct ContentView_Previews: PreviewProvider {
    //@State static var impressionCounter: Int = 0
    static var previews: some View {
        Group {
            ContentView(metrics: Metrics.shared)
        }
    }
}
