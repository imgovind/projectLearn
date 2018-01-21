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
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    @IBAction func add(_ sender: Any) {
//        self.addNodeToParent(node: getShape())
//        self.addNodeToParent(node: getHouseShape())
//        self.addMultipleRelativeNodes()
        self.addRotatedNodes()
    }
    
    func addRotatedNodes() {
        // horizontal rotation
        // y-axis rotation
        let box = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0))
        box.geometry?.firstMaterial?.specular.contents = UIColor.orange
        box.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        box.eulerAngles = SCNVector3(0, Float(45.degreeToRadians), 0)
        box.position = SCNVector3(-0.2, 0.0, -0.2)
        let ball = SCNNode(geometry: SCNSphere(radius: 0.05))
        ball.geometry?.firstMaterial?.specular.contents = UIColor.green
        ball.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        ball.position = SCNVector3(0.0, 0.0, -0.3)
        box.addChildNode(ball)
        self.sceneView.scene.rootNode.addChildNode(box)
        
        // rotation
        // z-axis rotation
        let cylinder = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 0.1))
        cylinder.geometry?.firstMaterial?.specular.contents = UIColor.orange
        cylinder.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        cylinder.position = SCNVector3(0.0, 0.0, -0.2)
        cylinder.eulerAngles = SCNVector3(0, 0, Float(45.degreeToRadians))
        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        pyramid.geometry?.firstMaterial?.specular.contents = UIColor.green
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        pyramid.position = SCNVector3(0.0, 0.0, -0.3)
        cylinder.addChildNode(pyramid)
        self.sceneView.scene.rootNode.addChildNode(cylinder)
        
        // vertical rotation
        // x-axis rotation
        let plane = SCNNode(geometry: SCNPlane(width: 0.1, height: 0.1))
        plane.geometry?.firstMaterial?.specular.contents = UIColor.orange
        plane.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        plane.eulerAngles = SCNVector3(Float(45.degreeToRadians), 0, 0)
        plane.position = SCNVector3(0.2, 0.0, -0.2)
        let capsule = SCNNode(geometry: SCNCapsule(capRadius: 0.025, height: 0.1))
        capsule.geometry?.firstMaterial?.specular.contents = UIColor.green
        capsule.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        capsule.position = SCNVector3(0.0, 0.0, -0.3)
        plane.addChildNode(capsule)
        
        self.sceneView.scene.rootNode.addChildNode(plane)
    }

    func addMultipleRelativeNodes() {
        let pyramid = getShape(inputNumber: 4)
        pyramid.geometry?.firstMaterial?.specular.contents = UIColor.orange
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        pyramid.position = SCNVector3(0.2, 0.2, 0.2)
        
        let box = getShape(inputNumber: 0)
        box.geometry?.firstMaterial?.specular.contents = UIColor.orange
        box.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        box.position = SCNVector3(0.0, -0.05, 0.0)
        
        let door = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        door.geometry?.firstMaterial?.specular.contents = UIColor.white
        door.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        door.position = SCNVector3(0, -0.02, 0.051)

        let cylinder = getShape(inputNumber: 3)
        cylinder.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        cylinder.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        cylinder.position = SCNVector3(0.2, 0.0, 0.0)
        
        let cone = getShape(inputNumber: 2)
        cone.geometry?.firstMaterial?.specular.contents = UIColor.red
        cone.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        cone.position = SCNVector3(0.0, 0.1, 0.0)
        
        cylinder.addChildNode(cone)
        pyramid.addChildNode(cylinder)
        box.addChildNode(door)
        pyramid.addChildNode(box)
        
        self.sceneView.scene.rootNode.addChildNode(pyramid)
    }
    
    func addNodeToParent(node: SCNNode) {
        let startRange: CGFloat = 0.3
        let endRange: CGFloat = -0.3
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let x = randomGenerator(start: startRange, end: endRange)
        let y = randomGenerator(start: startRange, end: endRange)
        let z = randomGenerator(start: startRange, end: endRange)
        node.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    func getHouseShape() -> SCNNode {
        let node = SCNNode()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0.0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0.0))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape
        return node
    }
    
    func getShape(inputNumber: Int? = nil) -> SCNNode {
        let node = SCNNode()
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let circle = SCNSphere(radius: 0.05)
        let cone = SCNCone(topRadius: 0, bottomRadius: 0.05, height: 0.1)
        let cylinder = SCNCylinder(radius: 0.05, height: 0.1)
        let pyramid = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        let capsule = SCNCapsule(capRadius: 0.05, height: 0.1)
        let tube = SCNTube(innerRadius: 0.025, outerRadius: 0.05, height: 0.1)
        let torus = SCNTorus(ringRadius: 0.1, pipeRadius: 0.025)
        let plane = SCNPlane(width: 0.2, height: 0.2)
        var number = 0
        if let inputShapeNumber = inputNumber {
            number = inputShapeNumber
        } else {
            number = Int(randomGenerator(start: 0.0, end: 9.0))
        }
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
        case 8:
            node.geometry = plane
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

extension Int {
    var degreeToRadians: Double { return Double(self) * .pi/180 }
}

