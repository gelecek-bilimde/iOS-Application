//
//  QuaClient.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 3.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

public typealias Handler<T> = ((T) -> Void)
public typealias DoubleHandler<T, U> = ((T, U) -> Void)

public typealias VoidHandler = () -> Void
public typealias BoolHandler = Handler<Bool>
public typealias StringHandler = Handler<String>
public typealias IntHandler = Handler<Int>

protocol QuaClientProtocol {
    func retrieve<T: Codable>(_ request: QuaRequest, completion: @escaping Handler<Result<T>>)
}

public class QuaClient: QuaClientProtocol {
    func retrieve<T: Codable>(_ request: QuaRequest, completion: @escaping Handler<Result<T>>) {
        
        if let url = request.components.url {
            let httpRequest = NSMutableURLRequest(url: url,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 90.0)
            httpRequest.httpMethod = request.method.rawValue
            NetworkLogger.log(request: httpRequest)
            
            let dataTask = session.dataTask(with: httpRequest as URLRequest, completionHandler: { (data, response, error) in
                
                DispatchQueue.main.async {
                    if error != nil {
                        completion(.failure(.failed))
                    }
                    
                    do {
                        if let data = data {
                            let result = try JSONDecoder().decode(T.self, from: data)
                            completion(Result.success(result))
                        } else {
                            completion(Result.failure(.noData))
                        }
                    } catch(let error) {
                        completion(Result.failure(QuaError.decoding(reason: error.localizedDescription)))
                    }
                }
            })
            dataTask.resume()
        } else {
            completion(Result.failure(QuaError.badRequest))
        }
    }
    
    public static let shared = QuaClient()
    private let queue = DispatchQueue(label: "bu.qua.client", qos: .utility, attributes: [.concurrent])
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}
