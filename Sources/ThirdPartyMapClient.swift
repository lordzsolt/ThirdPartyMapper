//
//  ThirdPartyMapClient.swift
//  ThirdPartyMapper
//
//  Created by Zsolt Kovacs on 17.07.23.
//

import Foundation

public enum ThirdPartyMapClient: Hashable, CaseIterable {
    case appleMaps
    case googleMaps
    case waze

    /// The name of the map app
    public var name: String {
        switch self {
        case .appleMaps:
            return "Apple Maps"
        case .googleMaps:
            return "Google Maps"
        case .waze:
            return "Waze"
        }
    }

    /// `true` if this map app supports only exact locations, that the user can navigate to.
    /// `false` if this map app supports vague queries, that are meant to highlight a location on the map.
    public var isExactLocationOnly: Bool {
        switch self {
        case .appleMaps, .googleMaps:
            return false
        case .waze:
            return true
        }
    }

    /// The URL scheme of the map app, that needs to be added to the Info.plist file
    public var urlScheme: String {
        switch self {
        case .appleMaps:
            return "maps"
        case .googleMaps:
            return "comgooglemaps"
        case .waze:
            return "waze"
        }
    }

    /// The scheme of the map app, through which the `searchQuery` is passed
    public var queryScheme: String {
        switch self {
        case .appleMaps, .googleMaps, .waze:
            return "?q="
        }
    }

    /// Attempt to build a URL, that will open the `query` of the map app
    ///
    /// - Parameter query: The location to be opened in the map app
    /// - Returns: The URL that needs to be passed to `UIApplication.shared.open(...)` to open the `query` in the map app
    public func buildURL(query: String) -> URL? {
        let encodedQuery: String
        switch self {
        case .appleMaps, .googleMaps:
            encodedQuery = query.replacingOccurrences(of: " ", with: "+")
        case .waze:
            encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }

        let string = #"\#(urlScheme)://\#(queryScheme)\#(encodedQuery)"#
        let url = URL(string: string)
        return url
    }
}
