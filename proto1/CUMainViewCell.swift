//
//  CUMainViewCell.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/12/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import Foundation
import UIKit

@objc(CUMainViewCell) class CUMainViewCell: UITableViewCell
{
    var name: String?
    var firstAvailableDate: String?
    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var cellNameLabel: UILabel!
    @IBOutlet var cellDateLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}