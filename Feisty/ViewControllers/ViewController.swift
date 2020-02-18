//
//  ViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/04.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Changes the status bar style to lightstyle. Contrasts the dark theme of the app
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //When login is pressed authenticate and if valid move on
    @IBAction func loginPressed(_ sender: UIButton) {

        var message: String = ""
        var loggedIn = false

        if txtUsername.text == "tiewhan" && txtPassword.text == "cat3" {
            message = "Welcome"
            loggedIn = true
        } else {
            message = "Login Failed"
        }

        let alertController = UIAlertController(title: "Login Message", message: message, preferredStyle: .alert)

        if loggedIn {
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { _ in
                    self.moveToMainMenu()
                }))
        } else {
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        }

        self.present(alertController, animated: true, completion: nil)

    }

    func moveToMainMenu() {
        performSegue(withIdentifier: "segToMain", sender: nil)
    }

}
