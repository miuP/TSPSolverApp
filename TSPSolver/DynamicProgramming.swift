//
//  DynamicProgramming.swift
//  TSPSolver
//
//  Created by IllyasvielVonEinzbern on 6/18/15.
//  Copyright (c) 2015 KazuyaMIURA. All rights reserved.
//

import UIKit

class DynamicProgramming: TSPSolver {

    func getRoute(f: [[(Double, Int)]], size: Int, start: Int) -> [Int] {
        var route = [start + 1]
        var v = 1 << start
        var p = start
        while route.count < size {
            let (_, q) = f[v][p]
            route.append(q + 1)
            v |= (1 << q)
            p = q
        }
        route.append(1)
        return route
    }


    override func solve() -> Answer {
        let n = tsp.cities.count
        let size = n
        let SMAX = 1 << size
        var f: [[(Double, Int)]] = Array(count: SMAX, repeatedValue: Array(count: size, repeatedValue: (9999.0, 0)))

        for (var i = 1; i < size; i++) {f[(1 << size) - 1][i] = (adjacencyMat[i][0], 0)}

        for (var v = SMAX - 2; v != 0; v--) {
            var tmp: [(Double, Int)] = Array(count: size, repeatedValue: (9999.0, 0))
            for (var i = 0; i < size; i++) {
                if (1 << i) & v == 0 {continue}
                var min = (999999.0, 0)
                for (var j = 0; j < size; j++) {
                    if (1 << j) & v != 0 {continue}
                    if min.0 > adjacencyMat[i][j] + f[v | (1 << j)][j].0 {
                        min = (adjacencyMat[i][j] + f[v | (1 << j)][j].0, j)
                    }
                }
                tmp[i] = min
            }
            f[v] = tmp
        }

        var min = 9999999.9
        var s = 0
        for (var i = 0; i < size; i++) {
            if adjacencyMat[i][0] + f[1 << i][i].0 < min {
                min = adjacencyMat[i][0] + f[1 << i][i].0
                s = i
            }
        }

        let route = getRoute(f, size: size, start: s)
        return Answer(route: getRoute(f, size: size, start: s), distance: getDistanceByRoute(route))
    }



}
