//
//  GameViewController.swift
//  AR_ Magic
//
//  Created by Imke Beekmans on 23/04/2018.
//  Copyright © 2018 Imke Beekmans. All rights reserved.
//  Code from videos of the Rebeloper

//Space textures downloaded from solarystemscope.com

import ARKit
import LBTAComponents


class GameViewController: UIViewController, ARSCNViewDelegate {
    
    let arView: ARSCNView = {
        let view = ARSCNView()
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

// PLUSBUTTON
// Code for the plusbutton
    let plusButtonWidth = ScreenSize.width * 0.1
    lazy var plusButton: UIButton = {
       var button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Plusbutton").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 1.0, alpha: 0.7)
        button.layer.cornerRadius = plusButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handlePlusButtonTapped), for: .touchUpInside)
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc func handlePlusButtonTapped() {
        print("Tapped on plus button")
        //addBox()
        var doesEarthNodeExistInScene = false
        arView.scene.rootNode.enumerateChildNodes { (node, _) in//Makes sure there is only one earth, like real life
            if node.name == "earth" {
               doesEarthNodeExistInScene = true
            }
        }
        if !doesEarthNodeExistInScene { //If doesEarthNode does NOT exist in scene
                    addEarth()
        }
    }
    
    
    
    
// MINUSBUTTON
// Code for the minusbutton
    
    let minusButtonWidth = ScreenSize.width * 0.1
    lazy var minusButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "MinusButton").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 1.0, alpha: 0.7)
        button.layer.cornerRadius = minusButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleMinusButtonTapped), for: .touchUpInside)
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc func handleMinusButtonTapped() {
        print("Tapped on minus button")
        removeAllNodes()
    }

// RESETBUTTON
// Code for the resetbutton
    
    let resetButtonWidth = ScreenSize.width * 0.1
    lazy var resetButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ReloadButton").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 1.0, alpha: 0.7)
        button.layer.cornerRadius = resetButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleResetButtonTapped), for: .touchUpInside)
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc func handleResetButtonTapped() {
        print("Tapped on reset button")
        resetScene()
    }
    
    
    let configuration = ARWorldTrackingConfiguration()
    
    //We are going to measure distance WOOOHOOEEE
    let distanceLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.black
        label.text = "Distance:"
        
        return label
    }()
    
    //X label
    let xLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.red
        label.text = "x"
        
        return label
    }()
    
    //Y label
    let yLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.green
        label.text = "y"
        
        return label
    }()
    
    //Z label
    let zLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.blue
        label.text = "z"
        
        return label
    }()
    
//    let centerImageView: UIImageView = {
//       let view = UIImageView()
//        view.image = #imageLiteral(resourceName: "Center")
//        view.contentMode = .scaleAspectFill
//        return view
//    }()
    
    override func viewDidLoad() {
         super.viewDidLoad()

        
        setupViews()
        
        configuration.planeDetection = .horizontal
        configuration.planeDetection = .vertical
        
        
        
        //Now we need to add the configuration to our ARview
        arView.session.run(configuration, options: [])
        
        //Now we are going to add some debugoptions. Because, this really works, but you can see something through your camera but nothing really happens
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin ]
        arView.autoenablesDefaultLighting = true
        
        arView.delegate = self
        
        
        //Hit Testing stuff
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        arView.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true 
    }
    
    func setupViews() {
        //Position our view that will be done through our constraints
//        arView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        arView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        arView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        arView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //Let's select equalto, as I want it to constrain it to our views topanchor. To activite it, we type isActive behind it
        
        view.addSubview(arView)
        
//        arView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant:0)
        arView.fillSuperview()
      
        //PLUSBUTTON
        view.addSubview(plusButton)
        plusButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 24, bottomConstant: 12, rightConstant: 0, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)
        
        //MINUSBUTTON
        view.addSubview(minusButton)
        minusButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 12, rightConstant: 24 , widthConstant: minusButtonWidth, heightConstant: minusButtonWidth)
        
        //RESETBUTTON
        view.addSubview(resetButton)
        resetButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 12, rightConstant: 0 , widthConstant: resetButtonWidth, heightConstant: resetButtonWidth)
        resetButton.anchorCenterXToSuperview()
        
        
        //Distance label
        view.addSubview(distanceLabel)
        distanceLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 50, leftConstant: 35, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 24)
        
        //labels
        view.addSubview(xLabel)
        view.addSubview(yLabel)
        view.addSubview(zLabel)
        
        xLabel.anchor(distanceLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 24)
        
        yLabel.anchor(xLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 24)
        
        zLabel.anchor(yLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 24)
        
