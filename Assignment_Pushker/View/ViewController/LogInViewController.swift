//
//  ViewController.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 11/03/25.
//

import UIKit
import RxSwift
import RxCocoa

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: IBOutlet
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.loginButton.isEnabled = false
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.emailTextField.placeholder = "Email"
        self.passwordTextField.placeholder = "Password"

        emailTextField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        
        // Enable button based on validation
        viewModel.isFormValid.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        // Handle button tap
        loginButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigateToPostsScreen()
        }).disposed(by: disposeBag)
    }
    
    func navigateToPostsScreen() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn") // Save login
        let  tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        navigationController?.setViewControllers([tabBarVC], animated: true)
        navigationController?.setViewControllers([tabBarVC], animated: true)
    }
    
    //MARK: Action
    @IBAction func loginButtonAction(_ sender: Any) {}
}

