//
//  Colors++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit

enum Colors {
    case deepLightGray
    case lightGray
    case darkGray
    case defaultGray
    case borderGray
    case blueGreen
    case lightBlueGreen
    case yellow
    case lightBlue
    case lightBlack
}

extension UIColor {
    static func customColor(_ color: Colors) -> UIColor {
        switch color {
        case .deepLightGray: return #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        case .lightGray: return #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        case .darkGray: return #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        case .defaultGray: return #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
        case .borderGray: return #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        case .blueGreen: return #colorLiteral(red: 0, green: 0.7294117647, blue: 0.6823529412, alpha: 1)
        case .lightBlueGreen: return #colorLiteral(red: 0.3143284321, green: 0.8302468061, blue: 0.8082187772, alpha: 1)
        case .yellow: return #colorLiteral(red: 1, green: 0.7803921569, blue: 0.2352941176, alpha: 1)
        case .lightBlue: return #colorLiteral(red: 0.8078431373, green: 0.9568627451, blue: 0.9450980392, alpha: 1)
        case .lightBlack: return #colorLiteral(red: 0.2684496939, green: 0.2684496939, blue: 0.2684496939, alpha: 1)
        }
    }
}

extension CGColor {
    static func customColor(_ color: Colors) -> CGColor {
        switch color {
        case .deepLightGray: return #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1).cgColor
        case .lightGray: return #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1).cgColor
        case .darkGray: return #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1).cgColor
        case .defaultGray: return #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1).cgColor
        case .borderGray: return #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
        case .blueGreen: return #colorLiteral(red: 0, green: 0.7294117647, blue: 0.6823529412, alpha: 1).cgColor
        case .lightBlueGreen: return #colorLiteral(red: 0.3143284321, green: 0.8302468061, blue: 0.8082187772, alpha: 1).cgColor
        case .yellow: return #colorLiteral(red: 1, green: 0.7803921569, blue: 0.2352941176, alpha: 1).cgColor
        case .lightBlue: return #colorLiteral(red: 0.8078431373, green: 0.9568627451, blue: 0.9450980392, alpha: 1).cgColor
        case .lightBlack: return #colorLiteral(red: 0.2684496939, green: 0.2684496939, blue: 0.2684496939, alpha: 1).cgColor
        }
    }
}
