//
//  CUUtilities.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/16/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit

func getDataFromUrl(url:NSURL, completion: ((data: NSData?) -> Void))
{
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
        completion(data: NSData(data: data))
    }.resume()
}
