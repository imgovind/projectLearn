//
//  ViewController.swift
//  prototype-1
//
//  Created by Govindarajan Panneerselvam on 3/17/18.
//  Copyright © 2018 Govindarajan Panneerselvam. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var SceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.SceneView.session.run(configuration)
        
        let cubeScene = SCNScene(named: "Art.scnassets/sequence-cube-test.scn")
        let cubeNode = cubeScene?.rootNode.childNode(withName: "lowResCube", recursively: false)
        cubeNode?.position = SCNVector3(0,0,-2)
        self.SceneView.scene.rootNode.addChildNode(cubeNode!)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

