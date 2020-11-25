//
//  MockURLProtocol.swift
//  WeatherAppTests
//
//  Created by Murat Baykor on 25.11.2020.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var stubResponse: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    
    
    override func startLoading() {
        guard let handler = MockURLProtocol.stubResponse else { return }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() { }
}
