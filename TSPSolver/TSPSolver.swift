//
//  TSPSolver.swift
//  TSPSolver
//
//  Created by IllyasvielVonEinzbern on 5/27/15.
//  Copyright (c) 2015 KazuyaMIURA. All rights reserved.
//

import Foundation

struct Answer {
    let route: [Int]
    let distance: Double
    init(route: [Int], distance: Double) {
        self.route = route
        self.distance = distance
    }
}

class TSPSolver {
    func solve(question: TSP) -> Answer {
        fatalError("must overwritten")
    }

    func getEuclideanDistance(P: Point, Q: Point) -> Double {
        return sqrt(P.x * Q.x + P.y * Q.y)
    }

}

