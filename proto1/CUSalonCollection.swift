//
//  CUSalonCollectio.swift
//  CurlUpMobileIOS
//
//  Created by Ian on 2/7/15.
//  Copyright (c) 2015 test. All rights reserved.
//

//
//  CUSalonCollection.swift
//  CurlUpMobileIOS
//
//  Created by Connor Reid on 2/2/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

@objc class CUSalonCollection: NSObject {
    var salons: [CUSalon]
    override init() {
        self.salons = [CUSalon]()
        super.init()
    }
    
    class var sharedInstance: CUSalonCollection {
        struct Singleton
        {
            static let _singleton: CUSalonCollection = CUSalonCollection()
        }
        return Singleton._singleton
    }
    
    // For Objc
    func set_g_Salons(fromDictionary objCDictionary: NSDictionary) {
        //        let decoder: NSCoder = NSCoder.alloc()
        //        let salons = decoder.decodeObjectOfClass(NSDictionary.self, forKey: "salons") as Dictionary<String, NSDictionary>
        let salonsDictionary: [String: NSDictionary] = objCDictionary as [String: NSDictionary]
        let salons: [String: NSDictionary] = salonsDictionary["salons"] as [String: NSDictionary]
        println(salons)
    }
    
    func g_Salons() -> NSDictionary {
        var dictionary: NSDictionary = NSDictionary.alloc()
        
        return dictionary
    }
    
    func objcSalonsDictionaryToSwiftSalonsDictionary(fromSalonsDictionary objcSalonsDictionary: Dictionary<String, NSObject>) -> Dictionary<String, Array<CUSalon>> {
        var salonsDictionary: [String: [CUSalon]] = [String: [CUSalon]]()
        return salonsDictionary
    }
    
    func _set_g_Salons(fromDictionary salonsDictionary: [CUSalon]) {
        CUSalonCollection.sharedInstance.salons = [CUSalon]()
        if let _salons: [CUSalon] = salonsDictionary as [CUSalon]? {
            for salon in _salons {
                CUSalonCollection.sharedInstance.salons.append(salon)
            }
        }
    }
    
    func getRandomDefaultTimeSlots() -> [Bool] {
        var defaultTimeSlots: [Bool] = [Bool]();
        
        var isAvailable = false;
        var tmp = (arc4random() % 30) + 1;
        if (tmp % 5 == 0)
        {
            isAvailable = true;
        }
        defaultTimeSlots.append(isAvailable);
        
        return defaultTimeSlots;
    }
    
