//
//  ViewController.swift
//  Planets
//
//  Created by Govindarajan Panneerselvam on 1/21/18.
//  Copyright © 2018 Govindarajan Panneerselvam. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // let rotate = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: 30)
        // let rotateForever = SCNAction.repeatForever(rotate)
        // earth.runAction(rotateForever)
        let rootPosition = SCNVector3(0, 0, -1)
        let mercuryParent = SCNNode()
        mercuryParent.position = rootPosition
        let venusParent = SCNNode()
        venusParent.position = rootPosition
        let earthParent = SCNNode()
        earthParent.position = rootPosition
        let sun = planet(geometry: SCNSphere(radius: 0.35), diffuse: #imageLiteral(resourceName: "Sun Diffuse"), emission: nil, specular: nil, normal: nil, position: SCNVector3(0,0,-1), action: nil)
        let mercury = planet(geometry: SCNSphere(radius: 0.08), diffuse: #imageLiteral(resourceName: "Mercury Diffuse"), emission: nil, specular: nil, normal: nil, position: SCNVector3(0.6,0,0), action: nil)
        let venus = planet(geometry: SCNSphere(radius: 0.11), diffuse: #imageLiteral(resourceName: "Venus Diffuse"), emission: #imageLiteral(resourceName: "Venus Emission"), specular: nil, normal: nil, position: SCNVector3(1.0,0,0), action: nil)
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth Diffuse"), emission: #imageLiteral(resourceName: "Earth Emission"), specular: nil, normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.7,0,0), action: nil)
        let moon = planet(geometry: SCNSphere(radius: 0.04), diffuse: #imageLiteral(resourceName: "Moon Diffuse"), emission: nil, specular: nil, normal: nil, position: SCNVector3(0.4,0,0), action: nil)
        mercuryParent.addChildNode(mercury)
        venusParent.addChildNode(venus)
        earth.addChildNode(moon)
        earthParent.addChildNode(earth)
        mercuryParent.runAction(rotation(timeInterval: 10))
        venusParent.runAction(rotation(timeInterval: 18))
        earthParent.runAction(rotation(timeInterval: 32))
        earth.runAction(rotation(timeInterval: 8))
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(mercuryParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
    }
    
    func rotation(timeInterval: Int) -> SCNAction {
        return SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: TimeInterval(timeInterval)))
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, emission: UIImage?, specular: UIImage?, normal: UIImage?, position: SCNVector3, action: SCNAction?) -> SCNNode {
        
        let planet = SCNNode(geometry: geometry)
        
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.position = position

        if let planetEmission = emission {
            planet.geometry?.firstMaterial?.emission.contents = planetEmission
        }
        
        if let planetSpecular = specular {
            planet.geometry?.firstMaterial?.specular.contents = planetSpecular
        }
        
        if let planetNormal = normal {
            planet.geometry?.firstMaterial?.normal.contents = planetNormal
        }
        
        if let planetAction = action {
            planet.runAction(planetAction)
        }

        return planet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Int {
    var degreeToRadians: Double { return Double(self) * .pi/180 }
}

