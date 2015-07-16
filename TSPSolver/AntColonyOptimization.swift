//
//  AntColonyOptimization.swift
//  TSPSolver
//
//  Created by IllyasvielVonEinzbern on 7/11/15.
//  Copyright (c) 2015 KazuyaMIURA. All rights reserved.
//

import UIKit


class Ant {

    var initialCity: Int, fields: Field, alpha: Double, beta: Double, nextCity: Int, curCity: Int, tourLen: Double, route: [Int]
    
    init (initialCity: Int, fields: Field, alpha: Double, beta: Double) {
        self.initialCity = initialCity
        self.fields      = fields
        self.alpha       = alpha
        self.beta        = beta
        self.nextCity    = -1
        self.curCity     = initialCity
        self.tourLen     = 0.0
        self.route       = Array(count: fields.cities.count, repeatedValue: 0)
        beforeRun()

    }

    func beforeRun() {
        nextCity = -1
        curCity  = initialCity
        tourLen  = 0.0
        route    = []
    }

    func run() -> [Int] {
        beforeRun()
        var availableCities = self.fields.cities
        availableCities = removeObject(availableCities, index: initialCity)

        while availableCities.count != 0 {
            nextCity = selectNextCity(availableCities).number - 1
            route.append(curCity + 1)
            tourLen += fields.dists[curCity][nextCity]
            curCity = nextCity
            availableCities = removeObject(availableCities, index: curCity)
        }

        tourLen += fields.dists[curCity][initialCity]
        route.append(curCity + 1)
        route.append(initialCity + 1)

        return route

    }

    func removeObject(array: [Node], index: Int) -> [Node] {
        var retArray: [Node] = []
        for node in array {
            if node.number - 1 != index {
                retArray.append(node)
            }
        }
        return retArray
    }

    func selectNextCity(cities: [Node]) -> Node {
        var weights: [Double] = []
        for (var i = 0; i < cities.count; i++) {
            weights.append(getPathValue(curCity, to: cities[i].number - 1))
        }
        let cdfVals = cdf(weights)
        let rand = Double(Float(arc4random()) / Float(UINT32_MAX)) //[0, 1)
        var index = 0
        while cdfVals[index] < rand {
            index++
        }
        return cities[index]

    }

    func getPathValue(from: Int, to: Int) -> Double {
        let pheromone = fields.pheros[from][to]
        let distance  = fields.dists[from][to]
        return pow(pheromone, alpha) * (pow(1.0 / distance, beta))
    }

    func cdf(weights: [Double]) -> [Double] {
        var total = 0.0
        for w in weights {total += w}

        var cdfVals: [Double] = []
        var cumulation = 0.0
        for (var i = 0; i < weights.count; i++) {
            cumulation += weights[i]
            cdfVals.append(cumulation/total)
        }
        return cdfVals

    }

}

class Field {
    let cities: [Node]
    let dists:  [[Double]]
    var pheros: [[Double]]

    init (cities: [Node], dists: [[Double]], pheros: [[Double]]) {
        self.cities = cities
        self.dists  = dists
        self.pheros = pheros
    }

}


class AntColonyOptimization: TSPSolver {

    var numOfAnt = 25
    let P: Double = 0.1
    let MAX_ITER = 32

    let ALPHA = 1.0
    let BETA = 5.0
    let RHO = 0.5
    let Q = 100.0

    func getAnts(field: Field) -> [Ant] {
        var ants: [Ant] = []
        for (var i = 0; i < numOfAnt; i++) {
            let anAnt = Ant(initialCity: Int(arc4random_uniform(UInt32(field.cities.count - 1))), fields: field, alpha: ALPHA, beta: BETA)
            ants.append(anAnt)
        }
        return ants
    }

    func decayPheromone(pheromone: Double) -> Double {
        return pheromone * (1.0 - RHO)
    }

    func deltaPheromone(dis: Double) -> Double {
        return Q / dis
    }

    func updatePheromone(field: Field, ants:[Ant]) {
        for (var i = 0; i < field.cities.count; i++) {
            for (var j = i; j < field.cities.count; j++) {
                if i != j {
                    let pheromone = decayPheromone(field.pheros[i][j])
                    field.pheros[i][j] = pheromone
                    field.pheros[j][i] = pheromone
                }
            }
        }

        for ant in ants {
            let pathLen = ant.route.count
            for (var i = 1; i < ant.route.count; i++) {
                let f = ant.route[i] - 1
                let t = ant.route[i - 1] - 1
                let delta = deltaPheromone(ant.tourLen)
                field.pheros[f][t] += delta
                field.pheros[t][f] = field.pheros[f][t]
            }
        }
    }

    func start(field: Field, ants:[Ant]) -> Ant {
        var bestAnt: Ant? = nil
        var minDistance = 99999999.0

        for (var i = 0; i < MAX_ITER; i++) {
            updatePheromone(field, ants: ants)
            for ant in ants {
                ant.run()
                if ant.tourLen < minDistance {
                    bestAnt = ant
                    minDistance = ant.tourLen
                }
            }
        }

        return bestAnt!
    }

    override func solve(question: TSP) -> Answer {

        var field = Field(cities: question.cities, dists: adjacencyMat, pheros: initPheromoneMat(P, n: question.cities.count))
        numOfAnt = question.cities.count
        let ants = getAnts(field)


        var bestAnt = start(field, ants: ants)
        let twoOptAnswer = improvementAnswerBy2Opt(Answer(route: bestAnt.route, distance: bestAnt.tourLen))

        return twoOptAnswer





    }

    private func initPheromoneMat(pheromone: Double, n: Int) -> [[Double]] {
        var pheromoneMatrix: [[Double]] = Array(count: n, repeatedValue: Array(count: n, repeatedValue: 0.0))
        for (var i = 0; i < n; i++) {
            for (var j = 0; j < n; j++) {
                pheromoneMatrix[i][j] = pheromone;
            }
        }
        return pheromoneMatrix
    }

}
