//
//  CULoginViewController.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/8/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

@objc(CULoginViewController) class CULoginViewController: UIViewController, UITextFieldDelegate, FBLoginViewDelegate
{
    // Button references
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    // Text Fields
    @IBOutlet weak var emailTextField: CUInsetTextField!
    @IBOutlet weak var passwordTextField: CUInsetTextField!
    
    // Loading view
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingFacebookProfileLabel: UILabel!
    @IBOutlet weak var creatingYourAccountLabel: UILabel!
    @IBOutlet weak var signingInWithCurlUpLabel: UILabel!
    
    // Facebook logo, for setting alpha
    @IBOutlet weak var facebookLogoImageView: UIImageView!
    
    // Labels
    @IBOutlet weak var createAccountConsentLabel: UILabel!
    
    // XIB Constraint references
    @IBOutlet weak var signInButtonTopConstraint: NSLayoutConstraint!
    
    // Frames
    @IBOutlet weak var signInButtonView: UIView!
    @IBOutlet weak var facebookLoginView: UIView!
    
    private var networkActivityCount: Int = 0    // For use when making a network request
    {
        didSet
        {
            if self.networkActivityCount > 0
            {
                self.activityIndicator.startAnimating() // Start animating when we have network requests in progress
            }
            else
            {
                self.activityIndicator.stopAnimating()  // Stop animating when we have no more network requests
            }
        }
    }
    
    private enum LoginMode  // For use when the Sign in/Create account toggle is pressed
    {
        case SignIn
        case CreateAccount
        
        init()
        {
            self = .SignIn  // Start in login mode
        }
    }
    private var loginMode = LoginMode()
    
    private var model = CULoginViewModel()  // Init model
    
