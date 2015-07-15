//
//  NearestNeighbor.swift
//  TSPSolver
//
//  Created by IllyasvielVonEinzbern on 7/11/15.
//  Copyright (c) 2015 KazuyaMIURA. All rights reserved.
//

import UIKit

class NearestNeighbor: TSPSolver {
    override func solve(question: TSP) -> Answer {
        let n = question.cities.count
        var route: [Int] = Array(count: n, repeatedValue: 0)
        var visited: [Bool] = Array(count: n, repeatedValue: false)
        
        let start = Int(arc4random_uniform(UInt32(n - 1))) + 1
        visited[start] = true
        route[0] = start + 1
        var distance: Double = 0.0
        var from = start
        for (var i = 1; i < n; i++) {
            let to = searchNotVisetedNearest(from, visited: visited, adjacencyMat: adjacencyMat)
            distance += adjacencyMat[from][to]
            route[i] = to + 1
            visited[to] = true
            from = to
        }
        distance += adjacencyMat[from][start]
        route.append(start + 1)
        return improvementAnswerBy2Opt(Answer(route: route, distance: distance))
    }

    private func searchNotVisetedNearest(from: Int, visited: [Bool], adjacencyMat:[[Double]]) -> Int {
        var nearest = 0
        var nearestDis = 99999999.9
        for (var i = 0; i < visited.count; i++) {
            if visited[i] || i == from {continue}
            if nearestDis > adjacencyMat[from][i] {
                nearestDis = adjacencyMat[from][i]
                nearest = i
            }
        }
        return nearest
    }

}
