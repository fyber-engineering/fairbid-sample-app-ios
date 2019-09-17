//
//
// Copyright (c) 2019 Fyber. All rights reserved.
//
//

import UIKit

class AdsScreenViewController: UIViewController {

    var adType: AdType!

    private let disabledColor = UIColor(red: 197/255.0, green: 208/255.0, blue: 222/255.0, alpha: 1)
    private let availableColor = UIColor(red: 29/255.0, green: 0/255.0, blue: 71/255.0, alpha: 1)

    private let interstitialPlacementID = "197405"
    private let rewardedPlacementID = "197406"
    private let bannerPlacementID = "197407"

    let formatter = DateFormatter()

    private var banner: FYBBannerAdView?
    private var callbackStrings: [String] = []

    // MARK: - Outlets

    @IBOutlet var callBacksTableView: UITableView!

    @IBOutlet var unitImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBOutlet var placementIdLabel: UILabel!
    @IBOutlet var callbackLabel: UILabel!

    @IBOutlet var requestButton: UIButton!
    @IBOutlet var showButton: UIButton!
    @IBOutlet var cleanCallbacksButton: UIButton!

    @IBOutlet var bannerView: UIView!
    @IBOutlet var seperator: UIView!

    @IBOutlet var bannerHeight: NSLayoutConstraint!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        formatter.dateFormat = "HH:mm:ss"

        switch adType! {
        case .interstitial:
            FYBInterstitial.delegate = self
        case .rewarded:
            FYBRewarded.delegate = self
        case .banner:
            FYBBanner.delegate = self
        }

        callBacksTableView.tableFooterView = UIView(frame: .zero)

        title = adType.rawValue
        navigationController?.navigationBar.topItem?.title = ""

        showButton.backgroundColor = disabledColor
        showButton.isEnabled = false

        if adType == AdType.interstitial {
            bannerView.removeFromSuperview()
            placementIdLabel.text = interstitialPlacementID
            requestButton.setTitle("Request", for: .normal)
            showButton.setTitle("Show", for: .normal)
            if FYBInterstitial.isAvailable(interstitialPlacementID) {
                adIsAvailable()
            }
        } else if adType == AdType.rewarded {
            bannerView.removeFromSuperview()
            placementIdLabel.text = rewardedPlacementID
            requestButton.setTitle("Request", for: .normal)
            showButton.setTitle("Show", for: .normal)
            if FYBRewarded.isAvailable(rewardedPlacementID) {
                adIsAvailable()
            }
        } else {
            placementIdLabel.text = bannerPlacementID
            requestButton.setTitle("Show", for: .normal)
            showButton.setTitle("Destroy", for: .normal)
        }

        unitImage.image = UIImage(named: adType.rawValue)!
    }

    // MARK: - Service

    @IBAction func requestAdClicked(_ sender: Any) {
        if adType == AdType.interstitial {
            FYBInterstitial.request(interstitialPlacementID)
        } else if adType == AdType.rewarded {
            FYBRewarded.request(rewardedPlacementID)
        } else {
            let bannerOptions = FYBBannerOptions()

            bannerOptions.placementId = bannerPlacementID as NSString
            FYBBanner.show(in: bannerView, position: .top, options: bannerOptions)
        }
        fetchingInProgress()
    }

    @IBAction func showOrDestroyAdClicked(_ sender: Any) {
        if adType == AdType.interstitial {
            FYBInterstitial.show(interstitialPlacementID)
        } else if adType == AdType.rewarded {
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
        requestButton.setTitleColor(.clear, for: .normal)
        requestButton.isEnabled = false
        requestButton.backgroundColor = disabledColor
        activityIndicator.startAnimating()
    }

    func adIsAvailable() {
        requestButton.setTitleColor(.white, for: .normal)
        requestButton.isEnabled = false
        requestButton.backgroundColor = disabledColor
        showButton.isEnabled = true
        showButton.backgroundColor = availableColor
        activityIndicator.stopAnimating()

    }

    func adDismissed() {
        requestButton.setTitleColor(.white, for: .normal)
        requestButton.isEnabled = true
        requestButton.backgroundColor = availableColor
        showButton.isEnabled = false
        showButton.backgroundColor = disabledColor
        activityIndicator.stopAnimating()
    }

    func addEventToCallbacksList(_ callback: String) {
        guard callback.contains(adType.rawValue.lowercased()) else { return }

        callbackStrings.append(stringFromDate(Date()) + " " + callback)
        callBacksTableView.reloadData()
        scrollToBottom()
        callBacksTableView.isHidden = false
        cleanCallbacksButton.isHidden = false
        callbackLabel.isHidden = false
        seperator.isHidden = false
    }

    func stringFromDate(_ date: Date) -> String {
        return formatter.string(from: date)
    }

    func scrollToBottom() {
        let indexPath = IndexPath(row: callbackStrings.count - 1, section: 0)
        self.callBacksTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

}

extension AdsScreenViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callbackStrings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Callback cell", for: indexPath)
        if indexPath.row < callbackStrings.count {
            cell.textLabel?.text = callbackStrings[indexPath.row]
        }
        return cell
    }

}

extension AdsScreenViewController: FYBInterstitialDelegate {

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

}

extension AdsScreenViewController: FYBRewardedDelegate {

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

}

extension AdsScreenViewController: FYBBannerDelegate {

    func bannerDidLoad(_ banner: FYBBannerAdView) {
        self.banner = banner
        bannerHeight.constant = banner.bounds.height + 20
        adIsAvailable()
        addEventToCallbacksList(#function)
    }

    func bannerDidFail(toLoad placementName: String, withError error: Error) {
        addEventToCallbacksList(#function)
    }

    func bannerDidShow(_ banner: FYBBannerAdView) {
        addEventToCallbacksList(#function)
    }

    func bannerDidClick(_ banner: FYBBannerAdView) {
        addEventToCallbacksList(#function)
    }

    func bannerWillPresentModalView(_ banner: FYBBannerAdView) {
        addEventToCallbacksList(#function)
    }

    func bannerDidDismissModalView(_ banner: FYBBannerAdView) {
        addEventToCallbacksList(#function)
    }

    func bannerWillLeaveApplication(_ banner: FYBBannerAdView) {
        addEventToCallbacksList(#function)
    }

    func banner(_ banner: FYBBannerAdView, didResizeToFrame frame: CGRect) {
        addEventToCallbacksList(#function)
    }

}
