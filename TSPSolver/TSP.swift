//
//  TSP.swift
//  TSPSolver
//
//  Created by IllyasvielVonEinzbern on 5/27/15.
//  Copyright (c) 2015 KazuyaMIURA. All rights reserved.
//

import UIKit


struct Point {
    let x: Int
    let y: Int
    init(x: Int, y:Int) {
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
    let cities: [Point]

    init(fileName: String) {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
        let tspTextData = path.flatMap { String(contentsOfFile: $0, encoding: NSUTF8StringEncoding, error: nil) }
        cities = TSP.makeTSPCitiesData(tspTextData)
    }

    class func makeTSPCitiesData(textData: String?) -> [Point] {
        let datas = textData.map { split($0) { contains("\n", $0) } }
        var citiesData: [Point] = []
        datas.map { (datas) -> Void in
            for data: String in datas {
                let pointString = split(data) { contains(",", $0) }
                citiesData.append(Point(x: (pointString[0] as NSString).integerValue, y: (pointString[1] as NSString).integerValue))
            }
        }
        return citiesData
    }

}