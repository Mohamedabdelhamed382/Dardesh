//
//  ViewController.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 30/04/2022.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        
    }

    //MARK: - IBOutlets
    
    @IBOutlet weak var titleOutlet: UILabel!
    
    //title of textFields outlet
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var confirmPasswordLabelOutlet: UILabel!
    @IBOutlet weak var haveAnAccountLabelOutlet: UILabel!
    
    //textFields outlet
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var confirmPasswordTextFieldOutlet: UITextField!
    
    //MARK: - IBAction
    @IBAction func forgetPasswordPressed(_ sender: UIButton) {
    }
    @IBAction func resendEmailPressed(_ sender: UIButton) {
    }
    @IBAction func registerPressed(_ sender: UIButton) {
    }
    @IBAction func loginPressed(_ sender: UIButton) {
    }
    
}

//MARK: - TextFelid Delegate Extension

extension LoginViewController: UITextFieldDelegate {
    
    func configureDelegate() {
        emailTextFieldOutlet.delegate = self
        passwordTextFieldOutlet.delegate = self
        confirmPasswordTextFieldOutlet.delegate = self
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        emailLabelOutlet.text = emailTextFieldOutlet.hasText ? "Email" : ""
        passwordLabelOutlet.text = passwordTextFieldOutlet.hasText ? "Password" : ""
        confirmPasswordLabelOutlet.text = confirmPasswordTextFieldOutlet.hasText ? "Confirm Password" : ""
    }
    
    
}
