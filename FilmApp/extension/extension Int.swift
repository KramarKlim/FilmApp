//
//  extension Int.swift
//  FilmApp
//
//  Created by Клим on 02.09.2021.
//

import Foundation

extension Int {
    func minutesToHoursAndMinutes() -> String {
        return "\(self / 60) h \(self % 60) min"
    }
}
