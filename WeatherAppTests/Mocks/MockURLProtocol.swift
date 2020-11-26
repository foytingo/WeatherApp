//
//  MockURLProtocol.swift
//  WeatherAppTests
//
//  Created by Murat Baykor on 25.11.2020.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var stubResponse: ((URLRequest) -> (HTTPURLResponse, Data))?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        if let requestError = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: requestError)
        } else {
            guard let handler = MockURLProtocol.stubResponse else { return }
            let (response, data) = handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        }
        
        client?.urlProtocolDidFinishLoading(self)

    }
    
    override func stopLoading() { }
}
