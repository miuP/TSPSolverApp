//
//  DynamicProgramming.swift
//  TSPSolver
//
//  Created by IllyasvielVonEinzbern on 6/18/15.
//  Copyright (c) 2015 KazuyaMIURA. All rights reserved.
//

import UIKit

class DynamicProgramming: TSPSolver {

    override func solve(question: TSP) -> Answer {

        var route: [Int] = []

        var f: [[(Double, Int)]] = []

        let SMAX = 1 << question.cities.count
        let n = question.cities.count
        route.append(n)
        for (var i = 0; i < n; i++) {
            route.append(0)
        }

        for (var i = 0; i < n; i++) {
            var column: [(Double, Int)] = [(0, 0)]
            for (var j = 1; j < SMAX; j++) {
                let t = (99999.0, 0)
                column.append(t)
            }
            f.append(column)
        }

        for (var i = 0; i < n - 1; i++) {
            f[i][1 << i] = (getEuclideanDistance(question.cities[n - 1].coordinates, Q: question.cities[i].coordinates), i + 1)
        }

        for (var S = 1; S < SMAX; S++) {
            for (var i = 0; i < n; i++) {
                if ((1 << i) & S) == 0 {continue}
                for (var j = 0; j < n; j++) {
                    if (( 1 << j) & S) != 0 {continue}
                    let tmp = f[i][S].0 + getEuclideanDistance(question.cities[i].coordinates, Q: question.cities[j].coordinates)
                    if (tmp < f[j][(S | (1 << j))].0) {
                        f[j][(S | (1 << j))] = (tmp, j + 1)
                        route[i + 1] = j + 1
                    }
                }
            }

        }
        println(route)
        println(f[n - 1][SMAX - 1])
        return Answer(route: route, distance: f[n - 1][SMAX - 1].0)
    }



}
