//
//  ConvertString.swift
//  Belajar-iOS
//
//  Created by rizki mufrizal on 5/1/17.
//  Copyright © 2017 rizki mufrizal. All rights reserved.
//

import Foundation

class ConvertString {
    func toPlusString(text: String) -> String {
        return text.replacingOccurrences(of: " ", with: "+")
    }

    func fromArrayArtistToString(array: [Artist]) -> String {
        var text = ""
        if array.count == 1 {
            text = array[0].name!
        } else {
            for i in 0..<array.count {
                text = text + array[i].name! + ", "
            }
        }

        if text.substring(from: text.index(text.endIndex, offsetBy: -2)) == ", " {
            text.remove(at: text.index(text.endIndex, offsetBy: -2))
        }

        return text
    }
}
