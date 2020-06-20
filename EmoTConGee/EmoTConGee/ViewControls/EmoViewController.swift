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
    
    let toBeSearched = "中国"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swifterAuthenticated.searchTweet(using: toBeSearched, lang: "zh", count: 101, tweetMode: .extended, success: { (results, metaData) in
            print(results)
            print("--------------separator------------------")
            print("Metadata: \(metaData)")
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}



