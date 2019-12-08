//
//  ViewController.swift
//  World Tracking
//
//  Created by Livia Vasconcelos on 08/12/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    // Tracks the position of camera with the real world at all time (position and orientation).
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,
                                       ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }

    @IBAction func add(_ sender: Any) {
        
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        
        // .resetTracking removes the previous coordinators and create a new one based on the position that you are.
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors] )
    }

    func randomNumbers(firstNumber: CGFloat, secondNumber: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber)
            + min(firstNumber, secondNumber)
    }
    
    fileprivate func addCustomNodesGeometries() {
        let node = SCNNode()
        // To add a box or spheres:
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1/2)
        //To add capsule:
        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        //To add cone:
        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.3, height: 0.3)
        //To add cilinder:
        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.1, height: 0.3)
        //To add cilinder (second option):
        node.geometry = SCNCylinder(radius: 0.2, height: 0.2)
        // To add spheres (second option):
        node.geometry = SCNSphere(radius: 0.1)
        // To add a tube:
        node.geometry = SCNTube(innerRadius: 0.1, outerRadius: 0.3, height: 0.3)
        // To add a Torus (ring radius should always be bigger than pipe radius)
        node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
        // To add a plane:
        node.geometry = SCNPlane(width: 0.2, height: 0.2)
        // To add a pyramid:
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        // To make custom objects // Software: BezierCode Lite
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0))

        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape
            
        // firstMaterial is the texture of the geometry and diffuse is the color
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        //specular is the light that the object reflects.
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        
        //To add random positions
        let x = randomNumbers(firstNumber: -0.3, secondNumber: 0.3)
        let y = randomNumbers(firstNumber: -0.3, secondNumber: 0.3)
        let z = randomNumbers(firstNumber: -0.3, secondNumber: 0.3)
        node.position = SCNVector3(x,y,z)
        
        //Root node has no attributes (color, size) and is positioned where camera starts.
        //When add a childnode, this child is always relative to the rootnode.
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    fileprivate func addHouse() {
        let node = SCNNode()
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow

        node.position     = SCNVector3(0.2,0.3,-0.2)
        boxNode.position  = SCNVector3(0, -0.05, 0)
        doorNode.position = SCNVector3(0, -0.02, 0.051)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
    }
}

