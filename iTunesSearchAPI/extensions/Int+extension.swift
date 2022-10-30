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

    public static func intUnwrap(millisecond: Int?) -> Int{
        let videoMilli = millisecond
        if videoMilli != nil {
            return (videoMilli! / 60000)
        } else {
            return 0
        }
    }
}
