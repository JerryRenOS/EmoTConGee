import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/jerryren/Desktop/twitter-sanders-apple3.csv"))

let(trainingData, testingData) = data.randomSplit(by: 0.80, seed: 5)
// randomly taking 80 percent of the data to assign to training, the rest for testing

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "Jerry Ren", shortDescription: "A model trained to classify Tweets by emotional valence",version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath:"/Users/jerryren/Desktop/EmotiConjiTweetoClassifier.mlmodel" ))


// test 'em out below //

try sentimentClassifier.prediction(from: "I love Pokemon!")

try sentimentClassifier.prediction(from: "Best Sausage Egg and Cheese I've had this year!")

try sentimentClassifier.prediction(from: "Bates tastes ok")

try sentimentClassifier.prediction(from: "I hate pizza!")

try sentimentClassifier.prediction(from: "@Netflix is an average company~")

try sentimentClassifier.prediction(from: "Justin Bieber sucks!")

try sentimentClassifier.prediction(from: "Sunsets are beautiful!")
