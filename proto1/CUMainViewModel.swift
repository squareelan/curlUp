//
//  CUMainViewModel.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/9/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import Foundation

class CUMainViewModel: NSObject
{
    override init()
    {
        self.salonArray = CUSalonCollection.sharedInstance.salons
        super.init()
    }
    
    var salonArray: [CUSalon]
}