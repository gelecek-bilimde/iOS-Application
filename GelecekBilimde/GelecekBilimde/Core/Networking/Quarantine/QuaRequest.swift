//
//  QuaRequest.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 3.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

public class QuaRequest {
    
    let method: HTTPMethod
    var components = URLComponents()
    
    public init(method: HTTPMethod = .get, path: String, queryItems: [URLQueryItem]) {
        self.method = method
        createComponents(path: path, queryItems: queryItems)
    }
    
    private func createComponents(path: String, queryItems: [URLQueryItem]) {
        components.scheme = "https"
        components.host = "www.gelecekbilimde.net"
        components.path = "/wp-json/wp/v2/\(path)"
        components.queryItems = queryItems
    }
}
