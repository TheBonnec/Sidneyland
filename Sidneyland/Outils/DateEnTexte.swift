//
//  DateEnTexte.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 21/11/2024.
//

import Foundation


extension Date {
    func enHoraire() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH'h'mm" // Format : "HH'h'mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Locale pour éviter les interprétations inattendues
        dateFormatter.timeZone = TimeZone.current // Fuseau horaire actuel
        
        return dateFormatter.string(from: self)
    }
}
