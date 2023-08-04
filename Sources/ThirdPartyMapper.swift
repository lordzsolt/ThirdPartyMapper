//
//  ThirdPartyMapper.swift
//  ThirdPartyMapper
//
//  Created by Zsolt Kovacs on 17.07.23.
//

import UIKit

public typealias ClientWithURL = (client: ThirdPartyMapClient, url: URL)

public final class ThirdPartyMapper {
    public static var allowedClients = ThirdPartyMapClient.allCases

    public static func installedClients(searchQuery: String, isAddress: Bool) -> [ClientWithURL] {
        let clientsSupportingQuery: [ThirdPartyMapClient]

        if isAddress {
            clientsSupportingQuery = Self.allowedClients
        } else {
            clientsSupportingQuery = Self.allowedClients
                .filter { !$0.isAddressOnly }
        }

        let clientsWithURL = clientsSupportingQuery
            .reduce(into: [ClientWithURL]()) { partialResult, client in
                if let url = client.buildURL(query: searchQuery) {
                    partialResult.append((client, url))
                }
            }

        let installedClientsWithURL = clientsWithURL.filter {
            UIApplication.shared.canOpenURL($0.url)
        }

        return installedClientsWithURL
    }
}
