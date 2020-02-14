//
//  ArticleEndPoint.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 13.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum ArticleAPI {
    case articles(page: Int)
}

extension ArticleAPI: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://www.bilimtreni.com/wp-json/wp/v2/"
        case .qa: return ""
        case .staging: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .articles:
            return "posts"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .articles(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
            urlParameters: ["page":page])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
