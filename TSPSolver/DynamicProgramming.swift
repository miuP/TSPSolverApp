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
        return Answer(route: [], distance: 0)
    }
}
