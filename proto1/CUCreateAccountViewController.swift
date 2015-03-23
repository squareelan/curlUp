//
//  CreateAccountViewController.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/17/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@objc(CUCreateAccountViewController) class CUCreateAccountViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var createAccountLabel: UILabel!
    private var firstName = ""
    private var lastName = ""
    private var email = ""
    private var password = ""
    private var confirmPassword = ""
    private var createButtonIsEnabled: Bool = false
    {
        didSet
        {
            if self.createButtonIsEnabled
            {
                self.createButton.enabled = true
                self.createButton.alpha = 1.0
            }
            else
            {
                self.createButton.enabled = false
                self.createButton.alpha = 0.5
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.createButtonIsEnabled = false
        self.title = "Create Account"
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("endEditing:")))
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        self.navigationController?.navigationBar.translucent = false
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
//        self.navigationController?.navigationBar.translucent = true
    }
    
    func createButtonShouldBeEnabled() -> Bool
    {
        let enabled = self.firstName.utf16Count > 0
                   && self.lastName.utf16Count > 0
                   && self.email.utf16Count > 0
                   && self.password.utf16Count > 0
                   && self.confirmPassword.utf16Count > 0
        
        return enabled
    }
    
    func hideUIAndEnableActivityIndicator(enabled: Bool)
    {
        self.firstNameTextField.hidden = enabled
        self.lastNameTextField.hidden = enabled
        self.emailTextField.hidden = enabled
        self.passwordTextField.hidden = enabled
        self.confirmPasswordTextField.hidden = enabled
        self.createButton.hidden = enabled
        self.createAccountLabel.hidden = !enabled
        self.activityIndicator.hidden = !enabled
        if enabled
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

    @IBAction func firstNameTextFieldTextDidChange(sender: AnyObject)
    {
        self.firstName = self.firstNameTextField.text
        self.createButtonIsEnabled = self.createButtonShouldBeEnabled()
    }
    @IBAction func lastNameTextFieldTextDidChange(sender: AnyObject)
    {
        self.lastName = self.lastNameTextField.text
        self.createButtonIsEnabled = self.createButtonShouldBeEnabled()
    }
    @IBAction func emailTextFieldTextDidChange(sender: AnyObject)
    {
        self.email = self.emailTextField.text
        self.createButtonIsEnabled = self.createButtonShouldBeEnabled()
    }
    @IBAction func passwordTextFieldTextDidChange(sender: AnyObject)
    {
        self.password = self.passwordTextField.text
        self.createButtonIsEnabled = self.createButtonShouldBeEnabled()
    }
    @IBAction func confirmPasswordTextFieldDidChange(sender: AnyObject)
    {
        self.confirmPassword = self.confirmPasswordTextField.text
        self.createButtonIsEnabled = self.createButtonShouldBeEnabled()
    }
    
// Mark: - Actions

    @IBAction func createButtonPressed(sender: AnyObject)
    {
        self.view.endEditing(true)
        self.hideUIAndEnableActivityIndicator(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        // Simulate a network request by adding 1 second delay
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * dispatch_time_t(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue())
        {
            println("User created account with first name: \"\(self.firstName)\" last name: \"\(self.lastName)\" email: \"\(self.email)\"")
            self.hideUIAndEnableActivityIndicator(false)
            CUAccountProfile.sharedInstance.firstName = self.firstName
            CUAccountProfile.sharedInstance.lastName = self.lastName
            CUAccountProfile.sharedInstance.email = self.email
            let alert = UIAlertView(title: "Welcome to Curl Up!", message: "Please enjoy hair salon RSVP bliss.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            self.navigationController?.pushViewController(CUMainViewController(), animated: true)
        }
    }
    
// Mark: - UITextFieldDelegate

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        switch textField
        {
            case self.firstNameTextField: self.lastNameTextField.becomeFirstResponder()
            case self.lastNameTextField: self.emailTextField.becomeFirstResponder()
            case self.emailTextField: self.passwordTextField.becomeFirstResponder()
            case self.passwordTextField: self.confirmPasswordTextField.becomeFirstResponder()
            case self.confirmPasswordTextField: self.view.endEditing(true)
            default: break
        }
        return false
    }
}
