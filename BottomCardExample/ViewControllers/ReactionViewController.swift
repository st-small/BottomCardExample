//
//  ReactionViewController.swift
//  BottomCardExample
//
//  Created by Станислав Шияновский on 9/26/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public class ReactionViewController: UIViewController {
    
    // UI elements
    private let backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Data
    private var backgroundImage: UIImage?

    public init(image: UIImage?) {
        backgroundImage = image
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func loadView() {
        super.loadView()
        
        prepareBackgroundImage()
    }
    
    private func prepareBackgroundImage() {
        view.addSubview(backImage)
        
        backImage.image = backgroundImage
        backImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
