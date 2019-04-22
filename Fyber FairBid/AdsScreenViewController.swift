//
//  AdsScreenViewController.swift
//  Fyber FairBid
//
//  Created by Avi Gelkop on 4/7/19.
//  Copyright © 2019 Fyber. All rights reserved.
//

import UIKit

class AdsScreenViewController: UIViewController, UITableViewDataSource, FYBInterstitialDelegate, FYBRewardedDelegate, FYBBannerDelegate {

    var adType: ObjectTypes!

    private let disabledColor = UIColor(red: 197/255.0, green: 208/255.0, blue: 222/255.0, alpha: 1)
    private let availableColor = UIColor(red: 29/255.0, green: 0/255.0, blue: 71/255.0, alpha: 1)
    
    private let interstitialPlacementID = "InterstitialPlacementIdExample"
    private let rewardedPlacementID = "RewardedPlacementIdExample"
    private let bannerPlacementID = "BannerPlacementIdExample"
    
    let formatter = DateFormatter()

    private var banner : FYBBannerView?

    
    @IBOutlet weak var callBacksTableView: UITableView!

    @IBOutlet weak var unitImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var placmentIdLabel: UILabel!
    @IBOutlet weak var callbackLabel: UILabel!

    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var cleanCallbacksButton: UIButton!

    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var seperator: UIView!

    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    private var callbackStrings: [String] = []


    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "HH:mm:ss"

        FYBInterstitial.delegate = self
        FYBRewarded.delegate = self
        FYBBanner.delegate = self

        callBacksTableView.dataSource = self
        callBacksTableView.tableFooterView = (UIView(frame: CGRect.zero))
        
        title = adType.rawValue
        navigationController?.navigationBar.topItem?.title = ""

        showButton.backgroundColor = disabledColor
        showButton.isEnabled = false
        
