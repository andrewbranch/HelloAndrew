//
//  ViewController.swift
//  What’s My Name
//
//  Created by Andrew Branch on 5/21/18.
//  Copyright © 2018 Wheream.io. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSceneView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addName()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func setupSceneView() {
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show debug info
        // sceneView.showsStatistics = true
        // sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Enable lighting
        sceneView.autoenablesDefaultLighting = true
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    func addName() {
        let label = SCNText(string: "Hi! It’s Andrew!", extrusionDepth: 2)
        label.materials = [SCNMaterial()]
        label.firstMaterial!.diffuse.contents = UIColor.orange
        label.firstMaterial!.specular.contents = UIColor.white
        label.firstMaterial?.isDoubleSided = true
        label.chamferRadius = 0.02
        
        let (minBound, maxBound) = label.boundingBox
        let labelNode = SCNNode(geometry: label)
        // Centre Node - to Centre-Bottom point
        labelNode.pivot = SCNMatrix4MakeTranslation((maxBound.x - minBound.x) / 2, minBound.y, 0.01)
        // Reduce default text size
        labelNode.scale = SCNVector3Make(0.02, 0.02, 0.02)
        labelNode.simdPosition = simd_float3.init(x: 0, y: 0, z: -1)
        
        sceneView.scene.rootNode.addChildNode(labelNode)
    }

    // MARK: - ARSCNViewDelegate
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
