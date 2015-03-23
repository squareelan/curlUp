//
//  CUConfirmationViewController.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/15/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@objc(CUConfirmationViewController) class CUConfirmationViewController: UIViewController
{
    @IBOutlet weak var reservationDateLabel: UILabel!
    @IBOutlet weak var reservationTimeLabel: UILabel!
    var parentVC: UIViewController!
    var reservationDate: String?
    var reservationTime: String?
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewController: UIViewController)
    {
        self.parentVC = viewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.reservationDateLabel.text = self.reservationDate
        self.reservationTimeLabel.text = self.reservationTime
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func confirmBtnPressed(sender: AnyObject)
    {
        let alert: UIAlertView = UIAlertView(title: "Succeeded", message: "You have successfully made a reservation", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        
        self.dismissViewControllerAnimated(true, completion:
        {
            let viewControllers = self.parentVC.navigationController!.viewControllers as [UIViewController]
            let mainViewController = viewControllers[1]
            self.parentVC.navigationController?.popToViewController(mainViewController, animated: true)
        })
    }
    
    @IBAction func cancelBtnpressed(sender: AnyObject)
    {
        let alert: UIAlertView = UIAlertView(title: "Cancelled", message: "Your reservation is Cancelled", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
