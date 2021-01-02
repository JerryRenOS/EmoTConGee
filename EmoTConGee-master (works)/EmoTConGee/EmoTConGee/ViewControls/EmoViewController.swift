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
    
    private let swifterAuthenticated = Swifter(consumerKey: GloballyUsed.tweetoDevConsumerKey, consumerSecret: GloballyUsed.tweetoDevConsumerSecret)
    
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
        emoTextfield.resignFirstResponder()
    }                                    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emoTextfield.delegate = self
        
 //    emoTiClassfierTestRun()
        self.curveTheButton()
    }
    
    fileprivate func tweetsOperations(with searchText: String) {
        
        swifterAuthenticated.searchTweet(using: searchText, lang: GloballyUsed.langSelection, count: 101, tweetMode: .extended, success: { (results, metaData) in
            
            var tweetsCollectionForAnalysis: Array<EmoTConGeeTweetoClassifierInput> = [EmoTConGeeTweetoClassifierInput]() // intentionally repetitious
            
            var tweetsCollectionPlain: Array<String> = []
            // this one for future use (regular parse)
            
            print(results[97][GloballyUsed.fullText])
            
            for ind in 0..<100 {
                guard let tweetText = results[ind][GloballyUsed.fullText].string else { return }
                
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
            
            emoPredictions.forEach { ome in } //fill this out for next commit
            
            for emoPredic in emoPredictions {
                let emoValence = emoPredic.label
               
                switch emoValence {
                case "Pos":
                    print("pos")
                    valenceScore += 1
                case "Neg":
                    print("neg")
                    valenceScore -= 1
                case "Neutral":
                    print("neutral")
                    valenceScore += 0
                default:
                   ()
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
        let predictionText = try? emoTiClassiferObject.prediction(text: "Frozen Yogurt is pretty darn amazing!")
        print(predictionText?.label )
    }
}
// perhaps manually append exclamation mark to the end to make it more accurate
