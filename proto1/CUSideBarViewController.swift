//
//  CUSideBarViewController.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/8/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import Foundation
import UIKit

@objc(CUSideBarViewController) class CUSideBarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    private let menuItems = ["curlUp","Profile","History","Reservation", "Settings"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView .registerNib(UINib(nibName: "CUSideBarViewTitleCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CUSideBarViewTitleCell")
        self.tableView .registerNib(UINib(nibName: "CUSideBarViewItemCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CUSideBarViewItemCell")
    }
    
    override func viewWillAppear(animated: Bool)
    {
        if self.tableView.indexPathForSelectedRow() != nil
        {
            self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: animated)
        }
    }
    
    override func viewWillLayoutSubviews()
    {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 40
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.separatorColor = UIColor.whiteColor()

        return self.menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cellId: String!
        if indexPath.row == 0
        {
            cellId = "CUSideBarViewTitleCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as UITableViewCell
            return cell
        }
        else
        {
            cellId = "CUSideBarViewItemCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as CUSideBarViewItemCell
            cell.titleLabel.text = self.menuItems[indexPath.row]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch indexPath.row
        {
        case 1: let vc = CUProfileViewController()
                self.presentViewController(vc, animated: true, completion: {
                    self.revealViewController().setFrontViewPosition(FrontViewPosition.Left, animated: false)
                })
        case 2: let vc = CUHistoryViewController()
                let mainViewController = CUMainViewController()
                let navigationController = UINavigationController(rootViewController: vc)
                let revealController = SWRevealViewController(rearViewController: mainViewController, frontViewController: navigationController)
                self.presentViewController(revealController, animated: true, completion: {
                    self.revealViewController().setFrontViewPosition(FrontViewPosition.Left, animated: false)
                })
        case 3: let vc = CUSidebarReservationViewController()
                let mainViewController = CUMainViewController()
                let navigationController = UINavigationController(rootViewController: vc)
                let revealController = SWRevealViewController(rearViewController: mainViewController, frontViewController: navigationController)
                self.presentViewController(revealController, animated: true, completion: {
                    self.revealViewController().setFrontViewPosition(FrontViewPosition.Left, animated: false)
                })
        default: println("Not implemented")
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        //separator inset zero
        if cell.respondsToSelector("setSeparatorInset:")
        {
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:")
        {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        if cell.respondsToSelector("setLayoutMargins:")
        {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let bottomLineBorder = UIView(frame: CGRectMake(0, tableView.frame.size.height-1, tableView.frame.size.width, 1))
        bottomLineBorder.backgroundColor = UIColor.whiteColor()
        return bottomLineBorder
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.5
    }
}
