//
//  AdView.swift
//  DT FairBid
//
//  Created by Stanislav Tomych on 04.12.2023.
//  Copyright © 2023 Fyber. All rights reserved.
//

import FairBidSDK
import SwiftUI

struct AdView: View {
    let primaryColor = UIColor(_colorLiteralRed: 29/255, green: 0/255, blue: 71/255, alpha: 1)
    let backgroundColor = UIColor(_colorLiteralRed: 246/255, green: 246/255, blue: 247/255, alpha: 1.0)
    let disabledColor = UIColor(_colorLiteralRed: 197/255.0, green: 208/255.0, blue: 222/255.0, alpha: 1)
    let viewModel = AdViewModel()

    let adType: AdType
    @State private var listItems: [String] = []
    @State private var isRequestLoading: Bool = false
    @Environment(\.presentationMode) var presentationMode

    private var isBottomButtonVisible: Bool {
        return !listItems.isEmpty
    }

    init(adType: AdType) {
        self.adType = adType
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.titleTextAttributes = [.foregroundColor: primaryColor]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
    }

    var body: some View {
        VStack(spacing: -10, content: {
                HStack(spacing: 0, content: {
                    Image(adType.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 50)
                        .padding()
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text("Placement ID")
                            .font(.system(size: 15))
                            .fontWeight(.regular)
                            .foregroundColor(Color(uiColor:UIColor.lightGray))
                        Text(adType.placementId)
                            .font(.system(size: 19))
                            .fontWeight(.regular)
                            .foregroundColor(Color(uiColor:primaryColor))
                    })
                    Spacer()
                })
                HStack {
                    if isRequestLoading {
                        Button(action: {}) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color(uiColor: primaryColor)))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(uiColor: disabledColor))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .accentColor(Color(uiColor: disabledColor))
                        .disabled(isRequestLoading)
                    } else {
                        Button(adType.leftButtonText) {
                            requestAdClicked()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(uiColor: primaryColor))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .accentColor(Color(uiColor: disabledColor))
                        .disabled(isRequestLoading)
                    }

                    Button(adType.rightButtonText) {
                        // Handle Button 2 tap
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isRequestLoading ? Color(uiColor: primaryColor) : Color(uiColor: disabledColor))
                    .background(Color(uiColor: primaryColor))
                    .accentColor(Color(uiColor: disabledColor))
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .font(.system(size: 15))
                    .fontWeight(.regular)
                    .disabled(isRequestLoading)
                }
                .frame(height: 48)
                .padding()
            Spacer()

            List {
                ForEach(listItems, id: \.self) { listItem in
                    Text(listItem)
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.white) // Set the background color of the list

            Spacer()
            if isBottomButtonVisible {
                HStack {
                    Button("Clean callbacks list") {
                        listItems.removeAll()
                    }
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(Color(uiColor: primaryColor))
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .font(.system(size: 15))
                    .fontWeight(.regular)
                }
                .padding()
            }
        })
        .navigationBarTitle(adType.rawValue, displayMode: .inline)
        .toolbarBackground(
                Color(uiColor: backgroundColor),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Image(systemName: "chevron.left")
                .fontWeight(.semibold)
                .foregroundColor(Color(uiColor: primaryColor))
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                })
            .onAppear {
                    // Append items to the list when the view appears
                    listItems.append("Item 1")
                    listItems.append("Item 2")
                    listItems.append("Item 3")
                    // Add more items as needed
            }
    }

    func requestAdClicked() {
        switch adType {
        case .interstitial:
            FYBInterstitial.request(adType.placementId)
        case .rewarded:
            FYBRewarded.request(adType.placementId)
        case .banner:
            break
//            let bannerOptions = FYBBannerOptions(placementId: adType.placementId, size: .smart)
//            FYBBanner.show(in: bannerView, options: bannerOptions)
        case .mrec:
            break
//            let mrecOptions = FYBBannerOptions(placementId: mrecPlacementID, size: .MREC)
//            FYBBanner.show(in: bannerView, options: mrecOptions)
        }

        isRequestLoading = true
    }
}

#Preview {
    AdView(adType: .mrec)
}

class AdViewModel: ObservableObject {
    let delegate = Delegate()


}

class Delegate: NSObject {
}

extension Delegate: FYBInterstitialDelegate {

    func interstitialIsAvailable(_ placementName: String) {
//        addEventToCallbacksList(#function)
//        adIsAvailable()
    }

    func interstitialIsUnavailable(_ placementName: String) {
//        adDismissed()
//        addEventToCallbacksList(#function)
    }

    func interstitialDidShow(_ placementName: String, impressionData: FYBImpressionData) {
//        addEventToCallbacksList(#function)
    }

    func interstitialDidFail(toShow placementId: String, withError error: Error, impressionData: FYBImpressionData) {
//        addEventToCallbacksList(#function)
    }

    func interstitialDidClick(_ placementName: String) {
//        addEventToCallbacksList(#function)
    }

    func interstitialDidDismiss(_ placementName: String) {
//        adDismissed()
//        addEventToCallbacksList(#function)
    }

    func interstitialWillStartAudio() {
//        addEventToCallbacksList(#function)
    }

    func interstitialDidFinishAudio() {
//        addEventToCallbacksList(#function)
    }

}

extension Delegate: FYBRewardedDelegate {

    func rewardedIsAvailable(_ placementName: String) {
//        adIsAvailable()
//        addEventToCallbacksList(#function)
    }

    func rewardedIsUnavailable(_ placementName: String) {
//        adDismissed()
//        addEventToCallbacksList(#function)
    }

    func rewardedDidShow(_ placementName: String, impressionData: FYBImpressionData) {
//        addEventToCallbacksList(#function)
    }

    func rewardedDidFail(toShow placementName: String, withError error: Error) {
//        addEventToCallbacksList(#function)
    }

    func rewardedDidClick(_ placementName: String) {
//        addEventToCallbacksList(#function)
    }

    func rewardedDidComplete(_ placementName: String, userRewarded: Bool) {
//        addEventToCallbacksList(#function)
    }

    func rewardedDidDismiss(_ placementName: String) {
//        adDismissed()
//        addEventToCallbacksList(#function)
    }

    func rewardedWillStartAudio() {
//        addEventToCallbacksList(#function)
    }

    func rewardedDidFinishAudio() {
//        addEventToCallbacksList(#function)
    }

}

extension Delegate: FYBBannerDelegate {

    func bannerDidLoad(_ banner: FYBBannerAdView) {
//        self.banner = banner
//        bannerHeight.constant = banner.bounds.height + 20
//        adIsAvailable()
//        addEventToCallbacksList(#function)
    }

    func bannerDidFail(toLoad placementName: String, withError error: Error) {
//        addEventToCallbacksList(#function)
//        adDismissed()
    }

    func bannerDidShow(_ banner: FYBBannerAdView, impressionData: FYBImpressionData) {
//        addEventToCallbacksList(#function)
    }

    func bannerDidClick(_ banner: FYBBannerAdView) {
//        addEventToCallbacksList(#function)
    }

    func bannerWillPresentModalView(_ banner: FYBBannerAdView) {
//        addEventToCallbacksList(#function)
    }

    func bannerDidDismissModalView(_ banner: FYBBannerAdView) {
//        addEventToCallbacksList(#function)
    }

    func bannerWillLeaveApplication(_ banner: FYBBannerAdView) {
//        addEventToCallbacksList(#function)
    }

    func banner(_ banner: FYBBannerAdView, didResizeToFrame frame: CGRect) {
//        addEventToCallbacksList(#function)
    }
}
