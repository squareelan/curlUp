//
//  CULoginViewModel.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 3/3/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@objc(CULoginViewModel) class CULoginViewModel: NSObject
{
    var email = ""
    var password = ""
    
    func reset()
    {
        self.email = ""
        self.password = ""
    }
}