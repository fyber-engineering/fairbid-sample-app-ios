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

    override func viewDidLoad() {
        super.viewDidLoad()
        adUnitsTable.delegate = self
        adUnitsTable.dataSource = self
        unitNames = ["Interstitial", "Rewarded", "Banner", "", "Test Suite"]
        unitImageNames = ["interstitial_icon", "rewarded_icon", "banner_icon", "" ,"test_suite"]
        adUnitsTable.tableFooterView = (UIView(frame: CGRect.zero))
        adUnitsTable.layer.borderWidth = 1.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ad Cell")! as! HeadlineTableViewCell
        let text = unitNames[indexPath.row]
        let image = UIImage(named: unitImageNames[indexPath.row])
        
        cell.unitLabel?.text = text
        cell.unitLabel.sizeToFit()
        if indexPath.row == 3 {
            cell.unitLabel?.text = ""
            cell.unitImage.image = nil
        } else {
            cell.accessoryType = .disclosureIndicator
            cell.unitImage.image = image
        }
        return cell
    }
    
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
}

