//
//  Metrics.swift
//  SophiSDKTestApp
//
//  Created by Carlos Hernández on 6/9/21.
//

import Foundation
import SophiSDK
import UIKit

#if !os(tvOS)
import WebKit
#endif

import SwiftUI

class Metrics: ObservableObject {
    
    static let shared: Metrics = Metrics()
    
    let tracker = SophiTracker.shared
    
    @Published var impressionCounter = 0
    @Published var pageViewUUID: String? = nil
    
    var scrollView: UIScrollView?
    
    #if !os(tvOS)
    var wkWebView: WKWebView?
    #endif
    
    init() {
        #if !os(tvOS)
        let config = SophiTracker.Config(client: "_ID_TEST_APP_4",
                                         deviceType: .mobile,
                                         environment: .dev,
                                         appVersion: "1.0",
                                         userID: nil)
        #else
        let config = SophiTracker.Config(client: "_ID_TEST_TVAPP_4",
                                         deviceType: .tv,
                                         environment: .dev,
                                         appVersion: "1.0",
                                         userID: nil)

        #endif
        
        tracker?.setUpTracker(config: config)
    }
    
    func trackLoginEvent() {
        let accountData = SophiTracker.AccountData(type: .login, action: .signIn)
        let visitorData = SophiTracker.VisitorData(type: .anonymous, userID: "aaa_123")
        
        let loginEvent = SophiTracker.EventData(type: .accountInteraction,
                                                data: [accountData, visitorData])
        
        tracker?.trackEvent(eventData: loginEvent)
    }
    
    func trackLogoutEvent() {
        let accountData = SophiTracker.AccountData(type: .login, action: .signOut)
        let visitorData = SophiTracker.VisitorData(type: .anonymous, userID: "")
        
        let loginEvent = SophiTracker.EventData(type: .accountInteraction,
                                                data: [accountData, visitorData])
        
        tracker?.trackEvent(eventData: loginEvent)
    }
    
    func registrationEvent() {
        
        let accountData = SophiTracker.AccountData(type: .registration, action: .completed)
        let visitorData = SophiTracker.VisitorData(type: .registered, userID: "aaa_123")
        
        let registrationEvent = SophiTracker.EventData(type: .accountInteraction, data: [accountData, visitorData])
        
        tracker?.trackEvent(eventData: registrationEvent)
    }
    
    func trackPageViewPageEvent() {
        let pageData = SophiTracker.PageData(pageType: .section,
                                             url: "www.apple.com",
                                             title: "www_title",
                                             breadcrumb: "article_#",
                                             sectionName: "homes",
                                             keywords: nil)
        
        let contentData = SophiTracker.ContentData(contentType: .image, contentId: "12111111")
        
        let pageViewEvent = SophiTracker.EventData(type: .pageView, data: [pageData, contentData])
        
        tracker?.trackEvent(eventData: pageViewEvent)
        
        pageViewUUID = tracker?.currentPageViewUUID
    }
    
    func trackPageViewArticleEvent() {
        let pageData = SophiTracker.PageData(pageType: .article,
                                             url: "www.apple.com",
                                             title: "www_title",
                                             breadcrumb: "article_#",
                                             sectionName: "homes",
                                             keywords: nil)
        
        let contentData = SophiTracker.ContentData(contentType: .article, contentId: "12111111")
        
        let pageViewEvent = SophiTracker.EventData(type: .pageView, data: [pageData, contentData])
        
        tracker?.trackEvent(eventData: pageViewEvent)
        
        pageViewUUID = tracker?.currentPageViewUUID
    }
    
    func trackLinkImpressionPageEvent() {
        
        impressionCounter += 1
        
        let linkData = SophiTracker.LinkData(type: "link",
                                             targetUrl: "www.sophi.com/test/article/\(impressionCounter)",
                                             contentId: "content_id",
                                             linkText: "This is a test...",
                                             feature: "a_feature",
                                             position: 100,
                                             total: 1000)
        
        let impressionEvent = SophiTracker.EventData(type: .linkImpresion, data: [linkData])
        
        
        tracker?.trackEvent(eventData: impressionEvent)
    }
    
    func trackLinkClickEvent() {
        let linkData = SophiTracker.LinkData(type: "link",
                                             targetUrl: "www.tesla.com/click",
                                             contentId: "content_id",
                                             linkText: "This is a test...",
                                             feature: "a_feature",
                                             position: 100,
                                             total: 1000)
        
        let impressionEvent = SophiTracker.EventData(type: .linkClick, data: [linkData])
        
        
        tracker?.trackEvent(eventData: impressionEvent)
    }
    
    func trackWallEncounterEvent() {
        let wallData = SophiTracker.WallData(type: .paywallHard,
                                             name: "wall name",
                                             isDynamic: true,
                                             meterCount: 2,
                                             meterLimit: 100,
                                             adsVisible: true,
                                             countVisibleParagraphs: 1)
        
        let wallEvent = SophiTracker.EventData(type: .wallHit, data: [wallData])
        tracker?.trackEvent(eventData: wallEvent)
    }
    
