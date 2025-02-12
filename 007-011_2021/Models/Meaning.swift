//
//  Meaning.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 22.11.2021.
//

import Foundation

struct Meaning: Codable {
    // properties
    let partOfSpeech: String?
    let definitions: [Definition]?
}
