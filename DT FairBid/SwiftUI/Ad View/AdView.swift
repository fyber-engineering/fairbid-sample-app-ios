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
    @StateObject private var viewModel = AdViewModel(adType: .interstitial)

    let adType: AdType
    @Environment(\.presentationMode) var presentationMode

    private var isBottomButtonVisible: Bool {
        return !viewModel.callbackStrings.isEmpty
    }

    init(adType: AdType) {
        self.adType = adType
        _viewModel = StateObject(wrappedValue: AdViewModel(adType: adType))
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
                    if viewModel.isRequestLoading {
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
                        .disabled(viewModel.isAdAvailable)
                        .disabled(viewModel.isAdAvailable)
                    } else {
                        Button(adType.leftButtonText) {
                            requestAdClicked()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(!viewModel.isAdAvailable ? Color(uiColor: primaryColor) : Color(uiColor: disabledColor))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .accentColor(Color(uiColor: disabledColor))
                        .disabled(viewModel.isAdAvailable)
                    }

                    Button(adType.rightButtonText) {
                        showButtonClicked()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isAdAvailable ? Color(uiColor: primaryColor) : Color(uiColor: disabledColor))
                    .background(Color(uiColor: primaryColor))
                    .accentColor(Color(uiColor: disabledColor))
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .font(.system(size: 15))
                    .fontWeight(.regular)
                    .disabled(!viewModel.isAdAvailable)
                }
                .frame(height: 48)
                .padding()
            Spacer()
            if isBottomButtonVisible {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("CALLBACKS LIST")
                            .font(.system(size: 17))
                            .foregroundColor(Color(uiColor: .lightGray))
                            .frame(height: 53)
                            .padding(.top, 10)
                            .padding(.leading, 16)
                            .padding(.bottom, -5)
                        Spacer()
                    }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(uiColor: .lightGray))

                    List {

                        ForEach(viewModel.callbackStrings, id: \.self) { listItem in
                            Text(listItem)
                        }
                    }
                    .padding(.top, 0)
                    .listStyle(PlainListStyle())
                    .background(Color.white) // Set the background color of the list
                    Spacer()
                }
                HStack {
                    Button("Clean callbacks list") {
                        viewModel.callbackStrings.removeAll()
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
            }
    }

    private func requestAdClicked() {
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

        viewModel.isRequestLoading = true
    }

    private func showButtonClicked() {
        switch adType {
        case .interstitial:
            FYBInterstitial.show(adType.placementId)
        case .rewarded:
            FYBRewarded.show(adType.placementId)
        case .banner:
            break
//            banner?.removeFromSuperview()
//            adDismissed()
        case .mrec:
            break
//            banner?.removeFromSuperview()
//            adDismissed()
        }
    }
}

#Preview {
    AdView(adType: .mrec)
}

final class AdViewModel: NSObject, ObservableObject {
    let adType: AdType
    @Published var isRequestLoading: Bool = false
    @Published var isAdAvailable: Bool = false
    @Published var callbackStrings: [String] = []

    let formatter = DateFormatter()

    init(adType: AdType) {
        self.adType = adType
        super.init()

        formatter.dateFormat = "HH:mm:ss"
        setupDelegates()
    }

    private func setupDelegates() {
        switch adType {
        case .interstitial:
            FYBInterstitial.delegate = self
            if FYBInterstitial.isAvailable(adType.placementId) {
                isAdAvailable = true
            }
        case .rewarded:
            FYBRewarded.delegate = self
            if FYBRewarded.isAvailable(adType.placementId) {
                isAdAvailable = true
            }
        case .banner:
            break
//            FYBBanner.delegate = self
//            placementIdLabel.text = bannerPlacementID
        case .mrec:
            break
//            FYBBanner.delegate = self
//            placementIdLabel.text = mrecPlacementID
        }
    }

    func addEventToCallbacksList(_ callback: String) {
        callbackStrings.append(formatter.string(from: Date()) + " " + callback)
    }
}

extension AdViewModel: FYBInterstitialDelegate {

    func interstitialIsAvailable(_ placementName: String) {
        isRequestLoading = false
        addEventToCallbacksList(#function)
        isAdAvailable = true
    }

    func interstitialIsUnavailable(_ placementName: String) {
        isAdAvailable = false
        isRequestLoading = false
        addEventToCallbacksList(#function)
    }

    func interstitialDidShow(_ placementName: String, impressionData: FYBImpressionData) {
        addEventToCallbacksList(#function)
    }

    func interstitialDidFail(toShow placementId: String, withError error: Error, impressionData: FYBImpressionData) {
        addEventToCallbacksList(#function)
    }

    func interstitialDidClick(_ placementName: String) {
        addEventToCallbacksList(#function)
    }

    func interstitialDidDismiss(_ placementName: String) {
        isAdAvailable = false
        addEventToCallbacksList(#function)
    }

    func interstitialWillStartAudio() {
        addEventToCallbacksList(#function)
    }

    func interstitialDidFinishAudio() {
        addEventToCallbacksList(#function)
    }

}

extension AdViewModel: FYBRewardedDelegate {

    func rewardedIsAvailable(_ placementName: String) {
//        adIsAvailable()
        addEventToCallbacksList(#function)
    }

    func rewardedIsUnavailable(_ placementName: String) {
//        adDismissed()
        addEventToCallbacksList(#function)
    }

    func rewardedDidShow(_ placementName: String, impressionData: FYBImpressionData) {
        addEventToCallbacksList(#function)
    }

    func rewardedDidFail(toShow placementName: String, withError error: Error) {
        addEventToCallbacksList(#function)
    }

    func rewardedDidClick(_ placementName: String) {
        addEventToCallbacksList(#function)
    }

    func rewardedDidComplete(_ placementName: String, userRewarded: Bool) {
        addEventToCallbacksList(#function)
    }

    func rewardedDidDismiss(_ placementName: String) {
//        adDismissed()
        addEventToCallbacksList(#function)
    }

    func rewardedWillStartAudio() {
        addEventToCallbacksList(#function)
    }

    func rewardedDidFinishAudio() {
        addEventToCallbacksList(#function)
    }

}

extension AdViewModel: FYBBannerDelegate {

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
