//
//  RegistrationViewController.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 26/06/24.
//

import UIKit


class RegistrationViewController: UIViewController, OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {

    }
    
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let phoneTextField = UITextField()
    let jobTextField = UITextField()
    let linkedinTextField = UITextField()
    let githubTextField = UITextField()
    let registerButton = UIButton(type: .system)
    let titleLabel = UILabel()
    
    let logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        
        func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func clearTextFields() {
    }
    
    private func setupViews() {
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        phoneTextField.placeholder = "Phone"
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        
        jobTextField.placeholder = "Job"
        jobTextField.borderStyle = .roundedRect
        jobTextField.translatesAutoresizingMaskIntoConstraints = false
        
        linkedinTextField.placeholder = "LinkedIn"
        linkedinTextField.borderStyle = .roundedRect
        linkedinTextField.translatesAutoresizingMaskIntoConstraints = false
        
        githubTextField.placeholder = "GitHub"
        githubTextField.borderStyle = .roundedRect
        githubTextField.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Registration"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        view.addSubview(titleLabel)
        view.addSubview(logoutButton)
        
        
        let stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, phoneTextField, jobTextField, linkedinTextField, githubTextField, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            jobTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            jobTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            jobTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            linkedinTextField.topAnchor.constraint(equalTo: jobTextField.bottomAnchor, constant: 20),
            linkedinTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            linkedinTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            githubTextField.topAnchor.constraint(equalTo: linkedinTextField.bottomAnchor, constant: 20),
            githubTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            githubTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            registerButton.topAnchor.constraint(equalTo: githubTextField.bottomAnchor, constant: 30),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
            
        ])
    }
    
    @objc func logoutButtonTapped() {
        UserDefaults.standard.removeObject(forKey: "userToken")
        let loginViewController = LoginViewController()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.setRootViewController(loginViewController)
    }
    
    @objc func registerTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let phone = phoneTextField.text, !phone.isEmpty,
              let job = jobTextField.text, !job.isEmpty,
              let linkedin = linkedinTextField.text, !linkedin.isEmpty,
              let github = githubTextField.text, !github.isEmpty else {
            // Show error message
            return
        }
        
        let newUser = User(id: UUID().uuidString,
                           name: name,
                           email: email,
                           password: password,
                           phone: phone,
                           job: job,
                           linkedin: linkedin,
                           github: github)
        
        
        NetworkManager.shared.registerUser(newUser) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("User registered: \(user)")
                    DispatchQueue.main.async {
                        self.showAlert(title: "Sucess", message: "New user successfully registered!")
                        self.nameTextField.clear()
                        self.emailTextField.clear()
                        self.passwordTextField.clear()
                        self.phoneTextField.clear()
                        self.jobTextField.clear()
                        self.linkedinTextField.clear()
                        self.githubTextField.clear()
                        }
                    
                    
                case .failure(let error):
                    print("Failed to register user: \(error)")
                    // Mostre um alerta de erro
                    
                    
                }
                
            }
        }
    }
}



extension UITextField {
    func clear() {
        self.text = ""
    }
}


