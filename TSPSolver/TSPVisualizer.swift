//
//  TSPVisualizer.swift
//  TSPSolver
//
//  Created by IllyasvielVonEinzbern on 7/6/15.
//  Copyright (c) 2015 KazuyaMIURA. All rights reserved.
//

import UIKit

class TSPVisualizer {

    let tspView: TSPView
    let widthScale  = 0.010
    let heightScale = 0.005


    init(view: TSPView) {
        tspView = view
        
    }

    func fixCoordinatesForTSPViewScale(coordinates:Point) -> Point {

        return Point(x: coordinates.x, y: Double(tspView.frame.height) - coordinates.y)
    }

    func drawNodesByTSP(tsp: TSP) {
        UIGraphicsBeginImageContextWithOptions((tspView.frame.size), false, 0)
        let context = UIGraphicsGetCurrentContext()

        let radius = self.tspView.frame.width * 0.005
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor);
        for (var i = 0; i < count(tsp.cities); i++) {
            let aPoint = fixCoordinatesForTSPViewScale(tsp.cities[i].coordinates)
            CGContextFillEllipseInRect(context, CGRectMake(CGFloat(aPoint.x) - radius, CGFloat(aPoint.y) - radius, 2 * radius, 2 * radius))
        }


        tspView.nodesImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

}
