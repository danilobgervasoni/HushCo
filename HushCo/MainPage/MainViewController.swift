//
//  MainViewController.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 27/06/24.
//

import UIKit
import Foundation
import Alamofire

protocol MainViewControllerDelegate: AnyObject {
    func showMainScreen()
}

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var cardData: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
            let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical

            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: "cardCell")
            collectionView.dataSource = self
            collectionView.delegate = self
            return collectionView
        }()
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cardData.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardViewCell

                // Get the card data for the current index path
                let card = cardData[indexPath.row]

                // Configure the card view's UI elements with card data
                cell.nameLabel.text = card.name
                cell.emailLabel.text = card.email
                // ... set other labels or image views as needed

                return cell
        }

        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        // Load card data from Mockoon (see next step)
        loadCardData()
    }

    func loadCardData() {
        let url = "http://localhost:3002/users"
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let data):
                do {
                    // Tente decodificar os dados recebidos para o array de Users
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let newCardData = try JSONDecoder().decode([User].self, from: jsonData)
                    // Atualize a collection view na thread principal
                    self.updateCollectionView(with: newCardData)
                } catch {
                    print("Erro ao decodificar dados: \(error)")
                }
            case .failure(let error):
                print("Erro na requisição: \(error)")
            }
        }
        
    }
    
    func updateCollectionView(with newCardData: [User]) {
        var newItems: [IndexPath] = []
        
        // Criar novos IndexPath com base no número de novos itens
        for index in 0..<newCardData.count {
            newItems.append(IndexPath(item: index, section: 0))
        }

        // Certifique-se de chamar insertItems(at:) dentro do contexto correto
//        DispatchQueue.main.async {
//            self.collectionView.performBatchUpdates({
//                self.collectionView.insertItems(at: newItems)
//            }, completion: nil)
//        }
    }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cardData.count  // Return the number of card data items
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardViewCell

            // Get the card data for the current index path
            let card = cardData[indexPath.row]

            // Configure the card view's UI elements with card data
            cell.nameLabel.text = card.name
            cell.emailLabel.text = card.email
            // ... set other labels or image views as needed

            return cell
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedCard = cardData[indexPath.row]
        let userDetailViewController = UserDetailViewController(user: selectedCard)
            userDetailViewController.cardData = selectedCard
            navigationController?.pushViewController(userDetailViewController, animated: true)
        }
    }



class CardViewCell: UICollectionViewCell {

    let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.8
        return view
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    // ... other UI elements for profile picture, etc.

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false

        // Add constraints to position the UI elements within the cell
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            nameLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16),

            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16)
        ])
    }
}



//import UIKit
//import Foundation
//
//class MainViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .white
//        
//        let label = UILabel()
//        label.text = "Cards"
//        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//        label.textColor = .black
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(label)
//        
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//}


