//
//  ViewController.swift
//  Sign In With Apple
//
//  Created by Meet Ratanpara on 17/01/20.
//  Copyright © 2020 Meet Ratanpara. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    @IBOutlet weak var vwUserDetail: UIView!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblLabelFirst: UILabel!
    @IBOutlet weak var lblFirstname: UILabel!
    @IBOutlet weak var lblLabelLast: UILabel!
    @IBOutlet weak var lblLastname: UILabel!
    @IBOutlet weak var lblLabelEmail: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.checkStatusOfAppleSignIn()
        self.vwUserDetail.isHidden = true
        self.setupAppleSignInButton()
    }
    
    func checkStatusOfAppleSignIn()
    {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "\(UserDefaults.standard.value(forKey: "User_AppleID")!)") { (credentialState, error) in
            
            switch credentialState {
            case .authorized:
                self.setupUserInfoAndOpenView()
                break
            default:
                break
            }
        }
    }
    
    func setupAppleSignInButton()
    {
        let objASAuthorizationAppleIDButton = ASAuthorizationAppleIDButton()
        objASAuthorizationAppleIDButton.frame = CGRect(x: 20, y: (UIScreen.main.bounds.size.height - 70), width: (UIScreen.main.bounds.size.width - 40), height: 50)
        objASAuthorizationAppleIDButton.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
        self.view.addSubview(objASAuthorizationAppleIDButton)
    }
    
    @objc func actionHandleAppleSignin()
    {
        DispatchQueue.main.async {
            
            self.vwUserDetail.isHidden = true
            
            self.lblID.text = ""
            self.lblFirstname.text = ""
            self.lblLastname.text = ""
            self.lblEmail.text = ""
        }
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
}

extension ViewController : ASAuthorizationControllerDelegate
{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization)
    {
        switch authorization.credential {
            
        case let credentials as ASAuthorizationAppleIDCredential:
            DispatchQueue.main.async {
                
                if "\(credentials.user)" != "" {

                    UserDefaults.standard.set("\(credentials.user)", forKey: "User_AppleID")
                }
                if credentials.email != nil {

                    UserDefaults.standard.set("\(credentials.email!)", forKey: "User_Email")
                }
                if credentials.fullName!.givenName != nil {

                    UserDefaults.standard.set("\(credentials.fullName!.givenName!)", forKey: "User_FirstName")
                }
                if credentials.fullName!.familyName != nil {

                    UserDefaults.standard.set("\(credentials.fullName!.familyName!)", forKey: "User_LastName")
                }
                UserDefaults.standard.synchronize()
                self.setupUserInfoAndOpenView()
            }
            
        case let credentials as ASPasswordCredential:
            DispatchQueue.main.async {
            
                if "\(credentials.user)" != "" {

                    UserDefaults.standard.set("\(credentials.user)", forKey: "User_AppleID")
                }
                if "\(credentials.password)" != "" {

                    UserDefaults.standard.set("\(credentials.password)", forKey: "User_Password")
                }
                UserDefaults.standard.synchronize()
                self.setupUserInfoAndOpenView()
            }
            
        default :
            let alert: UIAlertController = UIAlertController(title: "Apple Sign In", message: "Something went wrong with your Apple Sign In!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            break
        }
    }
    
    func setupUserInfoAndOpenView()
    {
        DispatchQueue.main.async {
            
            self.vwUserDetail.isHidden = false
            
            if "\(UserDefaults.standard.value(forKey: "User_FirstName")!)" != "" || "\(UserDefaults.standard.value(forKey: "User_LastName")!)" != "" || "\(UserDefaults.standard.value(forKey: "User_Email")!)" != "" {

                self.lblID.text = "\(UserDefaults.standard.value(forKey: "User_AppleID")!)"
                self.lblFirstname.text = "\(UserDefaults.standard.value(forKey: "User_FirstName")!)"
                self.lblLastname.text = "\(UserDefaults.standard.value(forKey: "User_LastName")!)"
                self.lblEmail.text = "\(UserDefaults.standard.value(forKey: "User_Email")!)"
            } else {

                self.lblID.text = "\(UserDefaults.standard.value(forKey: "User_AppleID")!)"
                self.lblFirstname.text = "\(UserDefaults.standard.value(forKey: "User_Password")!)"
                
                self.lblLabelFirst.text = "Apple Password"
                
                self.lblLabelLast.isHidden = true
                self.lblLabelEmail.isHidden = true
            }
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error)
    {
        let alert: UIAlertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController : ASAuthorizationControllerPresentationContextProviding
{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor
    {
        return view.window!
    }
}
