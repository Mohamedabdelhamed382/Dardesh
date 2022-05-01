//
//  ViewController.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 30/04/2022.
//

import UIKit
import ProgressHUD

public enum Mode {
    case login
    case register
    case forgetPassword
}

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        setupBagroundTap()
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
        checkDataInput(mode: .forgetPassword)
    }
    
    @IBAction func resendEmailPressed(_ sender: UIButton) {
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        checkDataInput(mode: .register)
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
    private func isDataInputFor(mode: Mode) -> Bool {
        switch mode {
        case .login:
            return emailTextFieldOutlet.text != "" && passwordTextFieldOutlet.text != ""
        case .register:
            return emailTextFieldOutlet.text != "" && passwordTextFieldOutlet.text != "" && confirmPasswordTextFieldOutlet.text != ""
        case .forgetPassword:
            return emailTextFieldOutlet.text != ""
        }
    }
    
    //MARK: - Check Input Data Method
    private func checkDataInput(mode: Mode) {
        switch mode {
        case .login:
            break
        case .register:
            if isDataInputFor(mode: isLogin ? .login : .register) {
                print ("Data Input Correct")
                ProgressHUD.showSucceed("Data Input Correctlly")
                //MARK: - TODO LOGIN and REGISTER
                let email = emailTextFieldOutlet.text!.removingLeadingSpaces()
                let password = passwordTextFieldOutlet.text!.removingLeadingSpaces()
                if isLogin == false {
                    //Register
                    if passwordTextFieldOutlet.text == confirmPasswordTextFieldOutlet.text {
                        self.registerUser(email: email , password: password)
                    } else {
                        ProgressHUD.showError("Password Not Matched")
                    }
                } else {
                    //Login
                    self.loginUser(email: email , password: password)
                }
            } else {
                print ("all Fields is Required")
                ProgressHUD.showError("all Fields is Required")
            }
        case .forgetPassword:
            if isDataInputFor(mode: .forgetPassword) {
                ProgressHUD.showSucceed("Data Input Correctlly")
                //MARK: - TODO
                //ResetPassword
            } else {
                print ("all Fields is Required")
                ProgressHUD.showError("all Fields is Required")
            }
        }
    }
    //MARK: - Register User
    private func registerUser(email: String , password: String) {
        FUserListener.shared.registerUserWith(email: email , password: password) { error in
            if error == nil {
                ProgressHUD.showSucceed("Verification Has Been sent to your Email")
            } else {
                ProgressHUD.showError(error?.localizedDescription)
                print(error!)
            }
        }
    }

    //MARK: - Login User
    private func loginUser(email: String , password: String) {
        FUserListener.shared.loginUserWith(email: email, password: password) { error, isEmailVerified in
            if error == nil {
                if isEmailVerified {
                    //MARK: - TODO ChatApp
                    ProgressHUD.showSucceed("Done")
                } else {
                    ProgressHUD.showFailed("please Verified , chek your Email")
                }
            } else {
                ProgressHUD.showFailed(error?.localizedDescription)
            }
        }
    }

    //MARK: - Tap Gesture Recognizer
    private func setupBagroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(false)
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
