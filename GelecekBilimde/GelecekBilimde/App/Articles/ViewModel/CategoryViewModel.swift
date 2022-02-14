//
//  CategoryViewModel.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 6.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

final class CategoryViewModel {
    
    private var categoryList: [ArticleCategory]
    
    init() {
        var list = Category.allCases.map { ArticleCategory(category: $0, page: 1, shouldRetrieve: true) }
        list.removeAll(where: { $0.category == .covid })
        categoryList = list
    }
    
    var count: Int { categoryList.count }
    
    func category(at index: Int) -> ArticleCategory? {
        guard !categoryList.isEmpty, index < categoryList.count else { return nil }
        return categoryList[index]
    }
}
