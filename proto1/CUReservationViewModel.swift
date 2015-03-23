//
//  CUReservationViewModel.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 3/14/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

struct CUReservationCell
{
    var reservationTitle = ""
    var salonDefaultImage = UIImage()
    var reservationDateTime: NSDate
    {
        didSet  // Set the time and date strings when the NSDate is set
        {
            // Format and set time string
            let timeFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            timeFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            self.reservationTimeString = timeFormatter.stringFromDate(self.reservationDateTime)
            
            // Format and set date string
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMMM d, y"
            self.reservationDateString = dateFormatter.stringFromDate(self.reservationDateTime)
        }
    }
    var reservationTimeString = ""
    var reservationDateString = ""
    var salonAddress = ""
    var designerName = ""
}

class CUReservationViewModel
{
   var reservationCollection: [CUReservationCell]
    
    init()
    {
        self.reservationCollection = [CUReservationCell]()
    }
    
    func reset()
    {
        self.reservationCollection = [CUReservationCell]()
    }
}
