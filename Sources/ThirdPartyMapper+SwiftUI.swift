//
//  ThirdPartyMapper+SwiftUI.swift
//  ThirdPartyMapper
//
//  Created by Zsolt Kovacs on 01.08.23.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
    public func mapPickerActionSheet(searchQuery: String, isAddress: Bool, isPresented: Binding<Bool>) -> some View {
        let clientsWithURL = ThirdPartyMapper.installedClients(searchQuery: searchQuery, isAddress: isAddress)

        return self.actionSheet(isPresented: isPresented) {
            let buttons = clientsWithURL.map { (client, url) in
                Alert.Button.default(Text(client.name)) {
                    UIApplication.shared.open(url)
                }
            }

            return ActionSheet(
                title: Text(searchQuery),
                buttons: buttons + [Alert.Button.cancel()]
            )
        }
    }
}

@available(iOS 15.0, *)
extension View {
    public func mapPicker(searchQuery: String, isAddress: Bool, isPresented: Binding<Bool>) -> some View {
        let clientsWithURL = ThirdPartyMapper.installedClients(searchQuery: searchQuery, isAddress: isAddress)

        return self.confirmationDialog("", isPresented: isPresented) {
            ForEach(clientsWithURL, id: \.client) { (client, url) in
                Button(client.name) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}
