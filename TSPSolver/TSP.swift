//
//  TSP.swift
//  TSPSolver
//
//  Created by IllyasvielVonEinzbern on 5/27/15.
//  Copyright (c) 2015 KazuyaMIURA. All rights reserved.
//

import UIKit


struct Point {
    let x: Double
    let y: Double
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    func description() {
        println("{\(x), \(y)}")
    }

}

struct Node {
    let coordinates: Point
    let number: Int
    init(coordinates: Point, number: Int) {
        self.coordinates = coordinates
        self.number      = number
    }
}

class TSP {
    let cities: [Node]
    let correctAnswer: [Int]
    var answer: Answer = Answer(route: [], distance: 0.0)

    init(fileName: String) {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "tsp")
        let tspTextData = path.flatMap { String(contentsOfFile: $0, encoding: NSUTF8StringEncoding, error: nil) }
        cities = TSP.makeTSPCitiesData(tspTextData)
        let answerDataPath = NSBundle.mainBundle().pathForResource(fileName + ".opt", ofType: "tour")
        let answerTextData = answerDataPath.flatMap { String(contentsOfFile: $0, encoding: NSUTF8StringEncoding, error: nil) }
        correctAnswer = TSP.makeCorrectAnswer(answerTextData)
        answer = Answer(route: correctAnswer, distance: TSPSolver(tsp: self).getDistanceByRoute(correctAnswer))
    }

    class func makeCorrectAnswer(textData: String?) -> [Int] {
        let datas = textData.map { split($0) { contains("\n", $0) } }
        var correctAnswer: [Int] = []
        datas.map { (datas) -> Void in
            for (var i = 0; i < datas.count; i++) {
                let nodeData = split(datas[i]) { contains(" ", $0) }
                if (nodeData[0] as NSString).integerValue == 0 || (nodeData[0] as NSString).integerValue == -1 {continue}
                correctAnswer.append((nodeData[0] as NSString).integerValue)
            }
        }
        correctAnswer.append(correctAnswer[0])
        return correctAnswer
    }

    class func makeTSPCitiesData(textData: String?) -> [Node] {
        let datas = textData.map { split($0) { contains("\n", $0) } }
        var citiesData: [Node] = []
        datas.map { (datas) -> Void in
            for data: String in datas {
                let nodeData = split(data) { contains(" ", $0) }
                if (nodeData[0] as NSString).integerValue == 0 {continue}
                let coordinates = Point(x: (nodeData[1] as NSString).doubleValue, y: (nodeData[2] as NSString).doubleValue)
                citiesData.append(Node(coordinates: coordinates, number: (nodeData[0] as NSString).integerValue))
            }
        }
        return citiesData
    }

}