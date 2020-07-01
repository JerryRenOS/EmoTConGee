//
//  CurveItUp.swift
//  EmoTConGee
//
//  Created by Jerry Ren on 7/1/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

extension EmoViewController {
    
    func curveTheButton() {
        guessingButton.layer.cornerRadius = guessingButton.bounds.size.width * 0.2
        guessingButton.clipsToBounds = true
    }
    
    func springItUp(sender: UIButton) {
        let gButton = sender
        let gBounds = gButton.bounds
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 12, options: .curveEaseInOut, animations: {
            gButton.bounds = CGRect(x: gBounds.origin.x - 20, y: gBounds.origin.y, width: gBounds.size.width + 55, height: gBounds.size.height)
        }) { (successful: Bool) in
            if successful {
                gButton.bounds = gBounds
            }
        }
    }
}


