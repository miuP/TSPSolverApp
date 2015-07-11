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

    enum TSPSolverType {
        case DP
        case NN
        case AC
    }

    func solve(question: TSP) -> Answer {
        fatalError("must overwritten")
    }

    func getEuclideanDistance(P: Point, Q: Point) -> Double {
        return sqrt(P.x * Q.x + P.y * Q.y)
    }

    class func d(route: [Int], tsp: TSP) -> Double {
        var d: Double = 0.0
        for (var i = 0; i < count(route) - 1; i++) {
            d = d + TSPSolver().getEuclideanDistance(tsp.cities[route[i] - 1].coordinates, Q: tsp.cities[route[i + 1] - 1].coordinates)
        }
        d = d + TSPSolver().getEuclideanDistance(tsp.cities[route[0] - 1].coordinates, Q: tsp.cities[route[route.count - 1] - 1].coordinates)

        return d
    }

}

