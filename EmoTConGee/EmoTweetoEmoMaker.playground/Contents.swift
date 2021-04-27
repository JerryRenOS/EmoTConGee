import Cocoa
import CreateML

let targetData = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/jerryren/Desktop/EmoTConGeeMaterials/apple-twitter-emo-analysis.csv"))
// this path's highly unstable

let (dataSetForTraining, dataSetForTesting) = targetData.randomSplit(by: 0.80, seed: 5)

let emoClassfier = try MLTextClassifier(trainingData: dataSetForTraining, textColumn: "text", labelColumn: "class")

let evalMetrics = emoClassfier.evaluation(on: dataSetForTesting, textColumn: "text", labelColumn: "class")

let evalAccuracy = 100 * (1.0 - evalMetrics.classificationError)
     
let superMetaData = MLModelMetadata(author: "Jerry Ren", shortDescription: "Intelligent model trained to perform emotional valence dissection", version: "1.0")

// try emoClassfier.write(to: URL(fileURLWithPath: "/Users/jerryren/Desktop/EmoTConGee/EmoTConGeeTweetoClassifier.mlmodel"))
// Writing to path -> fragile and delicate, commenting out this line to ensure secure executions



// MARK: - Try 'em out below

try emoClassfier.prediction(from: "@Apple is a unique company!")
try emoClassfier.prediction(from: "Sunsets are fascinating!")