    func trackPagePingScrollViewEvent() {
        let pageData = SophiTracker.PageData(pageType: .section,
                                             url: "www.apple.com",
                                             title: "www_title",
                                             breadcrumb: "article_#",
                                             sectionName: "homes",
                                             keywords: nil)
        
        let contentData = SophiTracker.ContentData(contentType: .image, contentId: "12111111")
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        
        scrollView.contentSize = CGSize(width: 200, height: 1000)
        scrollView.contentOffset = CGPoint(x: 0, y: 250)
        
        self.scrollView = scrollView
        
        let pingViewData = SophiTracker.PingData(view: scrollView)
        
        let pageViewEvent = SophiTracker.EventData(type: .pageView, data: [pageData, contentData, pingViewData])
        
        tracker?.trackEvent(eventData: pageViewEvent)
    }
    
    #if !os(tvOS)
    func trackPagePingWebViewEvent() {
        let pageData = SophiTracker.PageData(pageType: .section,
                                             url: "www.apple.com",
                                             title: "www_title",
                                             breadcrumb: "article_#",
                                             sectionName: "homes",
                                             keywords: nil)
        
        let contentData = SophiTracker.ContentData(contentType: .image, contentId: "12111111")
        
        let webview = WKWebView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        
        if let url = URL(string: "www.apple.com") {
            let request = URLRequest(url: url)
            webview.load(request)
        }
        
        self.wkWebView = webview
        
        let pingViewData = SophiTracker.PingData(view: webview)
        
        let pageViewEvent = SophiTracker.EventData(type: .pageView, data: [pageData, contentData, pingViewData])
        
        tracker?.trackEvent(eventData: pageViewEvent)
    }
    #endif
    
    func trackSubscriptionEvent() {
        let subsData = SophiTracker.SubscriptionData(transactionId: "t_id", name: "subs name", subscriptionType: .digital)
        let subsEvent = SophiTracker.EventData(type: .subscription, data: [subsData])
        
        tracker?.trackEvent(eventData: subsEvent)
    }
    
    var mediaData = SophiTracker.MediaData(type: .video,
                                           action: .play,
                                           id: UUID().uuidString,
                                           duration: 60.0,
                                           platform: "vimeo")
    
    func trackVideoPlayEvent() {
        let eventData = SophiTracker.EventData(type: .mediaEvent, data: [mediaData])
        tracker?.trackEvent(eventData: eventData)
    }
    
    
    func trackVideoPauseEvent() {
        var mediaData = self.mediaData
        mediaData.action = .pause
        let eventData = SophiTracker.EventData(type: .mediaEvent, data: [mediaData])
        tracker?.trackEvent(eventData: eventData)
    }
    
    func trackVideoEndEvent() {
        var mediaData = self.mediaData
        mediaData.action = .end
        let eventData = SophiTracker.EventData(type: .mediaEvent, data: [mediaData])
        tracker?.trackEvent(eventData: eventData)
    }
    
    func trackVideoForwardEvent() {
        var mediaData = self.mediaData
        mediaData.action = .forward
        mediaData.timeElapsed = 20.0
        let eventData = SophiTracker.EventData(type: .mediaEvent, data: [mediaData])
        tracker?.trackEvent(eventData: eventData)
    }
    
    func trackVideoRewindEvent() {
        var mediaData = self.mediaData
        mediaData.action = .rewind
        mediaData.timeElapsed = 10.0
        let eventData = SophiTracker.EventData(type: .mediaEvent, data: [mediaData])
        tracker?.trackEvent(eventData: eventData)
    }
    
    func trackChangeVideoIDEvent() {
        mediaData.id = UUID().uuidString
    }
    
    func trackVideoAdLoadEvent() {
        let adData = SophiTracker.AdData(type: .video, action: .load, id: UUID().uuidString, isInView: true)
        let eventData = SophiTracker.EventData(type: .adEvent, data: [adData])
        
        tracker?.trackEvent(eventData: eventData)
    }
    
    func trackVideoAdPlayEvent() {
        let adData = SophiTracker.AdData(type: .video, action: .play, id: UUID().uuidString, isInView: true)
        let eventData = SophiTracker.EventData(type: .adEvent, data: [adData])
        
        tracker?.trackEvent(eventData: eventData)
    }
    
    func trackVideoAdPauseEvent() {
        let adData = SophiTracker.AdData(type: .video, action: .pause, id: UUID().uuidString)
        let eventData = SophiTracker.EventData(type: .adEvent, data: [adData])
        
        tracker?.trackEvent(eventData: eventData)
    }
    
    func trackVideoAdClickEvent() {
        let adData = SophiTracker.AdData(type: .video, action: .click, id: UUID().uuidString)
        let eventData = SophiTracker.EventData(type: .adEvent, data: [adData])
        
        tracker?.trackEvent(eventData: eventData)
    }
    
    func trackAdEndEvent() {
        let adData = SophiTracker.AdData(type: .video, action: .end, id: UUID().uuidString)
        let eventData = SophiTracker.EventData(type: .adEvent, data: [adData])
        
        tracker?.trackEvent(eventData: eventData)
    }
    
    func trackVideoAdSkipEvent() {
        let adData = SophiTracker.AdData(type: .video, action: .skip, id: UUID().uuidString)
        let eventData = SophiTracker.EventData(type: .adEvent, data: [adData])
        
        tracker?.trackEvent(eventData: eventData)
    }
}
