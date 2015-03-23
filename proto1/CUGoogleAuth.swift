//
//  CUGoogleAuth.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/5/15.
//  Copyright (c) 2015 test. All rights reserved.
//

/*
Style

let d: [String: Int] = [String: Int]()
let a: [AnyObject] = [AnyObject]()
*/

class CUGoogleAuth: NSObject
{
    var auth: GTMOAuth2Authentication
    
    override init()
    {
        self.auth = GTMOAuth2Authentication()
        super.init()
    }
    
    class var sharedInstance: CUGoogleAuth
    {
        struct Singleton
        {
            static let _singleton: CUGoogleAuth = CUGoogleAuth()
        }
        return Singleton._singleton
    }
    
    // Note: must set GoogleAuth.ShareInstance.auth with object of type
    // GTMOAuth2Authentication after login before getting the Google profile info.
    //
    func getGoogleProfileInfoForUserID(fromUserID userID: String, fromHandler hander: () -> ())
    {
        let googlePlusService: GTLServicePlus = GTLServicePlus()
        googlePlusService.retryEnabled = true
        
        googlePlusService.authorizer = CUGoogleAuth.sharedInstance.auth
        let query: GTLQueryPlus = GTLQueryPlus.queryForPeopleGetWithUserId(userID) as GTLQueryPlus
        
        googlePlusService.executeQuery(query, completionHandler: {(ticket, person, error) -> Void in
            if let err = error as NSError!
            {
                println(("Error getting google profile for user ID: %@: %@", userID, error))
            }
            else
            {
                let _person: GTLPlusPerson = person as GTLPlusPerson
                let personDictionary: NSMutableDictionary = _person.JSON as NSMutableDictionary
                let googleID: String = personDictionary["id"] as String
                let nameDictionary: [String: String] = personDictionary["name"] as [String: String]
                let firstName: String = nameDictionary["givenName"] as String!
                let lastName: String = nameDictionary["familyName"] as String!
                let imageDictionary: [String: NSObject] = personDictionary["image"] as [String: NSObject]
                let imageURLString: String = imageDictionary["url"] as String!
                let imageURL: NSURL = NSURL(string: imageURLString)!
                let imageData: NSData = NSData(contentsOfURL: imageURL)!
                let image: UIImage = UIImage(data: imageData)!
                CUAccountProfile.sharedInstance.googleID = googleID
                CUAccountProfile.sharedInstance.firstName = firstName
                CUAccountProfile.sharedInstance.lastName = lastName
                CUAccountProfile.sharedInstance.images = []   // Empty array of UIImage
                CUAccountProfile.sharedInstance.images.append(image)
                hander()
            }
        })
    }
    
}

