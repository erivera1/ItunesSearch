//
//  ColorExtension.swift
//  ItunesSearch
//
//  Created by Eliric on 11/13/20.
//

import UIKit

extension UIColor {
    static let mainTextBlue = UIColor.rgb(r: 7, g: 71, b: 89, alpha: 1)
    static let highlightColor = UIColor.rgb(r: 236, g: 31, b: 38, alpha: 0.035)
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, alpha:CGFloat ) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}
