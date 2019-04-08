//
//  AdsScreenViewController.swift
//  Fyber FairBid
//
//  Created by Avi Gelkop on 4/7/19.
//  Copyright © 2019 Fyber. All rights reserved.
//

import UIKit

class AdsScreenViewController: UIViewController, UITableViewDataSource {
    
    private let disabledColor = UIColor(red: 197/255.0, green: 208/255.0, blue: 222/255.0, alpha: 1)
    public var adType: String!
    private var amountOfCallbacks: Int = 1
    
    @IBOutlet weak var unitImage: UIImageView!
    @IBOutlet weak var placmentIdLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var callBacksTableView: UITableView!
    
    private var unitImageNames: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callBacksTableView.dataSource = self
        callBacksTableView.tableFooterView = (UIView(frame: CGRect.zero))
        var image = UIImage()
        
        self.title = adType
        navigationController?.navigationBar.topItem?.title = ""

        unitImageNames = ["interstitial_icon", "rewarded_icon", "banner_icon"]

        showButton.backgroundColor = disabledColor
        showButton.isEnabled = false

        if adType == "Interstitial" {
            image = UIImage(named: unitImageNames[0])!
            requestButton.setTitle("Request interstitial", for: .normal)
            showButton.setTitle("Show interstitial", for: .normal)
        } else if adType == "Rewarded" {
            image = UIImage(named: unitImageNames[1])!
            requestButton.setTitle("Request rewarded", for: .normal)
            showButton.setTitle("Show rewarded", for: .normal)
        } else {
            image = UIImage(named: unitImageNames[2])!
            requestButton.setTitle("Show banner", for: .normal)
            showButton.setTitle("Destroy banner", for: .normal)
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
    }
    @IBAction func showAdClicked(_ sender: Any) {
    }
    @IBAction func cleanAndHideCallbackList(_ sender: Any) {
    }
}
