//
//  SignUpViewController.swift
//  Xcurrency
//
//  Created by MacBook AIR on 16/07/2023.
//

import UIKit

import UIKit

class SignupViewController: UIViewController,UITextFieldDelegate  {
    private let emailField: UITextField = {
    let field = UITextField()
    field.autocapitalizationType = .none
    field.autocorrectionType  = .no
    field.returnKeyType = .continue
    field.layer.cornerRadius = 12
    field.layer.borderWidth = 1
    field.layer.borderColor = UIColor.lightGray.cgColor
    field.placeholder = "Email Address"
    field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
    field.leftViewMode = .always
    field.textColor = .systemBlue
    field.translatesAutoresizingMaskIntoConstraints = false
  
     return field
}()

private let passwordField: UITextField = {
    let field = UITextField()
    field.autocapitalizationType = .none
    field.autocorrectionType  = .no
    field.returnKeyType = .continue
    field.layer.cornerRadius = 12
    field.layer.borderWidth = 1
    field.layer.borderColor = UIColor.lightGray.cgColor
    field.placeholder = "Password"
    field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
    field.leftViewMode = .always
    field.textColor = .systemBlue
    field.translatesAutoresizingMaskIntoConstraints = false
    
     return field
}()

private let signupButton:UIButton = {
    let button = UIButton()
    button.setTitle("Sign up", for: .normal)
    button.backgroundColor = UIColor(red: 0.32, green: 0.73, blue: 0.39, alpha: 1.0)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 12
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.masksToBounds = true
    
   return button
}()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(passwordField)
        view.addSubview(emailField)
        view.addSubview(signupButton)
        configure()
        signupButton.addTarget(self, action: #selector(CreateButtonTapped), for: .touchUpInside)
        passwordField.delegate = self
        emailField.delegate = self
       
    }
    
    private  func configure() {
       
          
          // Set emailField constraints
          NSLayoutConstraint.activate([
              emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
              emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
              emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
              emailField.heightAnchor.constraint(equalToConstant: 50)
          ])

          // Set passwordField constraints
          NSLayoutConstraint.activate([
              passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20), // Adjust the constant value as needed
              passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
              passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
              passwordField.heightAnchor.constraint(equalToConstant: 50)
          ])

          // Set loginButton constraints
          NSLayoutConstraint.activate([
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.topAnchor.constraint(equalTo:  passwordField.bottomAnchor, constant: 20),
            signupButton.widthAnchor.constraint(equalToConstant: 100),
            signupButton.heightAnchor.constraint(equalToConstant: 50)
            ])
      }
    
    @objc func CreateButtonTapped() {
        HapticManager.shared.vibrateForSelection()
        guard  !emailField.text!.isEmpty && !passwordField.text!.isEmpty && passwordField.text!.count >= 6  else {
            alertUserLoginError()
            return
        }
        
        AuthManager.shared.signup(email: emailField.text ?? "error", password: passwordField.text ?? "error") {[weak self ] check in
            if !check {
                self?.alertUserLoginError()
            }else {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                let vc = HamburgerViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present( vc, animated: false)
            }
        }
        
    }

    private  func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to create an Account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dimiss", style: .cancel))
        present(alert, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
       passwordField.resignFirstResponder()
        return true
    }
}

