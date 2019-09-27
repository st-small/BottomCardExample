//
//  ReactionViewController.swift
//  BottomCardExample
//
//  Created by Станислав Шияновский on 9/26/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public enum CardViewState {
    case expanded
    case normal
}

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
    
    private let handleView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 3.0
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Data
    private var backgroundImage: UIImage?
    private var cardViewTop: NSLayoutConstraint?
    private var cardViewState: CardViewState = .normal
    private var cardPanStartingTopConstant: CGFloat = 30.0

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
        prepareHandleView()
        preparePanGesture()
        prepareBannerImage()
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
    
    private func prepareHandleView() {
        view.addSubview(handleView)
        
        handleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        handleView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        handleView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        handleView.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -10).isActive = true
    }
    
    private func preparePanGesture() {
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        
        self.view.addGestureRecognizer(viewPan)
    }
    
    private func prepareBannerImage() {
        cardView.addSubview(bannerImage)
        
        bannerImage.image = UIImage(named: "Tauriel")
        bannerImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        bannerImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        bannerImage.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.8).isActive = true
        bannerImage.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    @objc private func viewPanned(_ panRecognizer: UIPanGestureRecognizer) {
        let translation = panRecognizer.translation(in: self.view)
        
        guard let topConstant = cardViewTop else { return }
        let velocity = panRecognizer.velocity(in: self.view)
        switch panRecognizer.state {
        case .began:
            cardPanStartingTopConstant = topConstant.constant
        case .changed :
            dimmerView.alpha = dimAlphaWithCardTopConstraint(value: topConstant.constant)
            if cardPanStartingTopConstant + translation.y > 30.0 {
                topConstant.constant = cardPanStartingTopConstant + translation.y
            }
        case .ended :
            if velocity.y > 1500.0 {
                hideCardAndGoBack()
                return
            }
            
            if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
                let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
                
                if topConstant.constant < (safeAreaHeight + bottomPadding) * 0.25 {
                    showCard(atState: .expanded)
                } else if topConstant.constant < (safeAreaHeight) - 70 {
                    showCard(atState: .normal)
                } else {
                    hideCardAndGoBack()
                }
            }
        default:
            break
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showCard()
    }
    
    private func showCard(atState: CardViewState = .normal) {
        
        self.view.layoutIfNeeded()
        if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
            let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
            
            if atState == .expanded {
                cardViewTop?.constant = 30.0
            } else {
                cardViewTop?.constant = (safeAreaHeight + bottomPadding) / 2.0
            }
            
            cardPanStartingTopConstant = cardViewTop?.constant ?? 0
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
    
    private func dimAlphaWithCardTopConstraint(value: CGFloat) -> CGFloat {
        let fullDimAlpha : CGFloat = 0.7
        
        guard let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
            let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom else {
                return fullDimAlpha
        }
        
        let fullDimPosition = (safeAreaHeight + bottomPadding) / 2.0
        let noDimPosition = safeAreaHeight + bottomPadding

        if value < fullDimPosition {
            return fullDimAlpha
        }

        if value > noDimPosition {
            return 0.0
        }
        
        return fullDimAlpha * 1 - ((value - fullDimPosition) / fullDimPosition)
    }
}
