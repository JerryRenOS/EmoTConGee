//
//  EmptinessCheq.swift
//  EmoTConGee
//
//  Created by Jerry Ren on 7/2/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import Foundation

extension String {
    func emptinessOrWhiteness() -> Bool { 
        if self.isEmpty {
            return true
        }
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
}                             
