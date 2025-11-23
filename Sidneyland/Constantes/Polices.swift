//
//  Polices.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI


class Polices {
    static let MontserratRegular: String = "MontserratRoman-Regular"
    static let MontserratMedium: String = "MontserratRoman-Medium"
    static let MontserratSemiBold: String = "MontserratRoman-SemiBold"
    static let MontserratBold: String = "MontserratRoman-Bold"
}


extension Font {
    static var grosTitre: Font {
        .custom(Polices.MontserratBold, size: 28)
    }
    
    static var informationImportante: Font {
        .custom(Polices.MontserratBold, size: 24)
    }
    
    static var titreSection: Font {
        .custom(Polices.MontserratSemiBold, size: 18)
    }
    
    static var information: Font {
        .custom(Polices.MontserratSemiBold, size: 18)
    }
    
    static var sousTitre: Font {
        .custom(Polices.MontserratSemiBold, size: 15)
    }
    
    static var corpsImportant: Font {
        .custom(Polices.MontserratSemiBold, size: 15)
    }
    
    static var corps: Font {
        .custom(Polices.MontserratMedium, size: 15)
    }
    
    static var descriptionImportante: Font {
        .custom(Polices.MontserratSemiBold, size: 13)
    }
    
    static var description: Font {
        .custom(Polices.MontserratMedium, size: 13)
    }
    
    static var noteImportante: Font {
        .custom(Polices.MontserratSemiBold, size: 11)
    }
    
    static var note: Font {
        .custom(Polices.MontserratMedium, size: 11)
    }
}

/*
 - MontserratRoman-Regular
 - MontserratItalic-Regular
 - Montserrat-Thin
 - Montserrat-ThinItalic
 - MontserratRoman-ExtraLight
 - MontserratItalic-ExtraLight
 - MontserratRoman-Light
 - MontserratItalic-Light
 - MontserratRoman-Medium
 - MontserratItalic-Medium
 - MontserratRoman-SemiBold
 - MontserratItalic-SemiBold
 - MontserratRoman-Bold
 - MontserratItalic-Bold
 - MontserratRoman-ExtraBold
 - MontserratItalic-ExtraBold
 - MontserratRoman-Black
 - MontserratItalic-Black
 */
