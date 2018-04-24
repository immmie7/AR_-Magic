//
//  GameViewController.swift
//  AR_ Magic
//
//  Created by Imke Beekmans on 23/04/2018.
//  Copyright © 2018 Imke Beekmans. All rights reserved.
//  Code from videos of the Rebeloper

import ARKit
import LBTAComponents


class GameViewController: UIViewController{
    
    let arView: ARSCNView = {
        let view = ARSCNView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    }
    
    let configuration = ARWorldTrackingConfiguration()
    
    
    override func viewDidLoad() {
         super.viewDidLoad()

        
        setupViews()
        

        
        //Now we need to add the configuration to our ARview
        arView.session.run(configuration, options: [])
        
        //Now we are going to add some debugoptions. Because, this really works, but you can see something through your camera but nothing really happens
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin ]
        
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
        
        view.addSubview(plusButton)
        plusButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 24, bottomConstant: 12, rightConstant: 0, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)
        
    }
    
    
    
}

