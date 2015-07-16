//
//  ViewController.swift
//  TSPSolver
//
//  Created by IllyasvielVonEinzbern on 5/27/15.
//  Copyright (c) 2015 KazuyaMIURA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var visualizer: TSPVisualizer?
    var tsp: TSP = TSP(fileName: "test")

    @IBOutlet weak var mainView: UIView!




    override func viewDidLoad() {
        super.viewDidLoad()
        let tspView = TSPView(frame: mainView.bounds)
        mainView.addSubview(tspView)
        visualizer = TSPVisualizer(view: tspView)
        tsp = TSP(fileName: "test")
        visualizer?.drawNodesByTSP(tsp)
    }

    @IBAction func solveButtonTouchUpInside(sender: UIButton) {
        visualizer?.drawAnser(DynamicProgramming(tsp: tsp).solve(tsp), withTSP: tsp)

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

}