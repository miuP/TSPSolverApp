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
    let distance: Int
    init(route: [Int], distance: Int) {
        self.route = route
        self.distance = distance
    }
}

class TSPSolver {
    func solve(question: TSP) -> Answer {
        fatalError("must overwritten")
    }

    func getEuclideanDistance(P: Point, Q: Point) -> Int {
        return Int(sqrt(Double(P.x * Q.x + P.y * Q.y)))
    }

}

