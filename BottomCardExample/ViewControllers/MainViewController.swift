//
//  MainViewController.swift
//  BottomCardExample
//
//  Created by Станислав Шияновский on 9/23/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public class MainViewController: UIViewController {
    
    // UI elements
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "elf")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let lastVisitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let containerView: UIView = {
        let view = ButtonsContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let reactionAction: UIButton = {
        let button = UIButton(type: .system)
        let font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let attrs: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black]
        let attrTitle =
            NSAttributedString(string: "😀 Тим Кук и 10 других", attributes: attrs)
        button.setAttributedTitle(attrTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareAvatarImage()
        prepareUserDescription()
        prepareMainTextDescription()
        prepareButtonsContainer()
        prepareReactionAction()
    }
    
    private func prepareAvatarImage() {
        view.addSubview(avatarImage)
        
        avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        avatarImage.layer.cornerRadius = 50.0
        avatarImage.clipsToBounds = true
    }
    
    private func prepareUserDescription() {
        view.addSubview(nameLabel)
        
        nameLabel.text = "Tauriel (Лесная дева)"
        nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.addSubview(lastVisitLabel)
        
        lastVisitLabel.text = "Сегодня в 14:31"
        lastVisitLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        lastVisitLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        lastVisitLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func prepareMainTextDescription() {
        view.addSubview(descriptionLabel)
        
        let sampleText = "Она помогает гномам, когда на них напали пауки Лихолесья, и спасает гнома Кили от гибели. Гномы попадают в плен к лесным эльфам Лихолесья и их бросают в подземелье. Причем Тауриэль сама отводит в темницу Кили и позднее общается с ним. Между ними возникает явная симпатия, перерастающая в невысказанные романтические чувства. Затем в момент беседы начальника стражи и короля лесных эльфов Трандуила участник похода Торина Дубощита на Эребор хоббит Бильбо освобождает гномов из заточения и они пытаются бежать в бочках по реке. Эльфы по приказу узнавших о побеге гномов Леголаса и Тауриэль пытаются остановить гномов и подвергаются нападению орков во главе с Больгом. Тауриэль вступает в бой с орками и пленяет одного из них, а затем отправляется на поиски Кили и вместе с Леголасом является в Эсгарот."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        paragraphStyle.firstLineHeadIndent = 40.0
        
        let attributedString =
            NSAttributedString(string: sampleText, attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.baselineOffset: NSNumber(value: 0)])

        descriptionLabel.attributedText = attributedString
        
        descriptionLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }
    
    private func prepareButtonsContainer() {
        view.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func prepareReactionAction() {
        view.addSubview(reactionAction)

        reactionAction.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
        reactionAction.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        reactionAction.heightAnchor.constraint(equalToConstant: 44).isActive = true

        reactionAction.addTarget(self, action: #selector(reactionTapped), for: .touchUpInside)
    }
    
    @objc private func reactionTapped() {
        let reactionVC = ReactionViewController(image: self.tabBarController?.view.asImage())
        reactionVC.modalPresentationStyle = .fullScreen
        self.present(reactionVC, animated: false, completion: nil)
    }
}
