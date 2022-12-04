//
//  DropDown++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/12/04.
//

import UIKit
import DropDown

extension DropDown {
    
    func configureDropDownAppearance() {
        let dropDownAppearance = DropDown.appearance()
        dropDownAppearance.textColor = .customColor(.lightGray)
        dropDownAppearance.selectedTextColor = .black
        dropDownAppearance.backgroundColor = .white
        dropDownAppearance.selectionBackgroundColor = .customColor(.blueGreen)
            .withAlphaComponent(0.15)
        
    }
    
}
