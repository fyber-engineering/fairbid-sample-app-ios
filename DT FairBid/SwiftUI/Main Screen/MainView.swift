//
//  MainView.swift
//  DT FairBid
//
//  Created by Stanislav Tomych on 04.12.2023.
//  Copyright © 2023 Fyber. All rights reserved.
//

import FairBidSDK
import SwiftUI

struct MainView: View {
    let section1Data = ["Interstitial", "Rewarded", "Banner", "Mrec"]
    let section2Data = ["Test Suite"]
    let backgroundColor = UIColor(_colorLiteralRed: 246/255, green: 246/255, blue: 247/255, alpha: 1.0)

    var body: some View {
        NavigationView {
            List {
                Section(header: HeaderView()) {
                    ForEach(section1Data, id: \.self) { item in
                        NavigationLink(destination: AdView()) {
                            CustomCell(text: item, imageName: item)
                        }
                    }
                }

                Section(header: Text("")) {
                    ForEach(section2Data, id: \.self) { item in
                        NavigationLink(destination: AdView()) {
                            CustomCell(text: item, imageName: item)
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: backgroundColor))
        }
        .background(Color(uiColor: backgroundColor))
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            HStack(alignment: .center, content: {
                Spacer()
                Text("DT FairBid Sample App")
                    .font(.system(size: 32))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .textCase(nil)
                    .lineLimit(1)
                Spacer()
            })
            HStack(alignment: .center, content: {
                Spacer()
                Text("DT FairBid " + FairBid.version())
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(UIColor.darkGray))
                    .textCase(nil)
                Spacer()
            })
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
    }
}

struct CustomCell: View {
    let text: String
    let imageName: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 50)
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    MainView()
}


/*//
 //
 // Copyright (c) 2019 Fyber. All rights reserved.
 //
 //

 import FairBidSDK
 import UIKit

 class ViewController: UIViewController {

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

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         configure(cell: cell, at: indexPath)
         return cell
     }

     private func configure(cell: UITableViewCell, at indexPath: IndexPath) {
         guard let cell = cell as? HeadlineTableViewCell else { return }

         let text = objectType(at: indexPath)?.rawValue ?? "Test Suite"

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

 */
