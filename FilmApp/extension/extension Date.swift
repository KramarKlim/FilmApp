//
//  extension Date.swift
//  FilmApp
//
//  Created by Клим on 01.09.2021.
//

import Foundation

extension String {
    func convertDateFormater(currentFormat: String, needFromat: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = needFromat
        return  dateFormatter.string(from: date!)
    }
}
