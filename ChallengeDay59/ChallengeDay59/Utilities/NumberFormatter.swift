//
//  NumberFormatter.swift
//  ChallengeDay59
//
//  Created by Claudio Noberto on 15/05/22.
//

import Foundation

extension Int {
    private static var commaFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    internal var commaRepresentation: String {
        return Int.commaFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
