//
//  LoginViewController.swift
//  Parse Chat
//
//  Created by Jonathan Du on 1/29/18.
//  Copyright © 2018 Jonathan Du. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    

    @IBOutlet weak var usernameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    
    @IBAction func loginButton(_ sender: Any) {
            
            let username = usernameLabel.text ?? ""
            let password = passwordLabel.text ?? ""
            
            if username.isEmpty || password.isEmpty{
                let alertController = UIAlertController(title: "Error", message: "Username or Password is empty", preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                    
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                    return
                }
            }
            
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        // handle response here.
                        
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                        return
                    }
                } else {
                    print("User logged in successfully")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    // display view controller that needs to shown after successful login
                }
            }
    }
    

    @IBAction func signupButton(_ sender: Any) {
            // initialize a user object
            let newUser = PFUser()
            
            // set user properties
            newUser.username = usernameLabel.text ?? ""
            //newUser.email = emailLabel.text
            newUser.password = passwordLabel.text ?? ""
            
            if usernameLabel.text!.isEmpty || passwordLabel.text!.isEmpty{
                let alertController = UIAlertController(title: "Error", message: "Username or Password is empty", preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                    //return
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                    return
                }
            }
            
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        // handle response here.
                        
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                        return
                    }
                } else {
                    print("User Registered successfully")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)

                    // manually segue to logged in view
                }
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
