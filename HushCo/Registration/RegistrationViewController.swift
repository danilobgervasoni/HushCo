//
//  RegistrationViewController.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 26/06/24.
//

import UIKit
import FirebaseAuth

protocol RegistrationViewControllerDelegate: AnyObject {
    func didRegister()
}


class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: RegistrationViewControllerDelegate?
    
    let nameTextField = UITextField()
    let nameErrorLabel = UILabel()
    
    let surnameTextField = UITextField()
    let surnameErrorLabel = UILabel()
    
    let emailTextField = UITextField()
    let emailErrorLabel = UILabel()
    
    let passwordTextField = UITextField()
    let passwordErrorLabel = UILabel()
    
    let confirmPasswordTextField = UITextField()
    let confirmPasswordErrorLabel = UILabel()
    
    let registerButton = UIButton(type: .system)
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let dividerView = UIView()
    
    let maxNameLength = 15
    let maxSurnameLength = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        
        configureTextFields()
        configureErrorLabels()
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidEndEditing), for: .editingDidEnd)
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    func setupUI() {
        
        // Configuração dos campos de texto
        nameTextField.backgroundColor = UIColor.systemGray6
        surnameTextField.backgroundColor = UIColor.systemGray6
        emailTextField.backgroundColor = UIColor.systemGray6
        passwordTextField.backgroundColor = UIColor.systemGray6
        confirmPasswordTextField.backgroundColor = UIColor.systemGray6
        
        emailTextField.autocapitalizationType = .none
        
        // Configuração do divisor
        dividerView.backgroundColor = UIColor.systemGray4
        
        //Configura o título
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Fill in the fields to register"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        
        //Configura o subtítulo
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.text = "All fields are mandatory"
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel.textAlignment = .center
        
        //Configura os campos mandatórios
        nameTextField.setPlaceholder(text: "Name", isMandatory: true)
        surnameTextField.setPlaceholder(text: "Surname", isMandatory: true)
        emailTextField.setPlaceholder(text: "Email", isMandatory: true)
        passwordTextField.setPlaceholder(text: "Password", isMandatory: true)
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.setPlaceholder(text: "Confirm Password", isMandatory: true)
        confirmPasswordTextField.isSecureTextEntry = true
        
        // Configuração do botão de registro
        registerButton.setTitle("Register", for: [])
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        //registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.configuration = .filled()
        registerButton.configuration?.imagePadding = 8
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        registerButton.layer.cornerRadius = 8
        registerButton.tintColor = .orange
        
        
        // Adicione os subviews e configure as constraints
        let stackView = UIStackView(arrangedSubviews: [nameTextField, nameErrorLabel, surnameTextField, surnameErrorLabel, emailTextField, emailErrorLabel, passwordTextField, passwordErrorLabel, confirmPasswordTextField, confirmPasswordErrorLabel, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(dividerView)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
    }
    
    func validateName(_ name: String) -> Bool {
        return name.count <= maxNameLength
    }
    
    func validateSurname(_ surname: String) -> Bool {
        return surname.count <= maxSurnameLength
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email.lowercased())
    }
    
    @objc func emailTextFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.lowercased()
    }
    
    func validatePassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    func validateConfirmPassword(_ password: String, _ confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
    
    func configureTextFields() {
        nameTextField.setPlaceholder(text: "Name", isMandatory: true)
        surnameTextField.setPlaceholder(text: "Surname", isMandatory: true)
        emailTextField.setPlaceholder(text: "Email", isMandatory: true)
        passwordTextField.setPlaceholder(text: "Password", isMandatory: true)
        confirmPasswordTextField.setPlaceholder(text: "Confirm Password", isMandatory: true)
    }
    
    func configureErrorLabels() {
        let errorLabels = [nameErrorLabel, surnameErrorLabel, emailErrorLabel, passwordErrorLabel, confirmPasswordErrorLabel]
        errorLabels.forEach { label in
            label.textColor = .red
            label.font = UIFont.systemFont(ofSize: 12)
            label.numberOfLines = 0
            label.isHidden = true
        }
    }
    
    @objc func registerButtonTapped(sender: UIButton) {
        didRegister()
    }
        
    private func didRegister() {
        var isValid = true
        
        guard let name = nameTextField.text, let surname = surnameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else {
            showAlert(message: "All fields are mandatory")
            return
        }
        
        if !validateName(name) {
            nameErrorLabel.isHidden = false
            nameErrorLabel.text = "Name must be at most 15 characters"
            isValid = false
        } else {
            nameErrorLabel.isHidden = true
        }
        
        if !validateSurname(surname) {
            surnameErrorLabel.isHidden = false
            surnameErrorLabel.text = "Surname must be at most 30 characters"
            isValid = false
        } else {
            surnameErrorLabel.isHidden = true
        }
        
        if !validateEmail(email) {
            emailErrorLabel.isHidden = false
            emailErrorLabel.text = "Email format is incorrect"
            isValid = false
        } else {
            emailErrorLabel.isHidden = true
        }
        
        if !validatePassword(password) {
            passwordErrorLabel.isHidden = false
            passwordErrorLabel.text = "Password must be at least 8 characters, with at least one uppercase letter, one lowercase letter, one number, and one special character"
            isValid = false
        } else {
            passwordErrorLabel.isHidden = true
        }
        
        if !validateConfirmPassword(password, confirmPassword) {
            confirmPasswordErrorLabel.isHidden = false
            confirmPasswordErrorLabel.text = "Passwords do not match"
            isValid = false
        } else {
            confirmPasswordErrorLabel.isHidden = true
        }
        
        if isValid {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    print("Error registering user: \(error.localizedDescription)")
                } else {
                    print("User registered successfully!")
                    
                    let alert = UIAlertController(title: nil, message: "User registered successfully!", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        alert.dismiss(animated: true, completion: nil)
                        
                        self.delegate?.didRegister()
                        clearFields()
                        
                    }
                }
                
            }
            
            func clearFields() {
                nameTextField.text = ""
                surnameTextField.text = ""
                emailTextField.text = ""
                passwordTextField.text = ""
                confirmPasswordTextField.text = ""
            }
            
        }
        
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UITextField {
    func setPlaceholder(text: String, color: UIColor = .systemGray3, isMandatory: Bool = false) {
        let placeholderText = isMandatory ? "\(text) *" : text
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: self.font ?? UIFont.systemFont(ofSize: 15),
            .baselineOffset: 0
        ]
        let attributedPlaceholder = NSMutableAttributedString(string: placeholderText, attributes: attributes)
        
        if isMandatory {
            attributedPlaceholder.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (placeholderText as NSString).range(of: "*"))
        }
        
        self.attributedPlaceholder = attributedPlaceholder
    }
}
