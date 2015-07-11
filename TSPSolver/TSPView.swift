//
//  TSPView.swift
//  TSPSolver
//
//  Created by IllyasvielVonEinzbern on 5/27/15.
//  Copyright (c) 2015 KazuyaMIURA. All rights reserved.
//

import UIKit

class TSPView: UIView {

    let nodesImageView: UIImageView
    let tourImageView:  UIImageView

    override init(frame: CGRect) {
        nodesImageView = UIImageView(frame: frame)
        tourImageView  = UIImageView(frame: frame)
        super.init(frame: frame)


        self.addSubview(nodesImageView)
        self.addSubview(tourImageView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
