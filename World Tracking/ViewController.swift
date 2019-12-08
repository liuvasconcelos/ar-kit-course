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
    }

    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
        // shape of node, in this case is a box.
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        // firstMaterial is the texture of the geometry and diffuse is the color
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        //Vector3 -> 3 dimensions
        node.position = SCNVector3(-0.3,-0.3,-0.5)
        
        //Root node has no attributes (color, size) and is positioned where camera starts.
        //When add a childnode, this child is always relative to the rootnode.
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
}

