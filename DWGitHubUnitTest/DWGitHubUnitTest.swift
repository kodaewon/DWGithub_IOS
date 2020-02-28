//
//  DWGitHubUnitTest.swift
//  DWGitHubUnitTest
//
//  Created by 고대원 on 2020/02/25.
//  Copyright © 2020 고대원. All rights reserved.
//

import XCTest

@testable import DWGitHub

class DWGitHubUnitTest: XCTestCase {

    func testSearchBar_search() {
        // given
        let vc = SearchViewController()
        
        // when
        let result = vc.add(a: 1, b: 2)
        
        // then
        XCTAssertEqual(result, 3)
    }
}
