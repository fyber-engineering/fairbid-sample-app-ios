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
    @IBOutlet weak var unitImage: UIImageView!
    @IBOutlet weak var placmentIdLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var callBacksTableView: UITableView!
    @IBOutlet weak var cleanCallbacksButton: UIButton!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var callbackLabel: UILabel!
    @IBOutlet weak var seperator: UIView!
    
    private var unitImageNames: [String] = []
    private var callbackStrings: [String] = []


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
            if (FYBInterstitial.isAvailable("InterstitialPlacementIdExample")) {
                adIsAvailable()
            }
            bannerView.removeFromSuperview()
        } else if adType == "Rewarded" {
            image = UIImage(named: unitImageNames[1])!
            requestButton.setTitle("Request", for: .normal)
            showButton.setTitle("Show", for: .normal)
            if (FYBRewarded.isAvailable("InterstitialPlacementIdExample")) {
                adIsAvailable()
            }
        } else {
            image = UIImage(named: unitImageNames[2])!
            requestButton.setTitle("Show", for: .normal)
            showButton.setTitle("Destroy", for: .normal)
        }
        
        unitImage.image = image
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callbackStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Callback cell")!
        if (callbackStrings.count > indexPath.row) {
            cell.textLabel?.text = callbackStrings[indexPath.row]
        }
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
            FYBBanner.place(in: bannerView, position: .top, options: bannerOptions)
        }
        fetchingInProgress()
    }
    @IBAction func showOrDestroyAdClicked(_ sender: Any) {
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
        callbackStrings = []
        callBacksTableView.reloadData()
        callBacksTableView.isHidden = true
        cleanCallbacksButton.isHidden = true
        callbackLabel.isHidden = true
        seperator.isHidden = true
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
    
    func addEventToCallbacksList(_ callback: String) {
        callbackStrings.append(stringFromDate(Date()) + " " + callback)
        callBacksTableView.reloadData()
        scrollToBottom()
        callBacksTableView.isHidden = false
        cleanCallbacksButton.isHidden = false
        callbackLabel.isHidden = false
        seperator.isHidden = false

    }
    
    func stringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }

    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.callbackStrings.count-1, section: 0)
            self.callBacksTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    // MARK: - FYBInterstitialDelegate

    func interstitialIsAvailable(_ placementName: String) {
        addEventToCallbacksList(#function)
        adIsAvailable()
    }
    
    func interstitialIsUnavailable(_ placementName: String) {
        adDismissed()
        addEventToCallbacksList(#function)
    }
    
    func interstitialDidShow(_ placementName: String) {
        addEventToCallbacksList(#function)
    }
    
    func interstitialDidFail(toShow placementName: String, withError error: Error) {
        addEventToCallbacksList(#function)
    }
    
    func interstitialDidClick(_ placementName: String) {
        addEventToCallbacksList(#function)
    }
    
    func interstitialDidDismiss(_ placementName: String) {
        adDismissed()
        addEventToCallbacksList(#function)
    }
    
    func interstitialWillStartAudio() {
        addEventToCallbacksList(#function)
    }
    
    func interstitialDidFinishAudio() {
        addEventToCallbacksList(#function)
    }
    
    // MARK: - FYBRewardedDelegate
    
    func rewardedIsAvailable(_ placementName: String) {
        adIsAvailable()
        addEventToCallbacksList(#function)
    }
    
    func rewardedIsUnavailable(_ placementName: String) {
        adDismissed()
        addEventToCallbacksList(#function)
    }
    
    func rewardedDidShow(_ placementName: String) {
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
        adDismissed()
        addEventToCallbacksList(#function)
    }
    
    func rewardedWillStartAudio() {
        addEventToCallbacksList(#function)
    }
    
    func rewardedDidFinishAudio() {
        addEventToCallbacksList(#function)
    }
    
    // MARK: - FYBBannerDelegate
    
    func bannerDidLoad(_ banner: FYBBannerView) {
        self.banner = banner
        adIsAvailable()
        addEventToCallbacksList(#function)
    }
    
    func bannerDidFail(toLoad placementName: String, withError error: Error) {
        addEventToCallbacksList(#function)
    }
    
    func bannerDidShow(_ banner: FYBBannerView) {
        addEventToCallbacksList(#function)
    }
    
    func bannerDidClick(_ banner: FYBBannerView) {
        addEventToCallbacksList(#function)
    }
    
    func bannerWillPresentModalView(_ banner: FYBBannerView) {
        addEventToCallbacksList(#function)
    }
    
    func bannerDidDismissModalView(_ banner: FYBBannerView) {
        addEventToCallbacksList(#function)
    }
    
    func bannerWillLeaveApplication(_ banner: FYBBannerView) {
        addEventToCallbacksList(#function)
    }
    
    func banner(_ banner: FYBBannerView, didResizeToFrame frame: CGRect) {
        addEventToCallbacksList(#function)
    }
    
    // MARK: - deinit

    deinit {
//        cleanCallbacksButton.isHidden = true
    }
}
