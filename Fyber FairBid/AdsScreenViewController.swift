//
//  AdsScreenViewController.swift
//  Fyber FairBid
//
//  Created by Avi Gelkop on 4/7/19.
//  Copyright © 2019 Fyber. All rights reserved.
//

import UIKit

class AdsScreenViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    public var adType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.topItem?.title = adType
        // Do any additional setup after loading the view.
    }

}
