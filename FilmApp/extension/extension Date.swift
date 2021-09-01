//
//  extension Date.swift
//  FilmApp
//
//  Created by Клим on 01.09.2021.
//

import Foundation

extension String {
    func convertDateFormater() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return  dateFormatter.string(from: date!)
        
    }
}
