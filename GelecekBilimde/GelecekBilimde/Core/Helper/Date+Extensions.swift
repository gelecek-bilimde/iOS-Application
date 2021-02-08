//
//  Date+Extensions.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 7.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

extension Date {
    
    func gbComponent() -> String {
        let calender = Calendar.current
        let dateComponent = calender.dateComponents([.year, .month, .day], from: self)
        return "\(String(describing: dateComponent.day ?? 0))/\(String(describing: dateComponent.month ?? 0))/\(String(describing: dateComponent.year ?? 0))"
    }
    
    func gbAPIComponent() -> [URLQueryItem]? {
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: self) else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return [URLQueryItem(name: "after", value: dateFormatter.string(from: self) + "T00:00:00"),
                URLQueryItem(name: "before", value: dateFormatter.string(from: tomorrow) + "T00:00:00")]
    }
}
