//
//  CUMainViewController.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/7/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@objc(CUMainViewController) class CUMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SWRevealViewControllerDelegate
{
    @IBOutlet weak var tableView: UITableView!
    private var model: CUMainViewModel!
    private var profile: CUAccountProfile!
    private var isLoggedIn: Bool = true

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let salonDict = CUSalonCollection.sharedInstance.getTestSalonsDictionary()
        CUSalonCollection.sharedInstance.salons = salonDict
        let logoutBtn = UIBarButtonItem(title: "Log Out", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("logout:"))
        self.navigationItem.rightBarButtonItem = logoutBtn
        
        let leftRevealButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon.png"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
        self.navigationItem.leftBarButtonItem = leftRevealButtonItem
        
        self.tableView .registerNib(UINib(nibName: "CUMainViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CUMainViewCell")

        self.title = "Main View"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        revealViewController()
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        self.profile = CUAccountProfile.sharedInstance
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.revealViewController().delegate = self
        self.model = CUMainViewModel()
        
        if self.tableView.indexPathForSelectedRow() != nil
        {
            self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: animated)
        }
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    //Same as dealloc in Objc
    deinit
    {
        println("CUMainViewController dealloc")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logout(sender: AnyObject)
    {
        self.isLoggedIn = !self.isLoggedIn
        
        //Facebook
        if FBSession.activeSession().state == FBSessionState.Open || FBSession.activeSession().state == FBSessionState.OpenTokenExtended
        {
            FBSession.activeSession().closeAndClearTokenInformation()
        }
        
        let alert: UIAlertView = UIAlertView(title: "Log Out", message: "You have successfully Logged out", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        self.profile.resetProfile()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
// Mark: - SWReveal Controller

    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition)
    {
        if position == FrontViewPosition.Right
        {
            self.view.userInteractionEnabled = false
        }
        else if position == FrontViewPosition.Left
        {
            self.view.userInteractionEnabled = true
        }
    }
    
// Mark: - Table View

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.model.salonArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellId = "CUMainViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as CUMainViewCell
        
        let salon = CUSalonCollection.sharedInstance.salons[indexPath.row]
        cell.cellNameLabel.text = salon.name
        cell.cellImageView.image = salon.images[0] as UIImage
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.navigationController?.pushViewController(CUSalonDetailViewController(), animated: true)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 126
    }
}
