//
//  ViewController.swift
//  ARDrawing
//
//  Created by Govindarajan Panneerselvam on 1/21/18.
//  Copyright © 2018 Govindarajan Panneerselvam. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var draw: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        // print("rendering")
        guard let pointOfView = self.sceneView.pointOfView else {
            return
        }
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let currentPosition = addTwoVectors(left: orientation, right: location)
        DispatchQueue.main.async {
            // print("Orientation -> x: ",orientation.x, " y: ",orientation.y, " z: ",orientation.z)
            // print("Location -> x: ",location.x, " y: ",location.y, " z: ",location.z)
            // print("Position -> x: ",position.x, " y: ",position.y, " z: ",position.z)
            if (self.draw.isHighlighted) {
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.01))
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                sphereNode.position = currentPosition
                self.sceneView.scene.rootNode.addChildNode(sphereNode)
            } else {
                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
                pointer.name = "pointer"
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                pointer.position = currentPosition
                self.sceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if(node.name == "pointer") {
                        node.removeFromParentNode()
                    }
                })
                self.sceneView.scene.rootNode.addChildNode(pointer)
            }
        }
    }
    
    func addTwoVectors(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    }

}

