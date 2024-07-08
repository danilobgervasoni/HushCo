//
//  AppDelegate.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 27/06/24.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        showSplashScreen()
        
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
        if LocalState.hasOnboarded {
            showMainScreen()
        } else {
            showOnboardingScreen()
        }
    }
    
    private func showOnboardingScreen() {
        let onboardingViewController = OnboardingContainerViewController()
        onboardingViewController.delegate = self
        setRootViewController(onboardingViewController)
    }
    
    private func showMainScreen() {
                let mainViewController = MainViewController()
                setRootViewController(mainViewController)
    }
    
    
//    private func showRegistrationScreen() {
//        let registrationViewController = RegistrationViewController()
//        setRootViewController(registrationViewController)
//    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        showMainScreen()
    }
}

extension AppDelegate: RegistrationViewControllerDelegate {
    func didlogin() {
        LocalState.hasOnboarded = true
        showMainScreen()
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        showLoginScreen()
    }
}

//extension AppDelegate {
//    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
//        guard animated, let window = self.window else {
//            self.window?.rootViewController = vc
//            self.window?.makeKeyAndVisible()
//            return
//        }
//
//        window.rootViewController = vc
//        window.makeKeyAndVisible()
//        UIView.transition(with: window,
//                          duration: 0.3,
//                          options: .transitionCrossDissolve,
//                          animations: nil,
//                          completion: nil)
//    }
//}




//extension AppDelegate: LoginViewControllerDelegate {
//    func didLogin() {
//        if LocalState.hasOnboarded {
//            let registrationViewController = RegistrationViewController()
//            setRootViewController(registrationViewController)
//        } else {
//            let onboardingViewController = OnboardingContainerViewController()
//            onboardingViewController.delegate = self
//            setRootViewController(onboardingViewController)
//        }
//    }
//}

//extension AppDelegate: OnboardingContainerViewControllerDelegate {
//    func didFinishOnboarding() {
//        LocalState.hasOnboarded = true
//        let registrationViewController = RegistrationViewController()
//        setRootViewController(registrationViewController)
//    }
//}
//
//extension AppDelegate: LogoutDelegate {
//    func didLogout() {
//        let loginViewController = LoginViewController()
//        loginViewController.delegate = self
//        setRootViewController(loginViewController)
//    }
//}


