//
//  EmoViewController.swift
//  EmoTConGee
//
//  Created by Jerry Ren on 6/17/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit
import SwifteriOS

// not only emo, but scores & maybe animations to make it lovely 

class EmoViewController: UIViewController {

    let swifterAuthenticated = Swifter(consumerKey: GloballyUsed.tweetoDevConsumerKey, consumerSecret: GloballyUsed.tweetoDevConsumerSecret)
    
    let toBeSearched = "@McDonalds"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swifterAuthenticated.searchTweet(using: toBeSearched, success: { (results, metaData) in
            print(results)
            print("--------------separator------------------")
            print("Metadata: \(metaData)")
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

