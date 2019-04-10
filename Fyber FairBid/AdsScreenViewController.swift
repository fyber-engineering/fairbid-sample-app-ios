//
//  AdsScreenViewController.swift
//  Fyber FairBid
//
//  Created by Avi Gelkop on 4/7/19.
//  Copyright © 2019 Fyber. All rights reserved.
//

import UIKit

class AdsScreenViewController: UIViewController, UITableViewDataSource, FYBInterstitialDelegate, FYBRewardedDelegate, FYBBannerDelegate {
    
    private let disabledColor = UIColor(red: 197/255.0, green: 208/255.0, blue: 222/255.0, alpha: 1)
    private let availableColor = UIColor(red: 29/255.0, green: 0/255.0, blue: 71/255.0, alpha: 1)
    
    private var banner : FYBBannerView?
    public var adType: String!
    private var amountOfCallbacks: Int = 1
    @IBOutlet weak var unitImage: UIImageView!
    @IBOutlet weak var placmentIdLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var callBacksTableView: UITableView!
    
    private var unitImageNames: [String] = []

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FYBInterstitial.delegate = self
        FYBRewarded.delegate = self
        FYBBanner.delegate = self

        callBacksTableView.dataSource = self
        callBacksTableView.tableFooterView = (UIView(frame: CGRect.zero))
        var image = UIImage()
        
        title = adType
        navigationController?.navigationBar.topItem?.title = ""

        unitImageNames = ["interstitial_icon", "rewarded_icon", "banner_icon"]

        showButton.backgroundColor = disabledColor
        showButton.isEnabled = false

        if adType == "Interstitial" {
            image = UIImage(named: unitImageNames[0])!
            requestButton.setTitle("Request", for: .normal)
            showButton.setTitle("Show", for: .normal)
        } else if adType == "Rewarded" {
            image = UIImage(named: unitImageNames[1])!
            requestButton.setTitle("Request", for: .normal)
            showButton.setTitle("Show", for: .normal)
        } else {
            image = UIImage(named: unitImageNames[2])!
            requestButton.setTitle("Show", for: .normal)
            showButton.setTitle("Destroy", for: .normal)
        }
        
        unitImage.image = image
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amountOfCallbacks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Callback cell")!
        cell.textLabel?.text = "alan"
        return cell
    }
    
    @IBAction func requestAdClicked(_ sender: Any) {
        if adType == "Interstitial" {
            FYBInterstitial.request("InterstitialPlacementIdExample")
        } else if adType == "Rewarded" {
            FYBRewarded.request("RewardedPlacementIdExample")
        } else {
            let bannerOptions = FYBBannerOptions()

            bannerOptions.placementName = "BannerPlacementIdExample"
            FYBBanner.place(in: view, position: .bottom, options: bannerOptions)
        }
        fetchingInProgress()
    }
    @IBAction func showAdClicked(_ sender: Any) {
        if adType == "Interstitial" {
            FYBInterstitial.show("InterstitialPlacementIdExample")
        } else if adType == "Rewarded" {
            FYBRewarded.show("RewardedPlacementIdExample")
        } else {
            banner?.removeFromSuperview()
            adDismissed()
        }
    }
    
    @IBAction func cleanAndHideCallbackList(_ sender: Any) {
    
    }
    
    // MARK: - Service

    func fetchingInProgress() {
        requestButton.isEnabled = false
        requestButton.backgroundColor = disabledColor
    }
    
    func adIsAvailable() {
        requestButton.isEnabled = false
        requestButton.backgroundColor = disabledColor
        showButton.isEnabled = true
        showButton.backgroundColor = availableColor
    }
    
    func adDismissed() {
        requestButton.isEnabled = true
        requestButton.backgroundColor = availableColor
        showButton.isEnabled = false
        showButton.backgroundColor = disabledColor
    }
    
//    addEventToCallbacksList(_ )


    // MARK: - FYBInterstitialDelegate

    func interstitialIsAvailable(_ placementName: String) {
        adIsAvailable()
    }
    
    func interstitialIsUnavailable(_ placementName: String) {
        adDismissed()
    }
    
    func interstitialDidShow(_ placementName: String) {}
    
    func interstitialDidFail(toShow placementName: String, withError error: Error) {}
    
    func interstitialDidClick(_ placementName: String) {}
    
    func interstitialDidDismiss(_ placementName: String) {
        adDismissed()
    }
    
    func interstitialWillStartAudio() {}
    
    func interstitialDidFinishAudio() {}
    
    // MARK: - FYBRewardedDelegate
    
    func rewardedIsAvailable(_ placementName: String) {
        adIsAvailable()
    }
    
    func rewardedIsUnavailable(_ placementName: String) {
        adDismissed()
    }
    
    func rewardedDidShow(_ placementName: String) {}
    
    func rewardedDidFail(toShow placementName: String, withError error: Error) {}
    
    func rewardedDidClick(_ placementName: String) {}
    
    func rewardedDidComplete(_ placementName: String, userRewarded: Bool) {}
    
    func rewardedDidDismiss(_ placementName: String) {
        adDismissed()
    }
    
    func rewardedWillStartAudio() {}
    
    func rewardedDidFinishAudio() {}
    
    // MARK: - FYBBannerDelegate
    
    func bannerDidLoad(_ banner: FYBBannerView) {
        self.banner = banner
        adIsAvailable()
    }
    
    func bannerDidFail(toLoad placementName: String, withError error: Error) {}
    
    func bannerDidShow(_ banner: FYBBannerView) {}
    
    func bannerDidClick(_ banner: FYBBannerView) {}
    
    func bannerWillPresentModalView(_ banner: FYBBannerView) {}
    
    func bannerDidDismissModalView(_ banner: FYBBannerView) {}
    
    func bannerWillLeaveApplication(_ banner: FYBBannerView) {}
    
    func banner(_ banner: FYBBannerView, didResizeToFrame frame: CGRect) {}
}
