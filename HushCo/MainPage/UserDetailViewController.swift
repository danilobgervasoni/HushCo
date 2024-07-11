//
//  UserDetailViewController.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 10/07/24.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var cardData: User
    
    init(user: User) {
        self.cardData = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let nameLabel = UILabel()
        nameLabel.text = cardData.name
        
        let emailLabel = UILabel()
        emailLabel.text = cardData.email
        
        // Add other labels and configure them
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel /* add other labels here */])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

