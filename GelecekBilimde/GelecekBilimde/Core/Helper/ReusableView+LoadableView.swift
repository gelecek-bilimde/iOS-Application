//
//  ReusableView+LoadableView.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 8.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: Self.self)
    }
}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }
}
