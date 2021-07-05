//
//  Task.swift
//  InnovationAgenda
//
//  Created by André Yamasaki on 04/07/21.
//

import Foundation

struct Task {
    var id = UUID()
    var name: String = ""
    var date = Date()
    var category: Category = Category(name: "Marketing", color: .black)
}
