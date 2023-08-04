//
//  ThirdPartyMapperTests.swift
//  ThirdPartyMapperTests
//
//  Created by Zsolt Kovacs on 28.07.23.
//

import XCTest
import ThirdPartyMapper

final class ThirdPartyMapperTests: XCTestCase {
    func test_canChangeAllowedClients() {
        let preferredOrder = [ThirdPartyMapClient.waze, .googleMaps]
        ThirdPartyMapper.allowedClients = preferredOrder
        XCTAssertEqual(ThirdPartyMapper.allowedClients, preferredOrder)
    }
}
