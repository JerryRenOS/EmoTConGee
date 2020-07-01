//
//  AlertFormula.swift
//  EmoTConGee
//
//  Created by Jerry Ren on 6/30/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alertFormula(title: String?, message: String?, action: String?) {
        let alertCon = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissalAction = UIAlertAction(title: action, style: .cancel, handler: nil)
        alertCon.addAction(dismissalAction)
        present(alertCon, animated: true, completion: nil)
    }
}
