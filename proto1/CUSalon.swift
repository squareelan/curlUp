//
//  CUSalon.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/3/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import Foundation
import UIKit    // UIImage
import CoreLocation // CLLocation

struct CUSalon {
    let images      : [UIImage]
    let hours       : [String: [String]]
    let name        : String
    let location    : CLLocation
    let address     : String
    let reviews     : [Any]
    let rating      : Double
    let phoneNumber : String
    let guid        : String
    let reservations: [CUReservation]
    let designers   : [CUDesigner]
}