    override func viewDidLoad()
    {        
        super.viewDidLoad()
        // Init
        self.setActivitySpinnerHidden(true)
        var networkActivityCount: Int = 0;
        
        // Dismiss keyboard when we get a press outside the text fields
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("endEditing:")))
        
        // Set rounded corners for views
        self.signInButton.layer.masksToBounds = true
        self.signInButton.layer.cornerRadius = 5.0
        self.loadingView.layer.masksToBounds = true
        self.loadingView.layer.cornerRadius = 5.0
        self.facebookLoginButton.layer.masksToBounds = true
        self.facebookLoginButton.layer.cornerRadius = 5.0
        
        // Set placeholder text color of textfields
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor(red: 0, green: 0, blue: 0, alpha: 1)])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor(red: 0, green: 0, blue: 0, alpha: 1)])
    }
    
    override func viewWillAppear(animated: Bool)
    {
		//test code for alamofire
		Alamofire.request(.GET, "http://localhost:3000/salons")
				 .responseJSON
		{
			(request, response, json, err) in
			print(json)
		}
		
		
        super.viewWillAppear(animated)
        // Init
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // If we are about to login to facebook, block UI
        if FBSession.activeSession().state == FBSessionState.Open
        {
            self.loadingFacebookProfileLabel.hidden = false
            self.setActivitySpinnerHidden(false)
            FBRequest.requestForMe().startWithCompletionHandler({(connection, user, error) -> Void in
                self.loadingFacebookProfileLabel.hidden = true
                self.setActivitySpinnerHidden(false)
                if error != nil
                {
                    // TODO handle error
                }
                else
                {
                    CUAccountProfile.sharedInstance.firstName = user.first_name
                    CUAccountProfile.sharedInstance.lastName = user.last_name
                    CUAccountProfile.sharedInstance.userName = "\(user.first_name) \(user.last_name)"
                    CUAccountProfile.sharedInstance.email = user.objectForKey("email") as String
                    CUAccountProfile.sharedInstance.facebookID = user.objectID
                    self.navigationController?.pushViewController(CUMainViewController(), animated: true)
                }
            })
        }
        else
        {
            self.loadingFacebookProfileLabel.hidden = true
            self.setActivitySpinnerHidden(true)
        }
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.model.reset()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setActivitySpinnerHidden(hidden: Bool)
    {
        self.loadingView.hidden = hidden
        self.view.userInteractionEnabled = hidden  // Disable/enable controls
        if hidden
        {
            ++self.networkActivityCount
        }
        else
        {
            --self.networkActivityCount
        }
    }
    
    func enableControls(enabled: Bool)
    {
        self.view.userInteractionEnabled = enabled
    }
    
// Mark: - UITapGestureRecognizer

    func endEditing(sender: AnyObject)
    {
        self.view.endEditing(true)
    }
    
// Mark: - UIControl Events

    @IBAction func emailTextFieldEditingChanged(sender: AnyObject)
    {
        self.model.email = self.emailTextField.text
    }

    @IBAction func passwordTextFieldEditingChanged(sender: AnyObject)
    {
        self.model.password = self.passwordTextField.text
    }
    
// Mark: Actions

    @IBAction func facebookLoginButtonPressed(sender: AnyObject)
    {
        self.facebookLogoImageView.alpha = 0.75
    }

    @IBAction func facebookLoginButtonReleased(sender: AnyObject)
    {
        self.facebookLogoImageView.alpha = 1
        if FBSession.activeSession().state == FBSessionState.Open ||
           FBSession.activeSession().state == FBSessionState.OpenTokenExtended
        {
            self.loadingFacebookProfileLabel.hidden = false
            self.setActivitySpinnerHidden(false)
            FBRequest.requestForMe().startWithCompletionHandler({(connection, user, error) -> Void in
                self.loadingFacebookProfileLabel.hidden = true
                self.setActivitySpinnerHidden(true)
                if error != nil
                {
                    // TODO handle error
                }
                else
                {
                    CUAccountProfile.sharedInstance.firstName = user.first_name
                    CUAccountProfile.sharedInstance.lastName = user.last_name
                    CUAccountProfile.sharedInstance.userName = "\(user.first_name) \(user.last_name)"
                    CUAccountProfile.sharedInstance.email = user.objectForKey("email") as String
                    CUAccountProfile.sharedInstance.facebookID = user.objectID
                    self.navigationController?.pushViewController(CUMainViewController(), animated: true)
                }
            })
        }
        else
        {
            self.loadingFacebookProfileLabel.hidden = false
            self.setActivitySpinnerHidden(false)
            FBSession.openActiveSessionWithReadPermissions(["email", "public_profile", "user_friends"], allowLoginUI: true, completionHandler: {(session, state, error) -> Void in
                self.loadingFacebookProfileLabel.hidden = true
                self.setActivitySpinnerHidden(true)
                let appDelegate = UIApplication.sharedApplication().delegate as CUAppDelegate
                appDelegate.sessionStateChanged(toSession: session, toState: state, withError: error)
            })
        }
    }
    
    @IBAction func facebookLoginButtonDragged(sender: AnyObject)
    {
        self.facebookLogoImageView.alpha = 1
    }
    
    @IBAction func signInButtonReleased(sender: AnyObject) {
        self.view.endEditing(true)
        
        switch self.loginMode
        {
            case LoginMode.SignIn: self.signInButtonReleasedInSignInMode()
            case LoginMode.CreateAccount: self.signInButtonReleasedInCreateAccountMode()
            default: break
        }
    }
    
    func signInButtonReleasedInSignInMode()
    {
        if (self.model.email.utf16Count == 0)
        {
            let alert: UIAlertView = UIAlertView(title: "Error: Email required", message: "Please enter your email address to sign in.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        if (self.model.password.utf16Count == 0)
        {
            let alert: UIAlertView = UIAlertView(title: "Error: Password required", message: "Please enter your password to sign in.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        self.signingInWithCurlUpLabel.hidden = false
        self.setActivitySpinnerHidden(false)
        // Simulate a network request by adding 1 second delay
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * dispatch_time_t(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue())
        {
            println("User signed in with email: \"\(self.model.email)\"")
            self.signingInWithCurlUpLabel.hidden = true
            self.setActivitySpinnerHidden(true)
            CUAccountProfile.sharedInstance.email = self.model.email
            CUAccountProfile.sharedInstance.firstName = "Test"
            CUAccountProfile.sharedInstance.lastName = "Test"
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationController?.pushViewController(CUMainViewController(), animated: true)
        }
    }
    
    func signInButtonReleasedInCreateAccountMode()
    {
        if (self.model.email.utf16Count == 0)
        {
            let alert: UIAlertView = UIAlertView(title: "Error: Email required", message: "Please enter the email address you want to associate with your account.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        if (self.model.password.utf16Count == 0)
        {
            let alert: UIAlertView = UIAlertView(title: "Error: Password required", message: "Please enter the password for your account.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        self.creatingYourAccountLabel.hidden = false
        self.setActivitySpinnerHidden(false)
        // Simulate a network request by adding 1 second delay
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * dispatch_time_t(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue())
        {
            println("User created account with email: \"\(self.model.email)\"")
            self.creatingYourAccountLabel.hidden = true
            self.setActivitySpinnerHidden(true)
            CUAccountProfile.sharedInstance.email = self.model.email
            let alert = UIAlertView(title: "Welcome to Curl Up!", message: "Please enjoy hair salon RSVP bliss.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            self.navigationController?.pushViewController(CUMainViewController(), animated: true)
            self.createAccountButtonPressedCreateAccountMode()
        }
    }
    
    @IBAction func createAccountButtonReleased(sender: AnyObject)
    {
        self.view.endEditing(true)
        switch self.loginMode
        {
            case LoginMode.SignIn: self.createAccountButtonPressedSignInMode()
            case LoginMode.CreateAccount: self.createAccountButtonPressedCreateAccountMode()
            default: break
        }
    }
    
    func createAccountButtonPressedSignInMode()
    {
        self.loginMode = LoginMode.CreateAccount
        self.createAccountConsentLabel.hidden = false
        self.signInButtonTopConstraint.constant += 40
        UIView.animateWithDuration(0.4, animations:
        {
            self.signInButton.titleLabel?.alpha = 0
            self.createAccountButton.titleLabel?.alpha = 0
            self.forgotPasswordButton.alpha = 0
            self.facebookLoginView.alpha = 0
            self.createAccountConsentLabel.alpha = 1
            self.signInButtonView.frame = CGRectMake(self.signInButtonView.frame.origin.x, self.signInButtonView.frame.origin.y+40, self.signInButtonView.frame.size.width, self.signInButtonView.frame.size.height)
        }, completion:
        {
        finished in
            self.signInButton.titleLabel?.alpha = 1
            self.createAccountButton.titleLabel?.alpha = 1
            self.forgotPasswordButton.hidden = true
            self.facebookLoginView.hidden = true
            self.createAccountButton.setTitle("Sign in", forState: UIControlState.Normal)
            self.signInButton.setTitle("Create account", forState: UIControlState.Normal)
            self.createAccountButton.hidden = false
        })
    }
    
    func createAccountButtonPressedCreateAccountMode()
    {
        self.loginMode = LoginMode.SignIn
        self.forgotPasswordButton.hidden = false
        self.facebookLoginView.hidden = false
        self.signInButtonTopConstraint.constant -= 40
        UIView.animateWithDuration(0.4, animations:
        {
            self.signInButton.titleLabel?.alpha = 0
            self.createAccountButton.titleLabel?.alpha = 0
            self.forgotPasswordButton.alpha = 1
            self.facebookLoginView.alpha = 1
            self.createAccountConsentLabel.alpha = 0
            self.signInButtonView.frame = CGRectMake(self.signInButtonView.frame.origin.x, self.signInButtonView.frame.origin.y-40, self.signInButtonView.frame.size.width, self.signInButtonView.frame.size.height)
        }, completion:
        {
        finished in
            self.signInButton.titleLabel?.alpha = 1
            self.createAccountButton.titleLabel?.alpha = 1
            self.createAccountConsentLabel.hidden = true
            self.forgotPasswordButton.hidden = false
            self.facebookLoginView.hidden = false
            self.createAccountButton.setTitle("Create a new account", forState: UIControlState.Normal)
            self.signInButton.setTitle("Sign in", forState: UIControlState.Normal)
        })
    }
    
    @IBAction func forgotPasswordButtonReleased(sender: AnyObject)
    {
        self.view.endEditing(true)
        let alert: UIAlertView = UIAlertView(title: "TODO", message: "Soon you will be able to enter your email in a form and a password recovery email will be sent to you.", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
// Mark: - UITextFieldDelegate

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        switch textField
        {
            case self.emailTextField: self.passwordTextField.becomeFirstResponder()
            case self.passwordTextField: self.signInButtonReleased(self.passwordTextField)
            default: break
        }
        return false
    }
}