//
//  CUAccountProfile.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/4/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit    // UIImage

@objc class CUAccountProfile: NSObject
{
    var firstName   : String
    var lastName    : String
    var userName    : String
    var email       : String
    var userID      : String
    var facebookID  : String
    var googleID    : String
    var images      : [UIImage]
    
    override init()
    {
        // Must initialize all variables
        self.firstName    = ""
        self.lastName     = ""
        self.userName     = ""
        self.email        = ""
        self.userID       = ""
        self.facebookID   = ""
        self.googleID     = ""
        self.images       = [UIImage()]
        super.init()
    }

    class var sharedInstance: CUAccountProfile
    {
        struct Singleton
        {
            static let _singleton: CUAccountProfile = CUAccountProfile()
        }
        return Singleton._singleton
    }
    
    func resetProfile()
    {
        self.firstName    = ""
        self.lastName     = ""
        self.userName     = ""
        self.email        = ""
        self.userID       = ""
        self.facebookID   = ""
        self.googleID     = ""
        self.images       = [UIImage()]
    }
}
