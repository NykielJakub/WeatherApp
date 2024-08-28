//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import WeatherApp
import XCTest

final class SearchRegexTests: XCTestCase {
    
    func testValidCityNames() {
        let validCityNames = ["Warszawa", "Kraków", "Gdańsk"]
        validCityNames.forEach { cityName in
            XCTAssertTrue(cityName.matches(regex: String.searchRegex))
        }
    }
    
    func testInvalidCityNames() {
        let invalidCityNames = ["Warsz@wa", "Kraków2", "Lódz!", "123"]
        invalidCityNames.forEach { cityName in
            XCTAssertFalse(cityName.matches(regex: String.searchRegex))
        }
    }
    
}
