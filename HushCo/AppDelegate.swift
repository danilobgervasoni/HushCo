//
//  AppDelegate.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 27/06/24.
//

import UIKit
import Firebase

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MainViewControllerDelegate {
    
    var window: UIWindow?
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let navigationController = UINavigationController()
        let loginViewController = LoginViewController()
        navigationController.pushViewController(loginViewController, animated: false)
//        let registrationViewController = RegistrationViewController()
//        navigationController.pushViewController(registrationViewController, animated: false)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
//        window?.backgroundColor = .white
        
       showSplashScreen()
       //didLogin()
       //didRegister()
        
        return true
        
    }
    
    func showSplashScreen() {
            let splashViewController = SplashViewController()
            window?.rootViewController = splashViewController
            window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showLoginScreen()
        }
        
    }
    
    func showLoginScreen() {
            let loginViewController = LoginViewController()
            loginViewController.delegate = self
            setRootViewController(loginViewController)
            window?.rootViewController = loginViewController
            window?.makeKeyAndVisible()
        }
    
    func showMainScreen() {
            let mainViewController = MainViewController()
            setRootViewController(mainViewController)
            window?.rootViewController = mainViewController
            window?.makeKeyAndVisible()
        }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}


extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        let loginViewController = LoginViewController()
        setRootViewController(loginViewController)
        
        
         func showOnboardingScreen() {
            let onboardingViewController = OnboardingContainerViewController()
            setRootViewController(onboardingViewController)
        }
        
         func showMainScreen() {
            let mainViewController = MainViewController()
            setRootViewController(mainViewController)
        }
        
    }
    
//    extension AppDelegate: OnboardingContainerViewControllerDelegate {
//        func didFinishOnboarding() {
//            LocalState.hasOnboarded = true
//            showMainScreen()
//        }
//    }
//    

//    extension AppDelegate: LogoutDelegate {
//        func didLogout() {
//            showLoginScreen()
//        }
//    }
}
extension AppDelegate: RegistrationViewControllerDelegate {
    func didRegister() {
        DispatchQueue.main.async {
            // Verifique se o usuário já passou pelo onboarding
            if !LocalState.hasOnboarded {
                // Se não tiver passado pelo onboarding, configure e apresente a tela de onboarding
                let onboardingViewController = OnboardingViewController(coder: NSCoder())
                self.setRootViewController(onboardingViewController!)
                // Atualize o estado para indicar que o usuário já passou pelo onboarding
                LocalState.hasOnboarded = true
            } else {
                // Caso contrário, redirecione para a tela principal ou outra tela apropriada
                self.showMainScreen() // Implemente o método showMainScreen conforme necessário
            }
        }
    }
}
