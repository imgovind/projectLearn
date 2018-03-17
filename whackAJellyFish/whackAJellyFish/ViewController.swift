//
//  ViewController.swift
//  whackAJellyFish
//
//  Created by Govindarajan Panneerselvam on 3/6/18.
//  Copyright © 2018 Govindarajan Panneerselvam. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var SceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.SceneView.session.run(configuration)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.SceneView.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(_ sender: Any) {
        self.addNode()
        self.play.isEnabled = false
    }
    
    @IBAction func reset(_ sender: Any) {
        self.SceneView.scene.rootNode.enumerateChildNodes{ (node, stop) in node.removeFromParentNode() }
        self.play.isEnabled = true
    }
    
    func addOldNode() {
        let node = SCNNode(geometry: SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0))
        node.position = SCNVector3(0,0,-1)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        self.SceneView.scene.rootNode.addChildNode(node)
    }
    
    func addNode() {
        let jellyFishScene = SCNScene(named: "Art.scnassets/Jellyfish.scn")
        let jellyFishNode = jellyFishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        jellyFishNode?.position = SCNVector3(randomNumbers(start: -1, end: 1), randomNumbers(start: -0.5, end: 0.5), randomNumbers(start: -1, end: 1))
        self.SceneView.scene.rootNode.addChildNode(jellyFishNode!)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if(hitTest.isEmpty) {
            print("Didn't touch the box")
        } else {
            let results = hitTest.first!
//            let geometry = results.node.geometry
//            print(geometry)
            let currentNode = results.node
            if currentNode.animationKeys.isEmpty {
                SCNTransaction.begin()
                self.animateNode(node: currentNode)
                SCNTransaction.completionBlock = {
                    currentNode.removeFromParentNode()
                    self.addNode()
                }
                SCNTransaction.commit()
            }
        }
    }
    
    func animateNode(node: SCNNode){
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = node.presentation.position
        spin.toValue = SCNVector3(node.presentation.position.x - 0.2, node.presentation.position.y - 0.2, node.presentation.position.z - 0.2)
        spin.duration = 0.07
        spin.autoreverses = true
        spin.repeatCount = 5
        node.addAnimation(spin, forKey: "position")
    }
    
    func randomNumbers(start: CGFloat, end: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(start - end) + min(start, end)
    }
}

