//
//  RegistrationViewController.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 26/06/24.
//

import UIKit
import FirebaseAuth

protocol RegistrationViewControllerDelegate: AnyObject {
    func didLogin()
}

class RegistrationViewController: UIViewController {
    
    let nameTextField = UITextField()
    let surnameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let registerButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        // Configuração dos campos de texto e do botão de registro
        nameTextField.placeholder = "Name"
        surnameTextField.placeholder = "Surname"
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        confirmPasswordTextField.placeholder = "Confirm Password"
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
        // Adicione os subviews e configure as constraints
        let stackView = UIStackView(arrangedSubviews: [nameTextField, surnameTextField, emailTextField, passwordTextField, confirmPasswordTextField, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func registerTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
              password == confirmPassword else {
                  // Mostrar mensagem de erro
                  return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error registering user: \(error.localizedDescription)")
            } else {
                print("User registered successfully!")
            }
        }
    }
}



