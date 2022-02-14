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
		categoryList = Category.allCases.compactMap { category in
			if category != .covid {
				return ArticleCategory(category: category, page: 1, shouldRetrieve: true)
			}
			return nil
		}
    }
    
    var count: Int { categoryList.count }
    
    func category(at index: Int) -> ArticleCategory? {
        guard !categoryList.isEmpty, index < categoryList.count else { return nil }
        return categoryList[index]
    }
}
