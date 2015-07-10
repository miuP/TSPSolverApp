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

    init(fileName: String) {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
        let tspTextData = path.flatMap { String(contentsOfFile: $0, encoding: NSUTF8StringEncoding, error: nil) }
        cities = TSP.makeTSPCitiesData(tspTextData)
    }

    class func makeTSPCitiesData(textData: String?) -> [Node] {
        let datas = textData.map { split($0) { contains("\n", $0) } }
        var citiesData: [Node] = []
        datas.map { (datas) -> Void in
            for data: String in datas {
                let nodeData = split(data) { contains(",", $0) }
                let coordinates = Point(x: (nodeData[1] as NSString).doubleValue, y: (nodeData[2] as NSString).doubleValue)
                citiesData.append(Node(coordinates: coordinates, number: (nodeData[0] as NSString).integerValue))
            }
        }
        return citiesData
    }

}