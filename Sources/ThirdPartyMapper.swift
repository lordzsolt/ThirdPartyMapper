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

    /// Used to retrieve a list of known map apps, that the user has installed on their phone, along with the URL to open each map app.
    ///
    /// The URL Schemes of the list of clients you would like to query need to be registered in the Info.plist file!
    ///
    /// Using the provided SwiftUI or UIKit helper methods is potentially more convenient.
    ///
    /// - Parameters:
    ///   - searchQuery: The location you would like to open
    ///   - isExactLocation: Pass `true` if this is an exact address, or `false` in case you would like to highlight an area on map.
    /// - Returns: A list of tuples, containing the apps that can handle this specific `searchQuery` that the user has installed on their phone, as well as the URL to open this `searchQuery`.
    public static func installedClients(searchQuery: String, isExactLocation: Bool) -> [ClientWithURL] {
        let clientsSupportingQuery: [ThirdPartyMapClient]

        if isExactLocation {
            clientsSupportingQuery = Self.allowedClients
        } else {
            clientsSupportingQuery = Self.allowedClients
                .filter { !$0.isExactLocationOnly }
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
