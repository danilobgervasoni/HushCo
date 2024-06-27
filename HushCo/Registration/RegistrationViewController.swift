//
//  RegistrationViewController.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 26/06/24.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let phoneTextField = UITextField()
    let jobTextField = UITextField()
    let linkedinTextField = UITextField()
    let githubTextField = UITextField()
    let registerButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
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
        
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(phoneTextField)
        view.addSubview(jobTextField)
        view.addSubview(linkedinTextField)
        view.addSubview(githubTextField)
        view.addSubview(registerButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
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
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func registerTapped() {
        let id = UUID().uuidString
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let job = jobTextField.text ?? ""
        let linkedin = linkedinTextField.text ?? ""
        let github = githubTextField.text ?? ""
        
        let user = User(id: id, name: name, email: email, password: password, phone: phone, job: job, linkedin: linkedin, github: github)
        saveUserToFile(user: user)
    }
    
    private func saveUserToFile(user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            if let json = String(data: encoded, encoding: .utf8) {
                print(json)
                let filename = getDocumentsDirectory().appendingPathComponent("user.json")
                do {
                    try json.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                } catch {
                    print("Failed to write JSON data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


