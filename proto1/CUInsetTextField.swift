//
//  CUInsetTextField.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

class CUInsetTextField: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func textRectForBounds(bounds: CGRect) -> CGRect
    {
        return CGRectInset(bounds, 15, 15)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect
    {
        return CGRectInset(bounds, 15, 15)
    }

}
