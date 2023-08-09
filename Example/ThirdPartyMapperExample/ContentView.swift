//
//  ContentView.swift
//  ThirdPartyMapperExample
//
//  Created by Zsolt Kovacs on 17.07.23.
//

import SwiftUI
import ThirdPartyMapper

struct ContentView: View {
    private static let appleCampusAddress = "One Apple Park Way, Cupertino, CA 95014, United States"

    @State var isActionSheetShown = false
    @State var isConfirmationDialogShown = false

    var body: some View {
        VStack {
            Button("Apple Campus") {
                isActionSheetShown = true
            }
            .buttonStyle(.bordered)
            .frame(height: 40)

            Button("Apple Campus - UIKit") {
                openMaps()
            }
            .buttonStyle(.bordered)
            .frame(height: 40)

            Button("Cupertino") {
                isConfirmationDialogShown = true
            }
            .buttonStyle(.bordered)
            .frame(height: 40)
        }
        .mapPickerActionSheet(
            searchQuery: Self.appleCampusAddress,
            isExactLocation: true,
            isPresented: $isActionSheetShown)

        .mapPicker(
            searchQuery: "Cupertino",
            isExactLocation: false,
            isPresented: $isConfirmationDialogShown)
    }

    func openMaps() {
        let rootViewController = UIApplication.shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last!
            .rootViewController!

        ThirdPartyMapper.openClientPicker(
            searchQuery: Self.appleCampusAddress,
            isExactLocation: true,
            on: rootViewController)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
