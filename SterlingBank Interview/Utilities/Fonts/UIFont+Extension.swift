//
//  UIFont+Extension.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/25/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    convenience init?(font: Fonts, size: CGFloat) {
        let fontIdentifier: String = font.rawValue
        self.init(name: fontIdentifier, size: size)
    }
    
    class func avenir(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir", size: size)
    }
    
    class func avenirBlack(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir-Black", size: size)
    }
    
    class func avenirBlackOblique(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir-BlackOblique", size: size)
    }
    
    class func avenirBook(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir-Book", size: size)
    }
    
    class func avenirHeavy(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir-Heavy", size: size)
    }
    
    class func avenirLight(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir-Light", size: size)
    }
    
    class func avenirMedium(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir-Medium", size: size)
    }
}
