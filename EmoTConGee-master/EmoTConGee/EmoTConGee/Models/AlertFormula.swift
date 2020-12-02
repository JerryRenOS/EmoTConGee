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


// MARS: - Below is work-in-process

extension UIViewController {
    
    public func updatedAlertFormula(title: String?, message: String?, actionTitlesArray: [String?], actionStylesArray: [UIAlertAction.Style]) {
        let alertCon = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
//        let dismissalAction = UIAlertAction(title: actionTitle[0], style: actionStyle[0], handler: nil)
  //      alertCon.addAction(dismissalAction)
        present(alertCon, animated: true, completion: nil)
        print("alert formula called")
    }
        
    struct clickableAlert {
        var backgroundColor: CGColor?
        var titleColor:  UIColor?
    }
}
     
