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
}


extension Font {
    static var grosTitre: Font {
        .custom(Polices.MontserratSemiBold, size: 24)
    }
    
    static var titrePage: Font {
        .custom(Polices.MontserratSemiBold, size: 20)
    }
    
    static var information: Font {
        .custom(Polices.MontserratSemiBold, size: 18)
    }
    
    static var corpsImportant: Font {
        .custom(Polices.MontserratSemiBold, size: 15)
    }
    
    static var corps: Font {
        .custom(Polices.MontserratMedium, size: 15)
    }
    
    static var descriptionImportant: Font {
        .custom(Polices.MontserratSemiBold, size: 13)
    }
    
    static var description: Font {
        .custom(Polices.MontserratMedium, size: 13)
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
