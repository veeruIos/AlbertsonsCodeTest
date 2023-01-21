//
//  URLSessionMock.swift
//  AlbertsonsCodeVeeru
//
//  Created by Suthari, Veerabrahmam on 1/20/23.
//

import Foundation

class URLSessionMock: URLSession {
typealias block = (Data?, URLResponse?, Error?) -> Void
   var data: Data?
   var request: URLRequest?
   var urlResponse: URLResponse?
   var error: Error?
   
   override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
       let data = self.data
       let error = self.error
       self.request = request
       return URLSessionDataTaskMock {
           completionHandler(data,self.urlResponse,error)
       }
   }
}

class  URLSessionDataTaskMock: URLSessionDataTask {
   private let closure: () -> Void
   
   init(closure: @escaping () -> Void) {
       self.closure = closure
   }
   override func resume() {
       closure()
   }
}

