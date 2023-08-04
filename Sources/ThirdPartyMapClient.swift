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

    // Supports only specific house addresses
    // Vague queries highlighting an area, such as "Switzerland" are not supported
    public var isAddressOnly: Bool {
        switch self {
        case .appleMaps, .googleMaps:
            return false
        case .waze:
            return true
        }
    }

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

    public var queryScheme: String {
        switch self {
        case .appleMaps, .googleMaps, .waze:
            return "?q="
        }
    }

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
