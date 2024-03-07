//
//
// Copyright (c) 2019 Fyber. All rights reserved.
//
//

import FairBidSDK
import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var adUnitsTable: UITableView!
    @IBOutlet var versionLabel: UILabel!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        adUnitsTable.tableFooterView = UIView(frame: .zero)
        titleLabel.text = Constants().title
        versionLabel.text = Constants().subtitle + FairBid.version()
        view.backgroundColor = Constants().backgroundColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

        if let indexPath = adUnitsTable.indexPathForSelectedRow {
            adUnitsTable.deselectRow(at: indexPath, animated: true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return AdType.allCases.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        configure(cell: cell, at: indexPath)
        return cell
    }

    private func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? HeadlineTableViewCell else { return }

        let text = objectType(at: indexPath)?.rawValue ?? Constants().testSuiteTitle

        cell.unitLabel.text = text
        cell.unitImage.image = UIImage(named: text)
    }

    private func objectType(at indexPath: IndexPath) -> AdType? {
        guard indexPath.section == 0 else { return nil }
        return AdType.allCases[indexPath.row]
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return 0
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let adVC = segue.destination as? AdsScreenViewController,
            let indexPath = adUnitsTable.indexPathForSelectedRow {
            adVC.adType = AdType.allCases[indexPath.row]
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "Select Ad", sender: nil)
        } else {
            FairBid.presentTestSuite()
        }
    }

}
