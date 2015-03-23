//
//  CUDesigner.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/2/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import Foundation

struct CUDesigner {
    let guid                        : String
    let salonGuid                   : String
    let name                        : String
    let email                       : String
    let phoneNumber                 : String
    let defaultAvailableTimeSlots   : [String: [Bool]]
    let customAvaiableTimeSlots     : [Int: Bool]
}