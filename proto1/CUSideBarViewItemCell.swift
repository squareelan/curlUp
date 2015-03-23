//
//  CUSideBarViewItemCell.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/15/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import Foundation
import UIKit

@objc(CUSideBarViewItemCell) class CUSideBarViewItemCell: UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}