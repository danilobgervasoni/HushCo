//
//  SplashViewController.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 04/07/24.
//

import UIKit

class SplashViewController: UIViewController {

    // Componente de imagem para a logo
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HushCo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        animateLogo()
    }
    
    func setupLayout() {
        // Adicionar o componente à view
        view.addSubview(logoImageView)
        
        // Desabilitar AutoResizingMask para usar AutoLayout
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurar as constraints
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 400),
            logoImageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func animateLogo() {
        // Definir a escala inicial da logo (bem pequena)
        logoImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        // Animação de aumento de tamanho
        UIView.animate(withDuration: 0.5, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { _ in
            UIView.animate(withDuration: 2.0, animations: {
                self.logoImageView.transform = CGAffineTransform.identity
            }) { _ in
                self.showLoginScreen()
            }
        }
    }
    
    func showLoginScreen() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: true, completion: nil)
    }
}

