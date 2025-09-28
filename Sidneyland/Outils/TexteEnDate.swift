//
//  TexteEnDate.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import Foundation


extension String {
    func convertirTexteEnDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // Format correspondant à l'entrée
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Assure une interprétation cohérente
        dateFormatter.timeZone = TimeZone.current // Ajuste le fuseau horaire si nécessaire
        
        return dateFormatter.date(from: self)
    }
}
