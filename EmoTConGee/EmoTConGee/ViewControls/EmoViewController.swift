//
//  EmoViewController.swift
//  EmoTConGee
//
//  Created by Jerry Ren on 6/17/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import CoreML
import SwiftyJSON
import UIKit
import SwifteriOS

// not only emo, but scores & maybe animations to make it lovely 
// ranking tables of for instance netflix vs hulu vs amazing prime
// or other omos comparatives

class EmoViewController: UIViewController {

    let swifterAuthenticated = Swifter(consumerKey: GloballyUsed.tweetoDevConsumerKey, consumerSecret: GloballyUsed.tweetoDevConsumerSecret)
    
    let toBeSearched = "中国"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emoTiClassfierTestRun()
        swifterAuthenticated.searchTweet(using: toBeSearched, lang: "zh", count: 101, tweetMode: .extended, success: { (results, metaData) in
            print(results)
            print("--------------separator------------------")
            print("Metadata: \(metaData)")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    let emoTiClassiferObject = EmoTConGeeTweetoClassifier()
    
    private func emoTiClassfierTestRun() {
        let predictionText = try? emoTiClassiferObject.prediction(text: "@Netflix is pretty darn terrible!")
        print(predictionText?.label )
        
    }
}
// perhaps manually append exclamation mark to the end to make it more accurate
