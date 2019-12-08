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
        let node = SCNNode()
        // shape of node, in this case is a box.
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1/2)
        // firstMaterial is the texture of the geometry and diffuse is the color
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        //specular is the light that the object reflects.
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        
        let x = randomNumbers(firstNumber: -0.3, secondNumber: 0.3)
        let y = randomNumbers(firstNumber: -0.3, secondNumber: 0.3)
        let z = randomNumbers(firstNumber: -0.3, secondNumber: 0.3)
        //Vector3 -> 3 dimensions
        node.position = SCNVector3(x,y,z)
        
        //Root node has no attributes (color, size) and is positioned where camera starts.
        //When add a childnode, this child is always relative to the rootnode.
        self.sceneView.scene.rootNode.addChildNode(node)
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
}

