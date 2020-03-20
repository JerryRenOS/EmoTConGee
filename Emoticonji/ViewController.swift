

//  Created by Jerri Ren


import UIKit
import SwiftyiOS
import CoreML
// import SwiftyJSON  //comment this out to run if necessary

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!  // perhaps not necessary
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let emoticonClassyfy = EmotiConjiTweetoClassifier()
    
  // Instantiate using my Twitt-developer's Consumer Key and secret
    
    let swifter = Swifter(consumerKey: "w7xZoWaXcWdTmM2AgC8KipKC0", consumerSecret: "54xea5d0aqbq2uo4RJnCt3INFsIVXBERhpEoUOg88e9hYbOUlE")
    // 牛balacaca //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prediction = try! emoticonClassyfy.prediction(text: "Sarah Lawence kids are uniquely weird")
        // same as playground -
      
      //  print(prediction.label)  // also, exclamation mark makes it more accurate
        
        
        swifter.searchTweet(using: "#blackhole", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
           // 100 -> most amount of tweets I can use at a time without going premium smh // entertaining to play around with tho
            
            
            var tweets = [EmotiConjiTweetoClassifierInput]()
            
            // an array of tweets I pass in
            
            for i in 0..<100 {
                if let tweet = results[i]["full_text"].string {
                    let tweetForCategorization = EmotiConjiTweetoClassifierInput(text: tweet)
                    
                    // turning it into the right data type
                    // (string doesn't work, gotta be model input)
                    tweets.append(tweetForCategorization)
                }
            }
            
            do {
                let predictions = try self.emoticonClassyfy.predictions(inputs: tweets)
                    print(predictions[0].label)
                
                var emojiScore = 0
                
                for predicCollect in predictions {
                    let mood = predicCollect.label
                    
                    if mood == "Pos" {
                        emojiScore += 1
                    }
                    else if mood == "Neg" {
                        
                        emojiScore -= 1
                    }  // neutral case doesn't affect the score
                    
                    }
                    print(emojiScore)
            
            } catch {
                print("There was an error with your prediction buddy, \(error)")
            }
            
        }) { (error) in
            print("There was a mistake with your API Request 哈ha:, \(error)")
            
        }
    }

    @IBAction func predictPressed(_ sender: Any) {
    }
}


//    let prediction = try! emoticonClassyfy.prediction(text: "SLC kids ... !")
// same as playground -
//     print(prediction.label)  // also, exclamation mark makes it more accurate

// import Cocoa
// import CreateML

// let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/jerryren/Desktop/twitter-sanders-apple3.csv"))

// let(trainingData, testingData) = data.randomSplit(by: 0.80, seed: 5)
// randomly taking 80 percent of the data to assign to training, the rest for testing

// let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

// let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)

// let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

// let metadata = MLModelMetadata(author: "Jerry Ren", shortDescription: "A model trained to classify Tweets by emotional valence",version: "1.0")

