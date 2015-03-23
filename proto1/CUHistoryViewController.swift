//
//  CUHistoryViewController.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/28/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@objc(CUHistoryViewController) class CUHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SWRevealViewControllerDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingHistoryLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var tableIsEditing = false
    var editModeIsEnabled = false
    
    private var networkActivityCount: Int = 0    // For use when making a network request
    {
        didSet
        {
            if self.networkActivityCount > 0
            {
                self.activityIndicator.startAnimating() // Start animating when we have network requests in progress
            }
            else
            {
                self.activityIndicator.stopAnimating()  // Stop animating when we have no more network requests
            }
        }
    }
    
    var model = CUHistoryViewModel()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set rounded corners for view
        self.loadingView.layer.masksToBounds = true
        self.loadingView.layer.cornerRadius = 5.0
        
        let rightNavigationBarButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("editHistory:"))
        self.navigationItem.rightBarButtonItem = rightNavigationBarButton
        
        let leftNavigationBarButton = UIBarButtonItem(title: "Main Menu", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("popToMainMenu:"))
        self.navigationItem.leftBarButtonItem = leftNavigationBarButton
        
        self.setRightBarButtonTitle()
        
        self.tableView.registerNib(UINib(nibName: "CUReservationTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CUReservationTableViewCell")

        self.title = "History"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Clear row selection
        if let indexPath = self.tableView.indexPathForSelectedRow()
        {
              self.tableView.deselectRowAtIndexPath(indexPath, animated: animated)
        }
        
        // TODO use cached request if consecutive requests are made in quick succession
        // If we don't have history loaded, simulate a network request by adding 1 second delay
        if self.model.historyCollection.count == 0
        {
            self.loadingHistoryLabel.hidden = false
            self.setActivitySpinnerHidden(false)
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * dispatch_time_t(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue())
            {
                self.loadingHistoryLabel.hidden = true
                self.setActivitySpinnerHidden(true)
                for var i = 0; i < CUSalonCollection.sharedInstance.salons.count; ++i
                {
                    let salon = CUSalonCollection.sharedInstance.salons[i]
                    // Must fully init struct
                    var history = CUHistory(reservationTitle: "", salonDefaultImage: UIImage(), reservationDateTime: NSDate(), reservationTimeString: "", reservationDateString: "", salonAddress: "", designerName: "")
                    // Set struct 
                    history.reservationTitle = salon.name
                    history.salonDefaultImage = salon.images[0]
                    history.reservationDateTime = salon.reservations[0].date    // Setting date time sets the time string and the date string -> see view model
                    history.salonAddress = salon.address
                    history.designerName = salon.designers[0].name
                    self.model.historyCollection.append(history)
                }
                
                self.tableView.setEditing(false, animated: false)
                self.revealViewController().delegate = self
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    func setActivitySpinnerHidden(hidden: Bool)
    {
        self.loadingView.hidden = hidden
        self.view.userInteractionEnabled = hidden  // Disable/enable controls
        if hidden
        {
            ++self.networkActivityCount
        }
        else
        {
            --self.networkActivityCount
        }
    }
    
    // Mark: - Actions
    
    func editHistory(sender: AnyObject)
    {
        if (self.model.historyCollection.count == 0) { return }    // If we don't have any salons in our history, don't toggle edit mode
        self.tableIsEditing = !self.tableIsEditing
        self.editModeIsEnabled = self.tableIsEditing
        self.tableView.setEditing(self.tableIsEditing, animated: true)
        
        if self.tableIsEditing
        {
            self.searchBar.userInteractionEnabled = false
            self.searchBar.alpha = 0.5
        }
        else
        {
            self.searchBar.userInteractionEnabled = true
            self.searchBar.alpha = 1.0
        }
        
        self.setRightBarButtonTitle()
    }
    
    func popToMainMenu(sender: AnyObject)
    {
        self.tableView.setEditing(false, animated: false)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Mark: - UI Helpers
    
    func setRightBarButtonTitle()
    {
        if self.tableIsEditing
        {
            self.editModeIsEnabled = true
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }
        else
        {
            self.editModeIsEnabled = false
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
    }
    
    // Mark: - Table View
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath)
    {
        self.tableIsEditing = true
        self.setRightBarButtonTitle()
        self.editModeIsEnabled = false
        self.tableView.setEditing(self.tableIsEditing, animated: true)
    }
    
    func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath)
    {
        self.tableIsEditing = false
        self.setRightBarButtonTitle()
        self.tableView.setEditing(self.tableIsEditing, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if cell.respondsToSelector(Selector("setSeparatorInset:"))
        {
            cell.separatorInset = UIEdgeInsetsZero
        }
        if cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:"))
        {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        if cell.respondsToSelector(Selector("setLayoutMargins:"))
        {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle
    {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete && !self.editModeIsEnabled
        {
            self.tableIsEditing = false
            self.tableView.setEditing(self.tableIsEditing, animated: true)
        }
        
        self.model.historyCollection.removeAtIndex(indexPath.row)
        
        if self.model.historyCollection.count == 0
        {
            self.editModeIsEnabled = false
            self.tableIsEditing = false
            self.tableView.setEditing(self.tableIsEditing, animated: true)
        }
        
        self.setRightBarButtonTitle()
        
        self.tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.model.historyCollection.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellId = "CUReservationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as CUReservationTableViewCell
        
        let i = indexPath.row
        
        let salon = self.model.historyCollection[i]
        cell.reservationTitleLabel.text = "\(salon.reservationTitle)"
        cell.salonDefaultImageView.image = salon.salonDefaultImage as UIImage
        cell.reservationDateTimeLabel.text = "\(salon.reservationDateString)\n@ \(salon.reservationTimeString)"
        cell.salonAddressLabel.text = "\(salon.salonAddress)"
        cell.designerNameLabel.text = "\(salon.designerName)"
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
