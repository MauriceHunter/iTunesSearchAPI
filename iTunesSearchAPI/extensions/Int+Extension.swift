//
//  Int+Extension.swift
//  iTunesSearchAPI
//
//  Created by Sunjay Kalsi on 29/10/2022.
//

import Foundation

extension Int {
    public static func stringToInt(idString: String) -> Int {
        let convertedString = Int(idString)

        if convertedString != nil {
            return convertedString!
        } else {
            return 404
        }
    }
}
