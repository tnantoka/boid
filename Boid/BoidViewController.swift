//
//  BoidViewController.swift
//  Boid
//
//  Created by Tatsuya Tobioka on 9/14/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import SpriteKit

class BoidViewController: UIViewController {

    override func loadView() {
        let applicationFrame = UIScreen.mainScreen().bounds
        let skView = SKView(frame: applicationFrame)
        self.view = skView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let skView = self.view as? SKView {
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsDrawCount = true
            skView.showsPhysics = true
            skView.showsFields = true
            skView.showsQuadCount = true

            skView.ignoresSiblingOrder = true

            let scene = BoidScene(size: CGSize(width: CGRectGetWidth(skView.bounds), height: CGRectGetWidth(skView.bounds)))
            skView.presentScene(scene)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
