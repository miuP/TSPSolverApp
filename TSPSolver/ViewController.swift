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

    @IBOutlet weak var mainView: UIView!




    override func viewDidLoad() {
        super.viewDidLoad()
        let tspView = TSPView(frame: mainView.bounds)
        mainView.addSubview(tspView)
        visualizer = TSPVisualizer(view: tspView)
    }

    @IBAction func solveButtonTouchUpInside(sender: UIButton) {
        let tsp = TSP(fileName: "test")
        visualizer?.drawNodesByTSP(tsp)
        visualizer?.drawAnser(NearestNeighbor(tsp: tsp).solve(tsp), withTSP: tsp)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

}