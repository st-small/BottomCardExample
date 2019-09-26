//
//  ButtonsContainer.swift
//  BottomCardExample
//
//  Created by Станислав Шияновский on 9/26/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public class ButtonsContainer: UIView {
    
    // UI elements
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        prepareDividers()
        prepareButtons()
    }
    
    private func prepareDividers() {
        let top = UIView()
        top.backgroundColor = .lightGray
        top.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(top)
        top.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        top.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        top.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        top.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let bottom = UIView()
        bottom.backgroundColor = .lightGray
        bottom.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(bottom)
        bottom.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottom.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottom.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottom.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func prepareButtons() {
        prepareLikeView()
        prepareCommentView()
        prepareShareView()
    }
    
    private func prepareLikeView() {
        self.addSubview(likesView)
        likesView.topAnchor.constraint(equalTo: self.topAnchor, constant: 1).isActive = true
        likesView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        likesView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
        likesView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.333).isActive = true
        
        likesLabel.text = "Лайк"
        likesView.addSubview(likesLabel)
        likesLabel.centerXAnchor.constraint(equalTo: likesView.centerXAnchor).isActive = true
        likesLabel.centerYAnchor.constraint(equalTo: likesView.centerYAnchor).isActive = true
    }
    
    private func prepareCommentView() {
        self.addSubview(commentsView)
        commentsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 1).isActive = true
        commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor).isActive = true
        commentsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
        commentsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.333).isActive = true
        
        commentsLabel.text = "Комментарий"
        commentsView.addSubview(commentsLabel)
        commentsLabel.centerXAnchor.constraint(equalTo: commentsView.centerXAnchor).isActive = true
        commentsLabel.centerYAnchor.constraint(equalTo: commentsView.centerYAnchor).isActive = true
    }
    
    private func prepareShareView() {
        self.addSubview(sharesView)
        sharesView.topAnchor.constraint(equalTo: self.topAnchor, constant: 1).isActive = true
        sharesView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sharesView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
        sharesView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.333).isActive = true
        
        sharesLabel.text = "Поделиться"
        sharesView.addSubview(sharesLabel)
        sharesLabel.centerXAnchor.constraint(equalTo: sharesView.centerXAnchor).isActive = true
        sharesLabel.centerYAnchor.constraint(equalTo: sharesView.centerYAnchor).isActive = true
    }
}
