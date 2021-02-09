//
//  TextFieldHandler.swift
//  EmoTConGee
//
//  Created by Jerry Ren on 12/11/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

extension EmoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("didbegin")
        emoTextfield.tintColor = .cyan
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("didend")
    }
}
