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
            let mainViewController = MainViewController()
            showMainScreen()
        } else {
            showOnboardingScreen()
        }
    }
    
    private func showOnboardingScreen() {
        let onboardingViewController = OnboardingContainerViewController()
        setRootViewController(onboardingViewController)
    }
    
    private func showMainScreen() {
        let mainViewController = MainViewController()
        mainViewController.delegate = self
        setRootViewController(mainViewController)
    }
    
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        showMainScreen()
    }
}

extension AppDelegate: RegistrationViewControllerDelegate {
    func didRegister() {
        DispatchQueue.main.async {
            let onboardingViewController = OnboardingContainerViewController()
            self.setRootViewController(onboardingViewController)
        }
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        showLoginScreen()
    }
}
