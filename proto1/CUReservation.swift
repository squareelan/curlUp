//
//  CUReservation.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/4/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import Foundation
import UIKit

struct CUReservation {
    let guid                : String
    let date                : NSDate
    let pictures            : [UIImage]
    let haircutDescription  : String
    let clientGuid          : String
    let clientEmail         : String
    let clientName          : String
    let clientPhoneNumber   : String
    let salonGuid           : String
    let designerGuid        : String
}