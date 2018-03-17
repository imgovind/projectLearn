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
//        newPlanets()
        oldPlanets()
    }
    
    func oldPlanets() {
        // let rotate = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: 30)
        // let rotateForever = SCNAction.repeatForever(rotate)
        // earth.runAction(rotateForever)
        let rootPosition = SCNVector3(0, 0, -1)
        let mercuryParent = rootPlanet(position: rootPosition)
        let venusParent = rootPlanet(position: rootPosition)
        let earthParent = rootPlanet(position: rootPosition)
        earthParent.position = rootPosition
        let sun = planet(geometry: SCNSphere(radius: 0.35), diffuse: #imageLiteral(resourceName: "Sun Diffuse"), emission: nil, specular: nil, normal: nil, position: rootPosition, action: nil)
        let mercury = planet(geometry: SCNSphere(radius: 0.08), diffuse: #imageLiteral(resourceName: "Mercury Diffuse"), emission: nil, specular: nil, normal: nil, position: SCNVector3(0.6,0,0), action: nil)
        let venus = planet(geometry: SCNSphere(radius: 0.11), diffuse: #imageLiteral(resourceName: "Venus Diffuse"), emission: #imageLiteral(resourceName: "Venus Emission"), specular: nil, normal: nil, position: SCNVector3(1.0,0,0), action: nil)
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth Diffuse"), emission: #imageLiteral(resourceName: "Earth Emission"), specular: nil, normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.7,0,0), action: nil)
        let moon = planet(geometry: SCNSphere(radius: 0.04), diffuse: #imageLiteral(resourceName: "Moon Diffuse"), emission: nil, specular: nil, normal: nil, position: SCNVector3(0.4,0,0), action: nil)
        mercuryParent.addChildNode(mercury)
        venusParent.addChildNode(venus)
        earth.addChildNode(moon)
        earthParent.addChildNode(earth)
        mercuryParent.runAction(rotation(timeInterval: 10,rotateBy: nil))
        venusParent.runAction(rotation(timeInterval: 18, rotateBy: nil))
        earthParent.runAction(rotation(timeInterval: 32, rotateBy: nil))
        earth.runAction(rotation(timeInterval: 8, rotateBy: nil))
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(mercuryParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
    }
    
    func newPlanets() {
        let rootPosition = SCNVector3(0, 0, -3.0)
        let sun = getPlanet(name: "sun", size: 0.55, diffuse: #imageLiteral(resourceName: "Sun Diffuse"), emission: nil, specular: nil, normal: nil, planetPosition: SCNVector3(0, 0, 0), planetRotationSpeed: nil, rootPosition: rootPosition, rootRotationSpeed: 30, moonPlanet: nil)
        let mercury = getPlanet(name: "mercury", size: 0.07, diffuse: #imageLiteral(resourceName: "Mercury Diffuse"), emission: nil, specular: nil, normal: nil, planetPosition: SCNVector3(0.8, 0, 0), planetRotationSpeed: 10, rootPosition: rootPosition, rootRotationSpeed: 12, moonPlanet: nil)
        let venus = getPlanet(name: "venus", size: 0.10, diffuse: #imageLiteral(resourceName: "Venus Diffuse"), emission: #imageLiteral(resourceName: "Venus Emission"), specular: nil, normal: nil, planetPosition: SCNVector3(1.1, 0, 0), planetRotationSpeed: 16, rootPosition: rootPosition, rootRotationSpeed: 16, moonPlanet: nil)
        let earthMoon = planet(geometry: SCNSphere(radius: 0.04), diffuse: #imageLiteral(resourceName: "Moon Diffuse"), emission: nil, specular: nil, normal: nil, position: SCNVector3(0.4,0,0), action: nil)
        let earth = getPlanet(name: "earth", size: 0.18, diffuse: #imageLiteral(resourceName: "Earth Diffuse"), emission: #imageLiteral(resourceName: "Earth Emission"), specular: nil, normal: #imageLiteral(resourceName: "Earth Normal"), planetPosition: SCNVector3(1.8, 0, 0), planetRotationSpeed: 20, rootPosition: rootPosition, rootRotationSpeed: 21, moonPlanet: earthMoon)
        let mars = getPlanet(name: "mars", size: 0.15, diffuse: #imageLiteral(resourceName: "Mars Diffuse"), emission: nil, specular: nil, normal: nil, planetPosition: SCNVector3(2.5, 0, 0), planetRotationSpeed: 20, rootPosition: rootPosition, rootRotationSpeed: 26, moonPlanet: nil)
        let jupiter = getPlanet(name: "jupiter", size: 0.35, diffuse: #imageLiteral(resourceName: "Jupiter Diffuse"), emission: nil, specular: nil, normal: nil, planetPosition: SCNVector3(3.3, 0, 0), planetRotationSpeed: 25, rootPosition: rootPosition, rootRotationSpeed: 34, moonPlanet: nil)
        let saturn = getPlanet(name: "saturn", size: 0.30, diffuse: #imageLiteral(resourceName: "Saturn Diffuse"), emission: #imageLiteral(resourceName: "Saturn Emission"), specular: nil, normal: nil, planetPosition: SCNVector3(4.1, 0, 0), planetRotationSpeed: 25, rootPosition: rootPosition, rootRotationSpeed: 39, moonPlanet: nil)
        let uranus = getPlanet(name: "uranus", size: 0.29, diffuse: #imageLiteral(resourceName: "Uranus Diffuse"), emission: nil, specular: nil, normal: nil, planetPosition: SCNVector3(4.9, 0, 0), planetRotationSpeed: 30, rootPosition: rootPosition, rootRotationSpeed: 43, moonPlanet: nil)
        let neptune = getPlanet(name: "neptune", size: 0.27, diffuse: #imageLiteral(resourceName: "Neptune Diffuse"), emission: nil, specular: nil, normal: nil, planetPosition: SCNVector3(5.7, 0, 0), planetRotationSpeed: 30, rootPosition: rootPosition, rootRotationSpeed: 49, moonPlanet: nil)
        let pluto = getPlanet(name: "pluto", size: 0.06, diffuse: #imageLiteral(resourceName: "Pluto Diffuse"), emission: nil, specular: nil, normal: nil, planetPosition: SCNVector3(6.7, 0, 0), planetRotationSpeed: 30, rootPosition: rootPosition, rootRotationSpeed: 54, moonPlanet: nil)
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(mercury)
        self.sceneView.scene.rootNode.addChildNode(venus)
        self.sceneView.scene.rootNode.addChildNode(earth)
        self.sceneView.scene.rootNode.addChildNode(mars)
        self.sceneView.scene.rootNode.addChildNode(jupiter)
        self.sceneView.scene.rootNode.addChildNode(saturn)
        self.sceneView.scene.rootNode.addChildNode(uranus)
        self.sceneView.scene.rootNode.addChildNode(neptune)
        self.sceneView.scene.rootNode.addChildNode(pluto)
    }
    
    func getPlanet(name: String, size: CGFloat, diffuse: UIImage, emission: UIImage?, specular: UIImage?, normal: UIImage?, planetPosition: SCNVector3, planetRotationSpeed: Int?, rootPosition: SCNVector3, rootRotationSpeed: Int?, moonPlanet: SCNNode?) -> SCNNode {
        let childPlanet = planet(geometry: SCNSphere(radius: size), diffuse: diffuse, emission: emission, specular: specular, normal: normal, position: planetPosition, action: nil)
        childPlanet.name = name;
        var childRotation: SCNAction = SCNAction()
        if let childRotationSpeed = planetRotationSpeed {
            childRotation = rotation(timeInterval: childRotationSpeed, rotateBy: nil)
            childPlanet.runAction(childRotation)
        }
        if let actualMoonPlanet = moonPlanet {
            childPlanet.addChildNode(actualMoonPlanet)
        }
        if name == "saturn" {
            let saturnRing = SCNNode(geometry: SCNTorus(ringRadius: size+0.2, pipeRadius: 0.05))
            
        }
        let parentPlanet = rootPlanet(position: rootPosition)
        parentPlanet.name = name + "Parent"
        var parentRotation: SCNAction = SCNAction()
        if let parentRotationSpeed = rootRotationSpeed {
            parentRotation = rotation(timeInterval: parentRotationSpeed, rotateBy: nil)
            parentPlanet.runAction(parentRotation)
        }
        parentPlanet.addChildNode(childPlanet)
        return parentPlanet
    }
    
    func rotation(timeInterval: Int, rotateBy: String?) -> SCNAction {
        return SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: TimeInterval(timeInterval)))
    }
    
    func rootPlanet(position: SCNVector3) -> SCNNode {
        let rootPlanet = SCNNode()
        rootPlanet.position = position
        return rootPlanet
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