        var image = UIImage()
        if adType == ObjectTypes.interstitial {
            bannerView.removeFromSuperview()
            placmentIdLabel.text = interstitialPlacementID
            image = UIImage(named: ObjectTypes.interstitial.rawValue)!
            requestButton.setTitle("Request", for: .normal)
            showButton.setTitle("Show", for: .normal)
            if (FYBInterstitial.isAvailable(interstitialPlacementID)) {
                adIsAvailable()
            }
        } else if adType == ObjectTypes.rewarded {
            bannerView.removeFromSuperview()
            placmentIdLabel.text = rewardedPlacementID
            image = UIImage(named: ObjectTypes.rewarded.rawValue)!
            requestButton.setTitle("Request", for: .normal)
            showButton.setTitle("Show", for: .normal)
            if (FYBRewarded.isAvailable(rewardedPlacementID)) {
                adIsAvailable()
            }
        } else {
            placmentIdLabel.text = bannerPlacementID
            image = UIImage(named: ObjectTypes.banner.rawValue)!
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
    
    // MARK: - Service

    @IBAction func requestAdClicked(_ sender: Any) {
        if adType == ObjectTypes.interstitial {
            FYBInterstitial.request(interstitialPlacementID)
        } else if adType == ObjectTypes.rewarded {
            FYBRewarded.request(rewardedPlacementID)
        } else {
            let bannerOptions = FYBBannerOptions()

            bannerOptions.placementName = bannerPlacementID
            FYBBanner.place(in: bannerView, position: .top, options: bannerOptions)
        }
        fetchingInProgress()
    }
    @IBAction func showOrDestroyAdClicked(_ sender: Any) {
        if adType == ObjectTypes.interstitial {
            FYBInterstitial.show(interstitialPlacementID)
        } else if adType == ObjectTypes.interstitial {
            FYBRewarded.show(rewardedPlacementID)
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
    
    func fetchingInProgress() {
        requestButton.setTitleColor(UIColor.clear, for: .normal)
        requestButton.isEnabled = false
        requestButton.backgroundColor = disabledColor
        activityIndicator.startAnimating()
    }
    
    func adIsAvailable() {
        requestButton.setTitleColor(UIColor.white, for: .normal)
        requestButton.isEnabled = false
        requestButton.backgroundColor = disabledColor
        showButton.isEnabled = true
        showButton.backgroundColor = availableColor
        activityIndicator.stopAnimating()

    }
    
    func adDismissed() {
        requestButton.setTitleColor(UIColor.white, for: .normal)
        requestButton.isEnabled = true
        requestButton.backgroundColor = availableColor
        showButton.isEnabled = false
        showButton.backgroundColor = disabledColor
        activityIndicator.stopAnimating()
    }
    
    func addEventToCallbacksList(_ callback: String) {
        if callback.contains(adType.rawValue.lowercased()) {
            callbackStrings.append(stringFromDate(Date()) + " " + callback)
            callBacksTableView.reloadData()
            scrollToBottom()
            callBacksTableView.isHidden = false
            cleanCallbacksButton.isHidden = false
            callbackLabel.isHidden = false
            seperator.isHidden = false
        }
    }
    
    func stringFromDate(_ date: Date) -> String {
        return formatter.string(from: date)
    }

    func scrollToBottom(){
        let indexPath = IndexPath(row: callbackStrings.count - 1, section: 0)
        self.callBacksTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func currentAdEquals(_ adType: ObjectTypes) -> Bool {
        return self.adType == adType
    }

    // MARK: - FYBInterstitialDelegate

    func interstitialIsAvailable(_ placementName: String) {
        if currentAdEquals(ObjectTypes.interstitial) {
            addEventToCallbacksList(#function)
            adIsAvailable()
        }
    }
    
    func interstitialIsUnavailable(_ placementName: String) {
        if currentAdEquals(ObjectTypes.interstitial) {
            adDismissed()
            addEventToCallbacksList(#function)
        }
    }
    
    func interstitialDidShow(_ placementName: String) {
        if currentAdEquals(ObjectTypes.interstitial) {
            addEventToCallbacksList(#function)
        }
    }
    
    func interstitialDidFail(toShow placementName: String, withError error: Error) {
        if currentAdEquals(ObjectTypes.interstitial) {
            addEventToCallbacksList(#function)
        }
    }
    
    func interstitialDidClick(_ placementName: String) {
        if currentAdEquals(ObjectTypes.interstitial) {
            addEventToCallbacksList(#function)
        }
    }
    
    func interstitialDidDismiss(_ placementName: String) {
        if currentAdEquals(ObjectTypes.interstitial) {
            adDismissed()
            addEventToCallbacksList(#function)
        }
    }
    
    func interstitialWillStartAudio() {
        if currentAdEquals(ObjectTypes.interstitial) {
            addEventToCallbacksList(#function)
        }
    }
    
    func interstitialDidFinishAudio() {
        if currentAdEquals(ObjectTypes.interstitial) {
            addEventToCallbacksList(#function)
        }
    }
    
    // MARK: - FYBRewardedDelegate
    
    func rewardedIsAvailable(_ placementName: String) {
        if currentAdEquals(ObjectTypes.rewarded) {
            adIsAvailable()
            addEventToCallbacksList(#function)
        }
    }
    
    func rewardedIsUnavailable(_ placementName: String) {
        if currentAdEquals(ObjectTypes.rewarded) {
            adDismissed()
            addEventToCallbacksList(#function)
        }
    }
    
    func rewardedDidShow(_ placementName: String) {
        if currentAdEquals(ObjectTypes.rewarded) {
            addEventToCallbacksList(#function)
        }
    }
    
    func rewardedDidFail(toShow placementName: String, withError error: Error) {
        if currentAdEquals(ObjectTypes.rewarded) {
            addEventToCallbacksList(#function)
        }
    }
    
    func rewardedDidClick(_ placementName: String) {
        if currentAdEquals(ObjectTypes.rewarded) {
            addEventToCallbacksList(#function)
        }
    }
    
    func rewardedDidComplete(_ placementName: String, userRewarded: Bool) {
        if currentAdEquals(ObjectTypes.rewarded) {
            addEventToCallbacksList(#function)
        }
    }
    
    func rewardedDidDismiss(_ placementName: String) {
        if currentAdEquals(ObjectTypes.rewarded) {
            adDismissed()
            addEventToCallbacksList(#function)
        }
    }
    
    func rewardedWillStartAudio() {
        if currentAdEquals(ObjectTypes.rewarded) {
            addEventToCallbacksList(#function)
        }
    }
    
    func rewardedDidFinishAudio() {
        if currentAdEquals(ObjectTypes.rewarded) {
            addEventToCallbacksList(#function)
        }
    }
    
    // MARK: - FYBBannerDelegate
    
    func bannerDidLoad(_ banner: FYBBannerView) {
        if currentAdEquals(ObjectTypes.banner) {
            self.banner = banner
            bannerHeight.constant = banner.bounds.height + 20
            adIsAvailable()
            addEventToCallbacksList(#function)
        }
    }
    
    func bannerDidFail(toLoad placementName: String, withError error: Error) {
        if currentAdEquals(ObjectTypes.banner) {
            addEventToCallbacksList(#function)
        }
    }
    
    func bannerDidShow(_ banner: FYBBannerView) {
        if currentAdEquals(ObjectTypes.banner) {
            addEventToCallbacksList(#function)
        }
    }
    
    func bannerDidClick(_ banner: FYBBannerView) {
        if currentAdEquals(ObjectTypes.banner) {
            addEventToCallbacksList(#function)
        }
    }
    
    func bannerWillPresentModalView(_ banner: FYBBannerView) {
        if currentAdEquals(ObjectTypes.banner) {
            addEventToCallbacksList(#function)
        }
    }
    
    func bannerDidDismissModalView(_ banner: FYBBannerView) {
        if currentAdEquals(ObjectTypes.banner) {
            addEventToCallbacksList(#function)
        }
    }
    
    func bannerWillLeaveApplication(_ banner: FYBBannerView) {
        if currentAdEquals(ObjectTypes.banner) {
            addEventToCallbacksList(#function)
        }
    }
    
    func banner(_ banner: FYBBannerView, didResizeToFrame frame: CGRect) {
        if currentAdEquals(ObjectTypes.banner) {
            addEventToCallbacksList(#function)
        }
    }
    
    // MARK: - deinit

    deinit {
//        cleanCallbacksButton.isHidden = true
    }
}
