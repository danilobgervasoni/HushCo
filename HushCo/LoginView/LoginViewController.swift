//
//  ViewController.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 27/06/24.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?

    let loginView = LoginView()
    
    var onboardingViewController: OnboardingContainerViewController?
    
    var username: String? {
        return loginView.usernameTextField.text
    }

    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        style()
        layout()
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loginView.signInButton.configuration?.showsActivityIndicator = false
    }
}

extension LoginViewController {
    
    private func style() {
        
        loginView.signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        loginView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
    }
    
    private func layout() {
        view.addSubview(loginView)
        
        //LoginView
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: 20),
            view.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 20)
        ])
    }
}

// MARK: Actions
extension LoginViewController {
    @objc func registerButtonTapped(sender: UIButton) {
        let registrationVC = RegistrationViewController()
        navigationController?.pushViewController(registrationVC, animated: true)
    }

    
    @objc func signInTapped(sender: UIButton) {
        loginView.errorMessageLabel.isHidden = true
        login()
        
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }

       if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "Danilo" && password == "123" {
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message: String) {
        loginView.errorMessageLabel.isHidden = false
        loginView.errorMessageLabel.text = message
    }
}

extension LoginViewController: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded == true {
            let registrationViewController = RegistrationViewController()
            navigationController?.pushViewController(registrationViewController, animated: true)
        }  else {
            // Exemplo de chamada ao setRootViewController
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let onboardingViewController = OnboardingContainerViewController()
            appDelegate?.setRootViewController(onboardingViewController)
        }
        
    }
}
