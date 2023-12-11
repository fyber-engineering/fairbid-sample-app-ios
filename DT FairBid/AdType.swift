//
//
// Copyright (c) 2019 Fyber. All rights reserved.
//
//

import CoreGraphics

enum AdType: String, CaseIterable {
    case interstitial = "Interstitial"
    case rewarded = "Rewarded"
    case banner = "Banner"
    case mrec = "Mrec"

    var placementId: String {
        switch self {
        case .interstitial:
            return "197405"
        case .rewarded:
            return "197406"
        case .banner:
            return "197407"
        case .mrec:
            return "936586"
        }
    }

    var leftButtonText: String {
        switch self {
        case .interstitial:
            return "Request"
        case .rewarded:
            return "Request"
        case .banner:
            return "Show"
        case .mrec:
            return "Show"
        }
    }

    var rightButtonText: String {
        switch self {
        case .interstitial:
            return "Show"
        case .rewarded:
            return "Show"
        case .banner:
            return "Destroy"
        case .mrec:
            return "Destroy"
        }
    }

    var needsBannerView : Bool {
        switch self {
        case .interstitial:
            return false
        case .rewarded:
            return false
        case .banner:
            return true
        case .mrec:
            return true
        }
    }

    var bannerViewHeight : CGFloat {
        switch self {
        case .interstitial:
            return 0.0
        case .rewarded:
            return 0.0
        case .banner:
            return 50.0
        case .mrec:
            return 90.0
        }
    }
}
