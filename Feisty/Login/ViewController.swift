//
//  ViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/04.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit
import CommonFiles

class ViewController: UIViewController {

  @IBOutlet weak var btnLogin: UIButton!
  @IBOutlet weak var txtUsername: UITextField!
  @IBOutlet weak var txtPassword: UITextField!
  
  private lazy var viewModel: LoginViewModel = {
    return LoginViewModel(withView: self)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let colour = UIColor(red: 240, green: 240, blue: 240, alpha: 1)
    let stringColour = [NSAttributedString.Key.foregroundColor: colour]
    
    txtUsername.attributedPlaceholder = NSAttributedString(string: "Username",
                                                           attributes: stringColour)
    txtPassword.attributedPlaceholder = NSAttributedString(string: "Password",
                                                           attributes: stringColour)
    
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }

  //When login is pressed authenticate and if valid move on
  @IBAction func loginPressed(_ sender: UIButton) {
    
    guard let username = txtUsername.text else {
      return
    }
    
    guard let password = txtPassword.text else {
      return
    }
    
    viewModel.attemptLogin(with: username, and: password)
    
  }

  func moveToMainMenu() {
    
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "segToMain", sender: nil)
    }
    
  }

}

extension ViewController: LoginType {
  
  func authenticationSuccess() {
    self.moveToMainMenu()
  }
  
  func authenticationFailure() {
    
    createAndShowAlert(message: "Failed To Log In") { _ in }
    
  }
  
  func createAndShowAlert(message: String, handler: @escaping((UIAlertAction) -> Void)) {
    
    let alertController = UIAlertController(title: "Login Message", message: "", preferredStyle: .alert)
    alertController.message = message
    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: handler))
    self.present(alertController, animated: true, completion: nil)
    
  }
  
}
