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
        var f: [[Int]] = [[]]
        let SMAX = 1 << question.cities.count
        let n = question.cities.count

        for (var i = 0; i < n; i++) {
            for (var j = 1; j < SMAX; j++) {
                f[i][j] = 99999
            }
        }

        for (var i = 0; i < n - 1; i++) {
            f[i][1 << i] = getEuclideanDistance(question.cities[n - 1], Q: question.cities[i])
        }

        for (var S = 1; S < SMAX; S++) {
            for (var i = 0; i < n; i++) {
                if ((1 << i) & S) == 0 {continue}
                for (var j = 0; j < n; j++) {
                    if (( 1 << j) & S) == 0 {continue}
                    let tmp = f[i][S] + getEuclideanDistance(question.cities[i], Q: question.cities[j])
                    if (tmp < f[j][S | (1 << j)]) {
                        f[j][S | (1 << j)] = tmp
                    }
                }
            }

        }

        return Answer(route: [], distance: f[n - 1][SMAX - 1])
    }
}
