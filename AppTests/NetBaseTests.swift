//
//  NetBaseTests.swift
//  网络基础测试类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import XCTest


class NetBaseTests: BaseTests
{
    var expectation: XCTestExpectation!
    let timeOutSeconds: TimeInterval = 300.0
    
    var onSuccess: NetSuccess!
    var onError: NetError!
    var onFailure: NetFailure!
    
    
    override func setUp()
    {
        super.setUp()
        
        expectation = expectation(description: "NetServiceTests expectation")
        
        onSuccess = { [unowned self] data in
            log.info("onSuccess: \(String(describing: data))")
            self.expectation.fulfill()
        }
        onError = { [unowned self] (errorCode, errorMsg) in
            self.expectation.fulfill()
        }
        onFailure = { [unowned self] failureMsg in
            self.expectation.fulfill()
        }
    }
    
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    
    func waitForMe()
    {
        waitForExpectations(timeout: timeOutSeconds) { (error) in
            log.error("expectationWithDescription: \(String(describing: error))")
        }
    }
}
