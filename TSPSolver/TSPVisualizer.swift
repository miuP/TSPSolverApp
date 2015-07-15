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
    var widthScale  = 0.010
    var heightScale = 0.005
    var offset: Point = Point(x: 0, y: 0)
    var margin = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    var padding = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
    let lineWidthScale = 0.0010


    init(view: TSPView) {
        tspView = view
        
    }

    private func prepareScale(tsp: TSP) {
        var top = Double(MAXFLOAT), left = Double(MAXFLOAT), bottom = Double(0), right = Double(0)
        for (var i = 0; i < count(tsp.cities); i++) {
            if tsp.cities[i].coordinates.x < left   {left   = tsp.cities[i].coordinates.x}
            if tsp.cities[i].coordinates.x > right  {right  = tsp.cities[i].coordinates.x}
            if tsp.cities[i].coordinates.y < top    {top    = tsp.cities[i].coordinates.y}
            if tsp.cities[i].coordinates.y > bottom {bottom = tsp.cities[i].coordinates.y}
        }

        offset = Point(x: left, y: top)
        widthScale  = Double(tspView.frame.width - margin.left - margin.right)/(right - left)
        heightScale = Double(tspView.frame.height - margin.top - margin.bottom)/(bottom - top)

        if widthScale > heightScale {
            widthScale = heightScale
            let displayWidth = (right - left) * widthScale
            padding.left  = (tspView.frame.width - (margin.left + margin.right) - CGFloat(displayWidth)) / 2.0
            padding.right = (tspView.frame.width - (margin.left + margin.right) - CGFloat(displayWidth)) / 2.0
            padding.top = CGFloat(0.0)
            padding.bottom = CGFloat(0.0)
        } else {
            heightScale = widthScale
            let displayHeight = (bottom - top) * heightScale
            padding.top  = (tspView.frame.height - (margin.top + margin.bottom) - CGFloat(displayHeight)) / 2.0
            padding.bottom = (tspView.frame.height - (margin.top + margin.bottom) - CGFloat(displayHeight)) / 2.0
            padding.left = CGFloat(0.0)
            padding.right = CGFloat(0.0)
        }
    }

    private func fixCoordinatesForTSPViewScale(coordinates:Point) -> Point {
        return Point(x: (coordinates.x - offset.x) * widthScale + Double(margin.left + padding.left) ,
                     y: ((coordinates.y - offset.y) * heightScale + Double(margin.top + padding.top)) * -1 + Double(tspView.frame.height))
    }

    func drawNodesByTSP(tsp: TSP) {
        prepareScale(tsp)
        UIGraphicsBeginImageContextWithOptions((tspView.frame.size), false, 0)
        let context = UIGraphicsGetCurrentContext()

        let radius = self.tspView.frame.width * 0.003
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor);
        for (var i = 0; i < count(tsp.cities); i++) {
            let aPoint = fixCoordinatesForTSPViewScale(tsp.cities[i].coordinates)
            CGContextFillEllipseInRect(context, CGRectMake(CGFloat(aPoint.x) - radius, CGFloat(aPoint.y) - radius, 2 * radius, 2 * radius))
        }


        tspView.nodesImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    func drawAnser(answer: Answer, withTSP tsp: TSP) {
        UIGraphicsBeginImageContextWithOptions(tspView.frame.size, false, 0);
        let context = UIGraphicsGetCurrentContext();

        let start = fixCoordinatesForTSPViewScale(tsp.cities[answer.route[0] - 1].coordinates)
        let numOfCities = count(tsp.cities)

        CGContextSetLineWidth(context, tspView.frame.width * CGFloat(lineWidthScale));
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor);
        CGContextMoveToPoint(context, CGFloat(start.x), CGFloat(start.y));

        for (var i = 1; i <= numOfCities; i++) {
            let nodeNumber = answer.route[i];
            if nodeNumber <  1 || nodeNumber > numOfCities { // Tour ends.
                break;
            }
            let aPoint = fixCoordinatesForTSPViewScale(tsp.cities[nodeNumber - 1].coordinates);
            CGContextAddLineToPoint(context, CGFloat(aPoint.x), CGFloat(aPoint.y));
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, CGFloat(aPoint.x), CGFloat(aPoint.y));
        }

        tspView.tourImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

    }



}
