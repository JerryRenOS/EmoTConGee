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
    
    let toBeSearched = "Hulu"
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   emoTiClassfierTestRun()
        self.tweetsOperations()
    }
    
    fileprivate func tweetsOperations() {
        
        swifterAuthenticated.searchTweet(using: toBeSearched, lang: "en", count: 101, tweetMode: .extended, success: { (results, metaData) in

            var tweetsCollectionForAnalysis: Array<EmoTConGeeTweetoClassifierInput> = [EmoTConGeeTweetoClassifierInput]() // intentionally repetitious
            
            
            var tweetsCollectionPlain: Array<String> = []
            // this one for future use (regular parse)
            
            print(results[1]["user"]["friends_count"])
            
            for ind in 0..<2 {
                guard let tweetText = results[ind]["full_text"].string else { return }
                
                let tweetTextInputForClassification = EmoTConGeeTweetoClassifierInput(text: tweetText)
                
                tweetsCollectionForAnalysis.append(tweetTextInputForClassification)
                
                tweetsCollectionPlain.append(tweetText)
                
           //     print(tweetText)
                
            }
            do {
             let emoPredictions = try self.emoTiClassiferObject.predictions(inputs: tweetsCollectionForAnalysis)

                var valenceScore = 0
                
                for emoPredic in emoPredictions {

                    let emoValence = emoPredic.label
                    
                    if emoValence == "Neutral" {
                        valenceScore += 0 // awaits adjustment
                    }
                    if emoValence == "Pos" {
                        valenceScore += 1
                    }
                    if emoValence == "Neg" {
                        valenceScore -= 1
                    }
                //    print(emoValence)
                }
            //    print(valenceScore)
   
            } catch {
                print("Error making predictions on tweetsCollection. Specifics below: \(error)")
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    let emoTiClassiferObject = EmoTConGeeTweetoClassifier()
    
    private func emoTiClassfierTestRun() {
        let predictionText = try? emoTiClassiferObject.prediction(text: "@Netflix is pretty darn amazing!")
        print(predictionText?.label )
        
    }
}
// perhaps manually append exclamation mark to the end to make it more accurate
