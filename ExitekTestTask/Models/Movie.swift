//
//  Movie.swift
//  ExitekTestTask
//
//  Created by Alexandr Mefisto on 31.08.2022.
//

import Foundation
struct Movie: Equatable {
    let title: String
    let year: UInt
    var description: String {
        "\(title) (\(year))"
    }
}
