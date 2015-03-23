//
//  CUReservationViewController.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/12/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@objc(CUReservationViewController) class CUReservationViewController: UIViewController
{
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.datePicker.minimumDate = NSDate()
        
        self.statusLabel.text = "Choose your reservation time"
    
        var df = NSDateFormatter()
        df.dateStyle = .MediumStyle
        df.timeStyle = .NoStyle
        self.dateLabel.text = df.stringFromDate(self.datePicker.date)
        
        df.dateStyle = .NoStyle
        df.timeStyle = .ShortStyle
        self.timeLabel.text = df.stringFromDate(self.datePicker.date)
    }
    
    override func viewWillLayoutSubviews()
    {
        //adding top border for datePicker
        let topLineBorderForDatePicker = UIView(frame: CGRectMake(0, 0, self.datePicker.frame.size.width, 1))
        topLineBorderForDatePicker.backgroundColor = UIColor.blackColor()
        self.datePicker.addSubview(topLineBorderForDatePicker)
        
        //adding top border for confirmBtn
        let topLineBorderForConfirmBtn = UIView(frame: CGRectMake(0, 0, self.confirmBtn.frame.size.width, 1))
        topLineBorderForConfirmBtn.backgroundColor = UIColor.blackColor()
        self.confirmBtn.addSubview(topLineBorderForConfirmBtn)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmBtnPressed(sender: AnyObject)
    {
        let confirmationViewController = CUConfirmationViewController(viewController: self)
        confirmationViewController.reservationDate = self.dateLabel.text
        confirmationViewController.reservationTime = self.timeLabel.text
        self.presentViewController(confirmationViewController, animated: true, completion: nil)
    }
    @IBAction func datePickerValueChanged(sender: AnyObject)
    {
        self.statusLabel.text = " Your Reservation time"
        
        var df = NSDateFormatter()
        df.dateStyle = .MediumStyle
        df.timeStyle = .NoStyle
        self.dateLabel.text = df.stringFromDate(self.datePicker.date)
        
        df.dateStyle = .NoStyle
        df.timeStyle = .ShortStyle
        self.timeLabel.text = df.stringFromDate(self.datePicker.date)
    }
}
