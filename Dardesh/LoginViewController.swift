//
//  ViewController.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 30/04/2022.
//

import UIKit
import SwiftUI

public enum Mode {
    case login
    case register
    case forgetPassword
}

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        
    }

    //MARK: - variables
    var isLogin: Bool = false
    
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
    
    //button Outlet
    @IBOutlet weak var forgetPasswordOutlet: UIButton!
    @IBOutlet weak var resendEmailOutlet: UIButton!
    @IBOutlet weak var registerOutlet: UIButton!
    @IBOutlet weak var loginOutlet: UIButton!
    
    //MARK: - IBAction
    @IBAction func forgetPasswordPressed(_ sender: UIButton) {
        if isDataInputFor(mode: .forgetPassword) {
            print ("Data Input Correct")
            //MARK: - TODO
            //ResetPassword
        } else {
            print ("Print all Fields All Required")
        }
    }
    
    @IBAction func resendEmailPressed(_ sender: UIButton) {
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if isDataInputFor(mode: isLogin ? .login : .register) {
            print ("Data Input Correct")
            //MARK: - TODO
            //LOGIN OR REGISTER
        } else {
            print ("Print all Fields All Required")
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        updateUIMode(mode: isLogin)
    }
    
    //MARK: - Methods
    
    private func updateUIMode(mode: Bool) {
        let titleMode: String = !mode ? "Login" : "Register"
        
        loginOutlet.setTitle(!mode ? "Register" : "Login", for: .normal)
        registerOutlet.setTitle(titleMode, for: .normal)

        titleOutlet.text = titleMode
        haveAnAccountLabelOutlet.text = !mode ? "New Here?" : "Have an Account?"
        
        
        confirmPasswordLabelOutlet.isHidden = !mode ? true : false
        confirmPasswordTextFieldOutlet.isHidden = !mode ? true : false
        forgetPasswordOutlet.isHidden = mode ? true : false
        resendEmailOutlet.isHidden = !mode ? true : false

        isLogin.toggle()
    }
    

    //MARK: - Helper Method
    
    func isDataInputFor(mode: Mode) -> Bool {
        switch mode {
        case .login:
            return emailTextFieldOutlet.text != "" && passwordTextFieldOutlet.text != ""
        case .register:
            return emailTextFieldOutlet.text != "" && passwordTextFieldOutlet.text != "" && confirmPasswordTextFieldOutlet.text != ""
        case .forgetPassword:
            return emailTextFieldOutlet.text != ""
        }
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
