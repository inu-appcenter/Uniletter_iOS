//
//  Colors++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit

enum Colors {
    case lightGray
    case darkGray
    case defaultGray
    case blueGreen
    case yellow
    case lightBlue
}

extension UIColor {
    static func customColor(_ color: Colors) -> UIColor {
        switch color {
        case .lightGray: return #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        case .darkGray: return #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        case .defaultGray: return #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
        case .blueGreen: return #colorLiteral(red: 0, green: 0.7294117647, blue: 0.6823529412, alpha: 1)
        case .yellow: return #colorLiteral(red: 1, green: 0.7803921569, blue: 0.2352941176, alpha: 1)
        case .lightBlue: return #colorLiteral(red: 0.8078431373, green: 0.9568627451, blue: 0.9450980392, alpha: 1)
        }
    }
}

extension CGColor {
    static func customColor(_ color: Colors) -> CGColor {
        switch color {
        case .lightGray: return #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1).cgColor
        case .darkGray: return #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1).cgColor
        case .defaultGray: return #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1).cgColor
        case .blueGreen: return #colorLiteral(red: 0, green: 0.7294117647, blue: 0.6823529412, alpha: 1).cgColor
        case .yellow: return #colorLiteral(red: 1, green: 0.7803921569, blue: 0.2352941176, alpha: 1).cgColor
        case .lightBlue: return #colorLiteral(red: 0.8078431373, green: 0.9568627451, blue: 0.9450980392, alpha: 1).cgColor
        }
    }
}
