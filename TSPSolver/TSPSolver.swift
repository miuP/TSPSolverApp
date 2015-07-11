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

    var adjacencyMat: [[Double]]


    init(tsp: TSP) {
        adjacencyMat = [[]]
        adjacencyMat = makeAdjacencyMatrix(tsp.cities)
    }

    func solve(question: TSP) -> Answer {
        fatalError("must overwritten")
    }

    func getEuclideanDistance(P: Point, Q: Point) -> Double {
        let dx = Q.x - P.x
        let dy = Q.y - P.y
        let dx2 = dx * dx
        let dy2 = dy * dy
        return sqrt(dx2 + dy2)
    }

    final private func makeAdjacencyMatrix(cities: [Node]) -> [[Double]] {
        var adjacencyMat: [[Double]] = []
        for (var i = 0; i < cities.count; i++) {
            var column: [Double] = []
            for (var j = 0; j < cities.count; j++) {
                if i == 0 && j == 0 {println()}
                column.append(getEuclideanDistance(cities[i].coordinates, Q: cities[j].coordinates))
            }
            adjacencyMat.append(column)
        }
        return adjacencyMat
    }

    func improvementAnswerBy2Opt(answer: Answer) -> Answer {
        var improved = true
        let n = answer.route.count - 1

        var newAnswer = answer
        while improved {
            improved = false
            for (var i = 0; i < n - 1; i++) {
                for (var j = i + 1; j < n; j++) {
                    let newDistance = length2Opt(newAnswer, i: i, j: j)
                    if (Int(newDistance * 10000) < Int(newAnswer.distance * 10000)) {
                        println("update:\n\(newAnswer.route) to \n\(swap2Opt(newAnswer, i: i, j: j))")
                        if newAnswer.route != swap2Opt(newAnswer, i: i, j: j) {
                            newAnswer = Answer(route: swap2Opt(newAnswer, i: i, j: j), distance: newDistance)
                            improved = true
                        }
                    }
                }
            }
        }

        return newAnswer
    }

    func length2Opt(answer: Answer, i: Int , j: Int) -> Double {

        var length = answer.distance
        length -= adjacencyMat[answer.route[i] - 1][answer.route[i + 1] - 1]
        length -= adjacencyMat[answer.route[j] - 1][answer.route[j + 1] - 1]
        length += adjacencyMat[answer.route[i] - 1][answer.route[j] - 1]
        length += adjacencyMat[answer.route[i + 1] - 1][answer.route[j + 1] - 1]

        return length
    }

    func swap2Opt(answer: Answer, i: Int, j: Int) -> [Int] {
        var newRoute = Array(count: answer.route.count, repeatedValue: 0)
        var index = 0
        for (var k = 0;     k <= i;                  k++) {newRoute[index++] = answer.route[k]}
        for (var k = j;     k > i;                  k--) {newRoute[index++] = answer.route[k]}
        for (var k = j + 1; k < answer.route.count; k++) {newRoute[index++] = answer.route[k]}
        return newRoute
    }

}

