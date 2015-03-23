//
//  CUSideBarViewTitleCell.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/16/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import Foundation
import UIKit

@objc(CUSideBarViewTitleCell) class CUSideBarViewTitleCell: UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
