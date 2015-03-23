//
//  CUReservationTableViewCell.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 3/2/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

@objc(CUReservationTableViewCell) class CUReservationTableViewCell: UITableViewCell
{
    @IBOutlet weak var reservationTitleLabel: UILabel!
    @IBOutlet weak var salonDefaultImageView: UIImageView!
    @IBOutlet weak var reservationDateTimeLabel: UILabel!
    @IBOutlet weak var salonAddressLabel: UILabel!
    @IBOutlet weak var designerNameLabel: UILabel!

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
}
