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
    init(x: Double, y:Double) {
        self.x = x
        self.y = y
    }
}

struct Answer {
    let route: [Int]
    let distance: Double
    init(route: [Int], distance: Double) {
        self.route = route
        self.distance = distance
    }
}

class TSP {
    let cities: [Point]

    init(cities: [Point]) {
        self.cities = cities
    }
}