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
    var tsp: TSP = TSP(fileName: "bayg29")
    var solverType: TSPSolver.TSPSolverType = .DynamicProgramming

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var solverTypeLabel: UILabel!

    let tspTitles = ["bayg29", "eil51"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let tspView = TSPView(frame: mainView.bounds)
        mainView.addSubview(tspView)
        visualizer = TSPVisualizer(view: tspView)
        //tsp = TSP(fileName: "eil51")
        visualizer?.drawNodesByTSP(tsp)
        
    }

    @IBAction func solveButtonTouchUpInside(sender: UIButton) {
        var answer = Answer(route: [], distance: 0.0)
        switch solverType {
            case .DynamicProgramming:
                answer = DynamicProgramming(tsp: tsp).solve()

            case .NearestNeighbor:
                answer = NearestNeighbor(tsp: tsp).solve()
            case .AntColonyOptimization:
                answer = AntColonyOptimization(tsp: tsp).solve()
        }
        visualizer?.drawAnser(answer, withTSP: tsp)
        println(answer.distance)
        println(tsp.answer.distance)
        println((answer.distance/tsp.answer.distance - 1) * 100 )

    }

    @IBAction func selectSolverButtonTouchUpInside(sender: UIButton) {
        var alertController = UIAlertController(title: "Select Solver", message: "", preferredStyle: .ActionSheet)

        let selectDP = UIAlertAction(title: "DynamicProgramming", style: .Default) { action in
            self.solverType = .DynamicProgramming
            self.solverTypeLabel.text = self.solverType.rawValue

        }
        let selectNN = UIAlertAction(title: "NearestNeighbor", style: .Default) { action in
            self.solverType = .NearestNeighbor
            self.solverTypeLabel.text = self.solverType.rawValue
        }
        let selectACO = UIAlertAction(title: "AntColonyOptimization", style: .Default) { action in
            self.solverType = .AntColonyOptimization
            self.solverTypeLabel.text = self.solverType.rawValue
        }

        alertController.addAction(selectDP)
        alertController.addAction(selectNN)
        alertController.addAction(selectACO)
        alertController.popoverPresentationController?.sourceView = sender
        presentViewController(alertController, animated: true, completion: nil)
    }

    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tspTitles[indexPath.row]

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tspTitles.count
    }

    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tsp = TSP(fileName: tspTitles[indexPath.row])
        visualizer?.drawNodesByTSP(tsp)
    }

}