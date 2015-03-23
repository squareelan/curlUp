//
//  CUSalonDetailViewController.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/4/15.
//  Copyright (c) 2015 test. All rights reserved.
//
//
//  CUSalonDetailViewController.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/3/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@objc(CUSalonDetailViewController) class CUSalonDetailViewController : UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, SWRevealViewControllerDelegate
{
    //define properties
    @IBOutlet var superView : UIView!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var panGestureRecognizer :
    UIPanGestureRecognizer!
    @IBOutlet weak var reservationBtn: UIButton!
    
    private var pageImages : [UIImage]!
    private var pageViews : [AnyObject]!
    private var newTableViewFrame : CGRect!
    private var originalTableViewFrame :CGRect!
    private var isTableViewMoved : Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.panGestureRecognizer.delegate = self
        self.revealViewController().delegate = self
        
        self.pageImages = [UIImage(named:"salon1.jpeg")!,UIImage(named:"salon2.jpeg")!,UIImage(named: "salon3.jpeg")!, UIImage(named: "salon4.jpeg")!, UIImage(named: "salon5.jpeg")!]
        
        self.navigationController!.interactivePopGestureRecognizer.enabled = false
        
        let pageCount = self.pageImages.count
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = pageCount
        self.pageViews = []
        for i in 0..<pageCount
        {
            self.pageViews.append(NSNull())
        }
        self.tableView .registerNib(UINib(nibName: "CUSalonDescriptionCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CUSalonDescriptionCell")
        self.tableView.scrollEnabled = false
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        
        if self.tableView.indexPathForSelectedRow() != nil
        {
            self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: animated)
        }
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        self.originalTableViewFrame = self.tableView.frame
        
        if self.isTableViewMoved
        {
            self.tableView.frame = self.newTableViewFrame
        }
        self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * CGFloat(pageImages.count), CGFloat(scrollView.frame.size.height))
        self.loadVisiblePages()
        
        //adding a top border for a reservationBtn
        let topLineBorder = UIView(frame: CGRectMake(0, 0, self.reservationBtn.frame.size.width, 1))
        topLineBorder.backgroundColor = UIColor.blackColor()
        self.reservationBtn.addSubview(topLineBorder)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
// MARK: - Paging Control
    
    private func loadVisiblePages()
    {
        // First, determine which page is currently visible
        let pageWidth : CGFloat = scrollView.frame.size.width
        
        let pageIndex : Int = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Update the page control
        self.pageControl.currentPage = pageIndex
        
        // Work out which pages you want to load
        let firstPage = pageIndex - 1
        let lastPage = pageIndex + 1
        
        // Purge anything before the first page
        for var i = 0; i < firstPage; i++
        {
            self.clearPage(i)
        }
        
        //Load pages in our range
        for i in firstPage...lastPage
        {
            self.loadPage(i)
        }
        
        //Purge anything after the last page
        for var i = lastPage+1; i<self.pageImages.count; i++
        {
            self.clearPage(i)
        }
    }
    
    private func loadPage(pageIndex : Int)
    {
        //checking for the range
        if pageIndex < 0 || pageIndex >= self.pageImages.count
        {
            return
        }
        
        if let pageView = self.pageViews[pageIndex] as? UIView
        {
            //do nothing
        }
        else
        {
            var frame : CGRect = self.scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(pageIndex)
            frame.origin.y = 0.0
            
            var newPageView : UIImageView = UIImageView(image: self.pageImages[pageIndex] as UIImage)
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame

            self.scrollView.addSubview(newPageView)
            self.pageViews[pageIndex] = newPageView
        }
    }
    
    private func clearPage(pageIndex : Int)
    {
        if pageIndex < 0 || pageIndex >= self.pageImages.count
        {
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = self.pageViews[pageIndex] as? UIView
        {
            pageView.removeFromSuperview()
            self.pageViews[pageIndex] = NSNull()
        }
    }
    
// MARK : - Scroll View
    
    func scrollViewDidScroll(scrollView : UIScrollView)
    {
        if scrollView == self.scrollView
        {
            self.loadVisiblePages()
        }
        
        /*****************************************************************************/
        /* if we want to have tableview go down with continuous swipe, uncomment it. */
        //    else
        //    {
        //        CGPoint velocity = [scrollView.panGestureRecognizer velocityInView:self.tableView];
        //        if (scrollView.contentOffset.y == 0 && velocity.y > 0)
        //        {
        //            [UIView animateWithDuration:0.3 delay:0
        //                                options:UIViewAnimationOptionCurveEaseOut
        //                             animations:
        //             ^{
        //                 self.newTableViewFrame = self.originalTableViewFrame;
        //                 self.tableView.frame = self.newTableViewFrame;
        //             }
        //                             completion:^(BOOL finished)
        //             {
        //                 self.tableView.scrollEnabled = NO;
        //                 self.isTableViewMoved = NO;
        //                 self.panGestureRecognizer.enabled =YES;
        //             }];
        //        }
        //     }
        /*****************************************************************************/
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
        if self.tableView == scrollView
        {
            let velocity : CGPoint = scrollView.panGestureRecognizer .velocityInView(self.tableView)
            if scrollView.contentOffset.y == 0 && velocity.y > 0
            {
                UIView .animateWithDuration(0.3, delay: 0, options:UIViewAnimationOptions.CurveEaseInOut,
                    animations:
                    {
                        self.newTableViewFrame = self.originalTableViewFrame
                        self.tableView.frame = self.newTableViewFrame
                    },
                    completion:
                    {
                        (finshed:Bool) in
                        self.tableView.scrollEnabled = false
                        self.isTableViewMoved = false
                        self.panGestureRecognizer.enabled = true
                    }
                )
            }
        }
    }


// MARK : - Table View

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "CUSalonDescriptionCell"
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView : UIView = UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, 60))
        headerView.backgroundColor = UIColor.grayColor()
        
        let label : UILabel = UILabel(frame: CGRectMake(10, 0, self.tableView.frame.size.width, 17))
        label.text = "description"
        label.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        
        headerView.addSubview(label)
        headerView.clipsToBounds = true
        return headerView
    }

//MARK : - Gesture Recognizer
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
  
    @IBAction func swipeTableView(sender: UIPanGestureRecognizer)
    {
        if sender.state == UIGestureRecognizerState.Changed
        {
            let velocity: CGPoint = sender.velocityInView(self.tableView)
            if !self.isTableViewMoved && velocity.y < 0
            {
                UIView .animateWithDuration(0.3, delay: 0, options:UIViewAnimationOptions.CurveEaseInOut,
                    animations:
                    {
                        self.newTableViewFrame = CGRectMake(0, 0, self.superView.frame.size.width, self.superView.frame.size.height - self.reservationBtn.frame.size.height)
                        self.tableView.frame = self.newTableViewFrame
                    },
                    completion:
                    {
                        (finished:Bool) in
                        self.tableView.scrollEnabled = true
                        self.isTableViewMoved = true
                        self.panGestureRecognizer.enabled = false
                    }
                )

            }
        }
    }
    
//Mark : - SWReveal Controller
    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition)
    {
        if position == FrontViewPosition.Right
        {
            self.view.userInteractionEnabled = false
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        else if position == FrontViewPosition.Left
        {
            self.view.userInteractionEnabled = true
            self.navigationItem.setHidesBackButton(false, animated: false)
        }
    }
    
//Mark : - Button Action
    
    @IBAction func reservationBtnPressed(sender: AnyObject)
    {
        let reservationViewController = CUReservationViewController()
        self.navigationController?.pushViewController(reservationViewController, animated: true)
    }
}
