//
//  NetServiceTests.swift
//  网络服务测试类
//
//  Created by Sai on 11/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import XCTest


class NetServiceTests: NetBaseTests
{
    func test_getIndexInfo()
    {
        NetService.getIndexInfo(onError: onError, onFailure: onFailure, onSuccess: onSuccess)
        waitForMe()
    }
    
    
    func test_getMovieInfo()
    {
        NetService.getMovieInfo(movieLink: TestData.movie_link, onError: onError, onFailure: onFailure, onSuccess: onSuccess)
        waitForMe()
    }
    
    
    func test_getLinkDetailInfo()
    {
        NetService.getLinkDetailInfo(link: TestData.link, onError: onError, onFailure: onFailure, onSuccess: onSuccess)
        waitForMe()
    }


    func test_getNewMovie()
    {
        NetService.getNewMovie(page: "p1", onError: onError, onFailure: onFailure, onSuccess: onSuccess)
        waitForMe()
    }


    func test_getNewTv()
    {
        NetService.getNewTv(page: "p1", onError: onError, onFailure: onFailure, onSuccess: onSuccess)
        waitForMe()
    }
}
