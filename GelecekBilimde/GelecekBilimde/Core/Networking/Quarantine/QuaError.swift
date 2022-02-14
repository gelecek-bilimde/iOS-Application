//
//  QuaError.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 4.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

enum QuaError: Error {
    case authError
    case badRequest
    case outdated
    case failed
    case noData
    case decoding(reason: String?)
}

enum Result<T: Codable> {
    case success(_ response: T)
    case failure(_ type: QuaError)
}
