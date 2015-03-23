//
//  CUProfileViewController.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/16/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@objc(CUProfileViewController) class CUProfileViewController: UIViewController
{    
    @IBOutlet weak var profileImageView: FBProfilePictureView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        userNameLabel.text = "\(CUAccountProfile.sharedInstance.firstName) \(CUAccountProfile.sharedInstance.lastName)"
        emailLabel.text = CUAccountProfile.sharedInstance.email
        profileImageView.profileID = CUAccountProfile.sharedInstance.facebookID
    }

    @IBAction func out(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
