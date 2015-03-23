//
//  CUSignInViewController.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/18/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@objc(CUSignInViewController) class CUSignInViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var separatorLabel01: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var signingInLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var email = ""
    private var password = ""
    private var signInButtonIsEnabled: Bool = false
    {
        didSet
        {
            if self.signInButtonIsEnabled
            {
                self.signInButton.enabled = true
                self.signInButton.alpha = 1.0
            }
            else
            {
                self.signInButton.enabled = false
                self.signInButton.alpha = 0.5
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.signInButtonIsEnabled = false
        self.activityIndicator?.hidden = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("endEditing:")))
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signInButtonShouldBeEnabled() -> Bool
    {
        let enabled = self.email.utf16Count > 0 && self.password.utf16Count > 0
        return enabled
    }
    
    func hideUIAndEnableActivityIndicator(enabled: Bool)
    {
        self.emailTextField.hidden = enabled
        self.passwordTextField.hidden = enabled
        self.signInButton.hidden = enabled
        self.separatorLabel01.hidden = enabled
        self.signUpButton.hidden = enabled
        self.closeButton.hidden = enabled
        self.signingInLabel.hidden = !enabled
        self.activityIndicator.hidden = !enabled
        if (enabled)
        {
            self.activityIndicator.startAnimating()
        }
        else
        {
            self.activityIndicator.stopAnimating()
        }
        
    }
    
// Mark: - UITapGestureRecognizer

    func endEditing(sender: AnyObject)
    {
        self.view.endEditing(true)
    }
    
// Mark: - UIControl Events

    @IBAction func emailTextFieldTextDidChange(sender: AnyObject)
    {
        self.email = self.emailTextField.text
        self.signInButtonIsEnabled = self.signInButtonShouldBeEnabled()
    }

    @IBAction func passwordTextFieldTextDidChange(sender: AnyObject)
    {
        self.password = self.passwordTextField.text
        self.signInButtonIsEnabled = self.signInButtonShouldBeEnabled()
    }

// Mark: - Actions

    @IBAction func signUpButtonWasPressed(sender: AnyObject)
    {
        self.view.endEditing(true)
        self.navigationController?.pushViewController(CUCreateAccountViewController(), animated: true)
    }
    
    @IBAction func signInButtonWasPressed(sender: AnyObject)
    {
        self.view.endEditing(true)
        self.hideUIAndEnableActivityIndicator(true)
        // Simulate a network request by adding 1 second delay
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * dispatch_time_t(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue())
        {
            println("User signed in with email: \"\(self.email)\"")
            self.hideUIAndEnableActivityIndicator(false)
            CUAccountProfile.sharedInstance.email = self.email
            CUAccountProfile.sharedInstance.firstName = "Test"
            CUAccountProfile.sharedInstance.lastName = "Test"
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationController?.pushViewController(CUMainViewController(), animated: true)
        }
    }
    
    @IBAction func closeButtonWasPressed(sender: AnyObject)
    {
        self.view.endEditing(true)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
// Mark: - UITextFieldDelegate

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        switch textField
        {
            case self.emailTextField: self.passwordTextField.becomeFirstResponder()
            case self.passwordTextField: self.view.endEditing(true)
            default: break
        }
        return false
    }
}
