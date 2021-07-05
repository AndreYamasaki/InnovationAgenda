//
//  CategoryRepository.swift
//  InnovationAgenda
//
//  Created by André Yamasaki on 05/07/21.
//

import Foundation
import UIKit

class CategoryRepository {
    
    static func getCategories() -> [Category] {
        let categories = [
            Category(id: UUID(), name: "Work", color: .green),
            Category(id: UUID(), name: "Studies", color: .blue),
            Category(id: UUID(), name: "To dos", color: .yellow),
            Category(id: UUID(), name: "Reminders", color: .red)
        ]
        
        return categories
    }
}
