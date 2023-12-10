//
//
// Copyright (c) 2019 Fyber. All rights reserved.
//
//

enum AdType: String, CaseIterable {
    case interstitial = "Interstitial"
    case rewarded = "Rewarded"
    case banner = "Banner"
    case mrec = "Mrec"

    var placementId: String {
        switch self {
        case .interstitial:
            return "213766"//"197405"
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
}