//        view.addSubview(centerImageView)
//        centerImageView.anchorCenterSuperview()
//        centerImageView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.05, heightConstant: ScreenSize.width * 0.05)
        
    
    }
    
    func addBox() {
        let boxNode = SCNNode()
        boxNode.geometry = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0002) //width, height and length in meters
        boxNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Material")
        boxNode.position = SCNVector3(Float.random(min: -0.5, max: 0.5),Float.random(min: -0.5, max: 0.5),Float.random(min: -0.5, max: 0.5)) //x,y,z coordinates in meters
        boxNode.name = "node"
        arView.scene.rootNode.addChildNode(boxNode)
        
    }
    
    func removeAllNodes() {
        arView.scene.rootNode.enumerateChildNodes { (node, _ ) in
            if node.name == "node" {
                node.removeFromParentNode()
            }

            
        }
    }
    
    func resetScene() {
        arView.session.pause()
        arView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "node" {
                node.removeFromParentNode()
            }
        }
        arView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
        
    }
    
//    //Code to create the floor
//    func createFloor(anchor: ARPlaneAnchor) -> SCNNode {
//        let floor = SCNNode()
//        floor.name = "floor" //The name of the floor is floor
//        floor.eulerAngles = SCNVector3(90.degreesToRadians,0,0) //The floor is rotated
//        floor.geometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z)) //Makes the floor floor(plane)-shaped. The x and the z values are used, cuz that are the ground values (y is up in the air)
//        floor.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Material")
//        floor.geometry?.firstMaterial?.isDoubleSided = true
//        floor.position = SCNVector3(anchor.center.x, anchor.center.y, anchor.center.z)
//        return floor
//    }
    
    func removeNode(named: String) {
        arView.scene.rootNode.enumerateChildNodes { (node, _ ) in
            if node.name == named {
                node.removeFromParentNode()
            }
            
            
        }
    }
    
    
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
//        print("New Plane Anchor with extent:", anchorPlane.extent)
//        let floor = createFloor(anchor: anchorPlane)
//        node.addChildNode(floor)
//
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
//        print("Plane Anchor Updated with extent:", anchorPlane.extent)
//        removeNode(named: "floor")
//        print("New Plane Anchor with extent:", anchorPlane.extent)
//        let floor = createFloor(anchor: anchorPlane)
//        node.addChildNode(floor)
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
//        guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
//        print("Plane Anchor removed with extent:", anchorPlane.extent)
//        removeNode(named: "floor ")
//
//    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let tappedView = sender.view as! SCNView
        let touchLocation = sender.location(in: tappedView)
        let hitTest = tappedView.hitTest(touchLocation, options: nil)
        if !hitTest.isEmpty { //If it is N0T empty
            let result = hitTest.first!
            let name = result.node.name
            let geometry = result.node.geometry
            print("Tapped \(String(describing: name)) with geometry: \(String(describing: geometry))")
            
        }
        
    }
    
    // DIFFUSE: The diffuse property specifies the amount of light diffusely reflected from the surface
    
    //SPECULAR: The specuar property specifies the amount of light to reflect in a mirror-like manner
    
    //EMMISION: The emmision property specifies the amount of light the material emits. The emmision does not light up other surfaces in the scene
    
    //NORMAL: The normal property specifies the surface orientation
    
    func addEarth() {
        let earthNode = SCNNode()
        earthNode.name = "earth"
        earthNode.geometry = SCNSphere(radius: 0.2)
        earthNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "EarthDiffuse")
        earthNode.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "EarthSpecular")
        earthNode.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "EarthEmmision")
        earthNode.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "EarthNormal")
        earthNode.position = SCNVector3(0,0,-0.5)
        arView.scene.rootNode.addChildNode(earthNode)
        
        let rotate = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 15) //Rotate the earth a full 360 degrees in 15 seconds
        let rotateForever = SCNAction.repeatForever(rotate)
        earthNode.runAction(rotateForever)
    }

    
}
























