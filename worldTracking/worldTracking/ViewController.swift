//
//  ViewController.swift
//  worldTracking
//
//  Created by Govindarajan Panneerselvam on 1/19/18.
//  Copyright © 2018 Govindarajan Panneerselvam. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: Any) {
        let node = getRandomNode()
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let x = randomGenerator(start: 0.3, end: -0.3)
        let y = randomGenerator(start: 0.3, end: -0.3)
        let z = randomGenerator(start: 0.3, end: -0.3)
        node.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func getRandomNode() -> SCNNode {
        let node = SCNNode()
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.025)
        let circle = SCNSphere(radius: 0.05)
        let cone = SCNCone(topRadius: 0, bottomRadius: 0.05, height: 0.1)
        let cylinder = SCNCylinder(radius: 0.05, height: 0.1)
        let pyramid = SCNPyramid(width: 0.05, height: 0.05, length: 0.1)
        let capsule = SCNCapsule(capRadius: 0.05, height: 0.1)
        let tube = SCNTube(innerRadius: 0.025, outerRadius: 0.05, height: 0.1)
        let torus = SCNTorus(ringRadius: 0.1, pipeRadius: 0.025)
        let number = Int(randomGenerator(start: 0.0, end: 8.0))
        switch number {
        case 0:
            node.geometry = box
        case 1:
            node.geometry = circle
        case 2:
            node.geometry = cone
        case 3:
            node.geometry = cylinder
        case 4:
            node.geometry = pyramid
        case 5:
            node.geometry = capsule
        case 6:
            node.geometry = tube
        case 7:
            node.geometry = torus
        default:
            node.geometry = box
        }
        return node
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in node.removeFromParentNode() }
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomGenerator(start: CGFloat, end: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(start-end) + min(start, end)
    }
}

