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
//        self.loginButton.backgroundColor = .systemGray
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.emailTextField.placeholder = "Email"
        self.passwordTextField.placeholder = "Password"
        // Bind inputs to ViewModel
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
        let  postsVC = self.storyboard?.instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
//      let postsVC = PostsViewController()
        self.navigationController?.pushViewController(postsVC, animated: true)
        }
    
    //MARK: Action
    @IBAction func loginButtonAction(_ sender: Any) {
        
    }
}

