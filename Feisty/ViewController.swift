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

    @IBAction func loginPressed(_ sender: UIButton) {

        var message: String = "";
        var loggedIn = false;

        if txtUsername.text == "tiewhan" && txtPassword.text == "cat3" {
            message = "Welcome"
            loggedIn = true;
        }
        else{
            message = "Login Failed"
        }

        let alertController = UIAlertController(title: "Login Message", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        //self.present(alertController, animated: true, completion: nil)

        if loggedIn{
            performSegue(withIdentifier: "segToMain", sender: nil)
        }

    }
    
}

