//
//  Countries.swift
//  ChallengeDay59
//
//  Created by Claudio Noberto on 07/05/22.
//

import Foundation

struct Countries: Codable {
    let name: Name
    let flags: Flags
    let capital: [String]?
    let population: Int
    let region: String
    let subregion: String?
}

struct Name: Codable {
    let common: String
}

struct Flags: Codable {
    let png: String
}

