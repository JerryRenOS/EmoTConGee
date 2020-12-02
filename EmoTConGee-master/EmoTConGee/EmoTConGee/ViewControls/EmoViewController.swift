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
// (bouncing, spining, shifting in n' out )
// ranking tables of for instance netflix vs hulu vs amazon prime
// or other omos comparatives
// starbucks vs mcdonalds vs subway vs kfc vs chipotle vs taco bell
// combine 3d sceneKit into this? Aha
// search history & favorites as some of the side bar functionalities

class EmoViewController: UIViewController {
    
    let swifterAuthenticated = Swifter(consumerKey: GloballyUsed.tweetoDevConsumerKey, consumerSecret: GloballyUsed.tweetoDevConsumerSecret)
    
    @IBOutlet weak var emoTextfield: UITextField!
    @IBOutlet weak var emoLabel: UILabel!
    
    @IBOutlet weak var guessingButton: UIButton!
    
    @IBAction func guessingGame(_ sender: UIButton) {
        
        guard let searchEntryText = emoTextfield.text else { return }
        
        if searchEntryText.emptinessOrWhiteness() {
            alertFormula(title: "You haven't typed anything", message: "", action: "let's try again")
        }
        else {
            self.tweetsOperations(with: searchEntryText)
            self.springItUp(sender: sender)
        }
    }                                    
    
    override func viewDidLoad() {
        super.viewDidLoad()
           emoTiClassfierTestRun()
        self.curveTheButton()
    }
    
    fileprivate func tweetsOperations(with searchText: String) {
        
        swifterAuthenticated.searchTweet(using: searchText, lang: "en", count: 101, tweetMode: .extended, success: { (results, metaData) in
            
            var tweetsCollectionForAnalysis: Array<EmoTConGeeTweetoClassifierInput> = [EmoTConGeeTweetoClassifierInput]() // intentionally repetitious
            
            var tweetsCollectionPlain: Array<String> = []
            // this one for future use (regular parse)
            
            print(results[0]["full_text"])
            
            for ind in 0..<100 {
                guard let tweetText = results[ind]["full_text"].string else { return }
                
                let tweetTextInputForClassification = EmoTConGeeTweetoClassifierInput(text: tweetText)
                
                tweetsCollectionForAnalysis.append(tweetTextInputForClassification)
                
                tweetsCollectionPlain.append(tweetText)
            }
            
            self.doCatchPredict(with: tweetsCollectionForAnalysis)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private func doCatchPredict(with tweetsCollectionToBeAnalyzed: [EmoTConGeeTweetoClassifierInput]) {
        
        do {
            let emoPredictions = try self.emoTiClassiferObject.predictions(inputs: tweetsCollectionToBeAnalyzed)
            
            var valenceScore = 0
            
            for emoPredic in emoPredictions {
                
                let emoValence = emoPredic.label
                
//                if emoValence == "Neutral" {
//                    valenceScore += 0 // awaits adjustment
//                }
//                if emoValence == "Pos" {
//                    valenceScore += 1
//                }
//                if emoValence == "Neg" {
//                    valenceScore -= 1
//                }
                
                switch emoValence {
                case "Neutral":
                    valenceScore += 0
                case "Pos":
                    valenceScore += 1
                case "Neg":
                    valenceScore -= 1
                default:
                    break  // MARK: - (re-inspect the switch cases)
                }
            }
            print(valenceScore)
            
            self.uiRefresher(with: valenceScore)
            
        } catch {
            print("Error making predictions on tweetsCollection. Specifics below: \(error)")
        }
    }
    
    private func uiRefresher(with viScore: Int) {
        
        if viScore < -12 {
            self.emoLabel.text = "🤕"
        } else if viScore < -4 {
            self.emoLabel.text = "🤒"
        } else if viScore <= 4 {
            self.emoLabel.text = "😶"
        } else if viScore <= 12 {
            self.emoLabel.text = "🤨"
        } else {
            self.emoLabel.text = "🙃"
        }
    }
    
    let emoTiClassiferObject = EmoTConGeeTweetoClassifier()
    
    private func emoTiClassfierTestRun() {
        let predictionText = try? emoTiClassiferObject.prediction(text: "@Netflix is pretty darn amazing!")
        print(predictionText?.label )
    }
}
// perhaps manually append exclamation mark to the end to make it more accurate
