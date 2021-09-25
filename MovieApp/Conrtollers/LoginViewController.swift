//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 19.09.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var ref: DatabaseReference!


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var infoLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        infoLable.alpha = 0
        
        
        Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            if user != nil {
                //--------
//                print("authauthauthauthauth \(auth)")
//                print("useruseruseruseruseruser \(user?.uid)")
                //--------
                self?.navigationController?.pushViewController(MainViewController(), animated: true)
            }
        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    func errorInfoLable(withText text: String) {
        infoLable.text = text
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.infoLable.alpha = 1
        }) { [weak self] complete in
            self?.infoLable.alpha = 0
        }
        
    }

    
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            errorInfoLable(withText: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                self?.errorInfoLable(withText: "Error")
                return
            }
            
            if user != nil {
                self?.navigationController?.pushViewController(MainViewController(), animated: true)
                return
            }
            
            self?.errorInfoLable(withText: "User not found")
        })
    }
        
    
    @IBAction func registerTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", isPasswordValid(password) else {
            errorInfoLable(withText: "Info is incorrect")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] (authResult, error) in
            if error != nil {
                self?.errorInfoLable(withText: "Info is incorrect")
                return
            }
            guard error == nil, let user = authResult?.user else {
                print(error!.localizedDescription)
                //                print("fastPrintauthResultauthResultauthResult \(String(describing: authResult))")
                return
            }
            //            print("fastPrintuseruseruseruseruser \(user)")
            
            //            let userRef = self?.ref.child(user.uid)
            //            userRef?.setValue(user.email, forKey: "email")
        })
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }

}