    func getTestSalonsDictionary() -> [CUSalon] {
        let salons = [CUSalon(images        :[UIImage(named:"salon1.jpeg")!],
            hours         :["monday"    :["9:00AM", "6:00PM"],
                "tuesday"   :["9:00AM", "6:00PM"],
                "wednesday" :["9:00AM", "6:00PM"],
                "thursday"  :["9:00AM", "6:00PM"],
                "friday"    :["9:00AM", "6:00PM"],
                "saturday"  :["10:00AM", "5:00PM"],
                "sunday"    :["12:00PM", "4:00PM"]],
            name          :"박철 헤어",
            location      :CLLocation(latitude:30.513925,
                longitude:97.688555)!,
            address       :"111 Somewhere, USA",
            reviews       :[0],
            rating        :4.5,
            phoneNumber   :"512-555-5555",
            guid          :NSUUID().UUIDString,
            reservations  :[CUReservation(guid              :NSUUID().UUIDString,
                date              :NSDate(),
                pictures          :[UIImage(named: "salon1.jpeg")!],
                haircutDescription:"Two-Block",
                clientGuid        :NSUUID().UUIDString,
                clientEmail       :"client01@test.com",
                clientName        :"Client One",
                clientPhoneNumber :"555-555-5555",
                salonGuid         :NSUUID().UUIDString,
                designerGuid      :NSUUID().UUIDString)],
            designers     :[CUDesigner(guid                      :NSUUID().UUIDString,
                salonGuid                 :NSUUID().UUIDString,
                name                      :"Bobby Weave",
                email                     :"bobby@weave.test",
                phoneNumber               :"555-555-5555",
                defaultAvailableTimeSlots :["monday"     :getRandomDefaultTimeSlots() as [Bool],
                    "tuesday"    :getRandomDefaultTimeSlots() as [Bool],
                    "wednesday"  :getRandomDefaultTimeSlots() as [Bool],
                    "thursday"   :getRandomDefaultTimeSlots() as [Bool],
                    "friday"     :getRandomDefaultTimeSlots() as [Bool],
                    "saturday"   :getRandomDefaultTimeSlots() as [Bool],
                    "sunday"     :getRandomDefaultTimeSlots() as [Bool]],
                customAvaiableTimeSlots   :[1451635200:true])]),
            CUSalon(images        :[UIImage(named:"salon2.jpeg")!],
                hours         :["monday"      :["9:00AM", "6:00PM"],
                    "tuesday"     :["9:00AM", "6:00PM"],
                    "wednesday"   :["9:00AM", "6:00PM"],
                    "thursday"    :["9:00AM", "6:00PM"],
                    "friday"      :["9:00AM", "6:00PM"],
                    "saturday"    :["10:00AM", "5:00PM"],
                    "sunday"      :["12:00PM", "4:00PM"]],
                name          :"CNN 헤어",
                location      :CLLocation(latitude:30.513925,
                    longitude:97.688555)!,
                address       :"777 Seoul, Korea",
                reviews       :[0],
                rating        :4.5,
                phoneNumber   :"512-555-5555",
                guid          :NSUUID().UUIDString,
                reservations  :[CUReservation(guid              :NSUUID().UUIDString,
                    date              :NSDate(),
                    pictures          :[UIImage(named: "salon1.jpeg")!],
                    haircutDescription:"Two-Block",
                    clientGuid        :NSUUID().UUIDString,
                    clientEmail       :"client01@test.com",
                    clientName        :"Client One",
                    clientPhoneNumber :"555-555-5555",
                    salonGuid         :NSUUID().UUIDString,
                    designerGuid      :NSUUID().UUIDString)],
                designers     :[CUDesigner(guid                      :NSUUID().UUIDString,
                    salonGuid                 :NSUUID().UUIDString,
                    name                      :"Bobby Weave",
                    email                     :"bobby@weave.test",
                    phoneNumber               :"555-555-5555",
                    defaultAvailableTimeSlots :["monday"     :getRandomDefaultTimeSlots() as [Bool],
                        "tuesday"    :getRandomDefaultTimeSlots() as [Bool],
                        "wednesday"  :getRandomDefaultTimeSlots() as [Bool],
                        "thursday"  :getRandomDefaultTimeSlots() as [Bool],
                        "friday"    :getRandomDefaultTimeSlots() as [Bool],
                        "saturday"  :getRandomDefaultTimeSlots() as [Bool],
                        "sunday"    :getRandomDefaultTimeSlots() as [Bool]],
                    customAvaiableTimeSlots   :[1451635200:true])]),
            CUSalon(images        :[UIImage(named:"salon3.jpeg")!],
                hours         :["monday"    :["9:00AM", "6:00PM"],
                    "tuesday"   :["9:00AM", "6:00PM"],
                    "wednesday" :["9:00AM", "6:00PM"],
                    "thursday"  :["9:00AM", "6:00PM"],
                    "friday"    :["9:00AM", "6:00PM"],
                    "saturday"  :["10:00AM", "5:00PM"],
                    "sunday"    :["12:00PM", "4:00PM"]],
                name          :"박철 헤어",
                location      :CLLocation(latitude:30.513925,
                    longitude:97.688555)!,
                address       :"8844 Two-block Blvd",
                reviews       :[0],
                rating        :4.5,
                phoneNumber   :"512-555-5555",
                guid          :NSUUID().UUIDString,
                reservations  :[CUReservation(guid              :NSUUID().UUIDString,
                    date              :NSDate(),
                    pictures          :[UIImage(named: "salon1.jpeg")!],
                    haircutDescription:"Two-Block",
                    clientGuid        :NSUUID().UUIDString,
                    clientEmail       :"client01@test.com",
                    clientName        :"Client One",
                    clientPhoneNumber :"555-555-5555",
                    salonGuid         :NSUUID().UUIDString,
                    designerGuid      :NSUUID().UUIDString)],
                designers     :[CUDesigner(guid                      :NSUUID().UUIDString,
                    salonGuid                 :NSUUID().UUIDString,
                    name                      :"Bobby Weave",
                    email                     :"bobby@weave.test",
                    phoneNumber               :"555-555-5555",
                    defaultAvailableTimeSlots :["monday"    :getRandomDefaultTimeSlots() as [Bool],
                        "tuesday"   :getRandomDefaultTimeSlots() as [Bool],
                        "wednesday" :getRandomDefaultTimeSlots() as [Bool],
                        "thursday"  :getRandomDefaultTimeSlots() as [Bool],
                        "friday"    :getRandomDefaultTimeSlots() as [Bool],
                        "saturday"  :getRandomDefaultTimeSlots() as [Bool],
                        "sunday"    :getRandomDefaultTimeSlots() as [Bool]],
                    customAvaiableTimeSlots   :[1451635200:true])]),
            CUSalon(images        :[UIImage(named:"salon4.jpeg")!],
                hours         :["monday"    :["9:00AM", "6:00PM"],
                    "tuesday"   :["9:00AM", "6:00PM"],
                    "wednesday" :["9:00AM", "6:00PM"],
                    "thursday"  :["9:00AM", "6:00PM"],
                    "friday"    :["9:00AM", "6:00PM"],
                    "saturday"  :["10:00AM", "5:00PM"],
                    "sunday"    :["12:00PM", "4:00PM"]],
                name          :"박철 헤어",
                location      :CLLocation(latitude:30.513925,
                    longitude:97.688555)!,
                address       :"555 Five St.",
                reviews       :[0],
                rating        :4.5,
                phoneNumber   :"512-555-5555",
                guid          :NSUUID().UUIDString,
                reservations  :[CUReservation(guid              :NSUUID().UUIDString,
                    date              :NSDate(),
                    pictures          :[UIImage(named: "salon1.jpeg")!],
                    haircutDescription:"Two-Block",
                    clientGuid        :NSUUID().UUIDString,
                    clientEmail       :"client01@test.com",
                    clientName        :"Client One",
                    clientPhoneNumber :"555-555-5555",
                    salonGuid         :NSUUID().UUIDString,
                    designerGuid      :NSUUID().UUIDString)],
                designers     :[CUDesigner(guid                      :NSUUID().UUIDString,
                    salonGuid                 :NSUUID().UUIDString,
                    name                      :"Bobby Weave",
                    email                     :"bobby@weave.test",
                    phoneNumber               :"555-555-5555",
                    defaultAvailableTimeSlots :["monday"     :getRandomDefaultTimeSlots() as [Bool],
                        "tuesday"    :getRandomDefaultTimeSlots() as [Bool],
                        "wednesday"  :getRandomDefaultTimeSlots() as [Bool],
                        "thursday"   :getRandomDefaultTimeSlots() as [Bool],
                        "friday"     :getRandomDefaultTimeSlots() as [Bool],
                        "saturday"   :getRandomDefaultTimeSlots() as [Bool],
                        "sunday"     :getRandomDefaultTimeSlots() as [Bool]],
                    customAvaiableTimeSlots   :[1451635200:true])]),
            CUSalon(images        :[UIImage(named:"salon5.jpeg")!],
                hours         :["monday"      :["9:00AM", "6:00PM"],
                    "tuesday"     :["9:00AM", "6:00PM"],
                    "wednesday"   :["9:00AM", "6:00PM"],
                    "thursday"    :["9:00AM", "6:00PM"],
                    "friday"      :["9:00AM", "6:00PM"],
                    "saturday"    :["10:00AM", "5:00PM"],
                    "sunday"      :["12:00PM", "4:00PM"]],
                name          :"박철 헤어",
                location      :CLLocation(latitude:30.513925,
                    longitude:97.688555)!,
                address       :"333 Triple Rd.",
                reviews       :[0],
                rating        :4.5,
                phoneNumber   :"512-555-5555",
                guid          :NSUUID().UUIDString,
                reservations  :[CUReservation(guid              :NSUUID().UUIDString,
                    date              :NSDate(),
                    pictures          :[UIImage(named: "salon1.jpeg")!],
                    haircutDescription:"Two-Block",
                    clientGuid        :NSUUID().UUIDString,
                    clientEmail       :"client01@test.com",
                    clientName        :"Client One",
                    clientPhoneNumber :"555-555-5555",
                    salonGuid         :NSUUID().UUIDString,
                    designerGuid      :NSUUID().UUIDString)],
                designers     :[CUDesigner(guid                      :NSUUID().UUIDString,
                    salonGuid                 :NSUUID().UUIDString,
                    name                      :"Bobby Weave",
                    email                     :"bobby@weave.test",
                    phoneNumber               :"555-555-5555",
                    defaultAvailableTimeSlots :["monday"     :getRandomDefaultTimeSlots() as [Bool],
                        "tuesday"    :getRandomDefaultTimeSlots() as [Bool],
                        "wednesday"  :getRandomDefaultTimeSlots() as [Bool],
                        "thursday"   :getRandomDefaultTimeSlots() as [Bool],
                        "friday"     :getRandomDefaultTimeSlots() as [Bool],
                        "saturday"   :getRandomDefaultTimeSlots() as [Bool],
                        "sunday"     :getRandomDefaultTimeSlots() as [Bool]],
                    customAvaiableTimeSlots   :[1451635200:true])])]
        return salons
    }

}

