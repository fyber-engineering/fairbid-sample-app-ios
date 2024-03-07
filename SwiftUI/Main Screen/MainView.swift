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
    let section1Data = [AdType.interstitial.rawValue, AdType.rewarded.rawValue, AdType.banner.rawValue, AdType.mrec.rawValue]
    let section2Data = [Constants().testSuiteTitle]
    let backgroundColor = Constants().backgroundColor

    var body: some View {
        NavigationView {
            List {
                Section(header: HeaderView()) {
                    ForEach(section1Data, id: \.self) { item in
                        NavigationLink(destination: AdView(adType: AdType(rawValue: item) ?? .interstitial)) {
                            CustomCell(text: item, imageName: item)
                        }
                    }
                }

                Section(header: Text("")) {
                    ForEach(section2Data, id: \.self) { item in
                        Button {
                            FairBid.presentTestSuite()
                        } label: {
                            CustomCell(text: item, imageName: item)
                        }
                        .buttonStyle(PlainButtonStyle())
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
                Text(Constants().title)
                    .font(.system(size: 32))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .textCase(nil)
                    .lineLimit(1)
                Spacer()
            })
            HStack(alignment: .center, content: {
                Spacer()
                Text(Constants().subtitle + FairBid.version())
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
