//
//  ViewController.swift
//  Fyber FairBid
//
//  Created by Nikita on 24/03/2019.
//  Copyright © 2019 Fyber. All rights reserved.
//


import UIKit

class HeadlineTableViewCell: UITableViewCell {
    @IBOutlet weak var unitImage: UIImageView!
    @IBOutlet weak var unitLabel: UILabel!
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var adUnitsTable: UITableView!
    private var unitNames: [String] = []
    private var unitImageNames: [String] = []

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        adUnitsTable.delegate = self
        adUnitsTable.dataSource = self
        
        unitNames = ["Interstitial", "Rewarded", "Banner", "", "Test Suite"]
        unitImageNames = ["interstitial_icon", "rewarded_icon", "banner_icon", "" ,"test_suite"]
        
        adUnitsTable.tableFooterView = (UIView(frame: CGRect.zero))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            cell.backgroundColor = self.view.backgroundColor
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 40
        } else {
            return 80
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "select ad") {
            let adVC = segue.destination as! AdsScreenViewController
            var adType = String()

            if let indexPath = adUnitsTable.indexPathForSelectedRow {
                
                switch indexPath.row {
                    case 0:
                        adType = "Interstitial"
                    case 1:
                        adType = "Rewarded"
                    case 2:
                        adType = "Banner"
                    case 4:
                        adType = "Test Suite"
                    default:
                        adType = ""
                }
            }
            adVC.adType = adType
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 4) {
            FairBid.presentTestSuite()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Ad Cell")! as! HeadlineTableViewCell
        let text = unitNames[indexPath.row]
        let image = UIImage(named: unitImageNames[indexPath.row])
        
        cell.unitLabel?.text = text
        cell.unitLabel.sizeToFit()
        if indexPath.row == 3 {
            cell.unitLabel?.text = ""
            cell.unitImage.image = nil
            cell.accessoryType = .none
            cell.isUserInteractionEnabled = false
        } else if indexPath.row == 4 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Test Suite Cell")! as! HeadlineTableViewCell
            cell.unitImage.image = image
        } else {
            cell.unitImage.image = image
        }
        return cell
    }
}

