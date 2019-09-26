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
    
    private let dimmerView: UIView = {
        let view = UIView()
        let color = UIColor.darkGray
        view.backgroundColor = color.withAlphaComponent(0.7)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Data
    private var backgroundImage: UIImage?
    private var cardViewTop : NSLayoutConstraint?

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
        createDimmerView()
        prepareCardView()
    }
    
    private func prepareBackgroundImage() {
        view.addSubview(backImage)
        
        backImage.image = backgroundImage
        backImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func createDimmerView() {
        view.addSubview(dimmerView)
        
        dimmerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped(_:)))
        dimmerView.addGestureRecognizer(dimmerTap)
        dimmerView.isUserInteractionEnabled = true
    }
    
    private func prepareCardView() {
        view.addSubview(cardView)
        
        cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
            let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
            let constant = safeAreaHeight + bottomPadding
            cardViewTop = cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant)
            cardViewTop?.isActive = true
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showCard()
    }
    
    private func showCard() {
        
        self.view.layoutIfNeeded()
        if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
            let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
            
            cardViewTop?.constant = (safeAreaHeight + bottomPadding) / 2.0
        }
        
        let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        
        showCard.addAnimations({
            self.dimmerView.alpha = 0.7
        })

        showCard.startAnimation()
    }
    
    @objc private func dimmerViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideCardAndGoBack()
    }
    
    private func hideCardAndGoBack() {
        
        self.view.layoutIfNeeded()
        
        if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
            let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
  
            cardViewTop?.constant = safeAreaHeight + bottomPadding
        }
        
        let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        
        hideCard.addAnimations {
            self.dimmerView.alpha = 0.0
        }
        
        hideCard.addCompletion({ position in
            if position == .end {
                if(self.presentingViewController != nil) {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        })
        
        hideCard.startAnimation()
    }
}
