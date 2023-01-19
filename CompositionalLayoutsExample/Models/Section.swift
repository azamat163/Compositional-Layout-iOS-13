//
//  Section.swift
//  CompositionalLayoutsExample
//
//  Created by a.agataev on 21.12.2022.
//

import Foundation
import UIKit

enum Section: Int, CaseIterable, Hashable {
    case company
    case people
    case stories
}

enum SectionItem: Hashable {
    case company([Company])
    case people([People])
    case stories([Stories])
}

struct Company: Hashable {
    let title: String
    let image: UIImage
}

struct People: Hashable {
    let title: String
    let image: UIImage
}

struct Stories: Hashable {
    let title: String
    let image: UIImage
}
