//
//  QuaResponse.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 3.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

protocol QuaResponse {
    func retrieve<T: Codable>(_ request: QuaRequest, completion: @escaping Handler<Result<T?>>)
}

extension QuaResponse {
    func retrieve<T: Codable>(_ request: QuaRequest, completion: @escaping Handler<Result<T?>>) {
        QuaClient.shared.retrieve(request) { (result) in
            completion(result)
        }
    }
}
