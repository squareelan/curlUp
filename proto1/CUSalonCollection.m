////
////  CUSalonCollection.m
////  proto1
////
////  Created by Connor Reid on 1/29/15.
////  Copyright (c) 2015 test. All rights reserved.
////
//
//#import "CUSalonCollection.h"
//#import "CUUtilities.h"
//#import "CUSalon.h"
//#import "CUDesigner.h"
//
//@implementation CUSalonCollection
//
//static NSMutableArray *_salons;
//
//+ (NSMutableArray*)getRandomDefaultTimeSlots
//{
//    NSMutableArray *randomDefaultTimeSlots = [NSMutableArray array];
//    
//    for (NSInteger i = 0; i < 48; ++i)
//    {
//        BOOL isAvailable = NO;
//        int tmp = (arc4random() % 30) +1;
//        if (tmp % 5 == 0)
//        {
//            isAvailable = YES;
//        }
//        [randomDefaultTimeSlots addObject:[NSNumber numberWithBool:isAvailable]];
//    }
//    
//    return randomDefaultTimeSlots;
//}
//
//+ (NSDictionary*)testSalonDictionaries
//{
//    id review = [[NSObject alloc] init];
//    NSArray *reviews = @[review];
//    
//    id reservation = [[NSObject alloc] init];
//    NSArray *reservations = @[reservation];
//    
//    NSDictionary *testDesignerDictionary = @{@"guid"                        :[CUUtilities createGUID],
//                                             @"salonGuid"                   :[CUUtilities createGUID],
//                                             @"name:"                       :@"Bobby Weave",
//                                             @"email"                       :@"bobbyweave@test.com",
//                                             @"defaultAvailableTimeSlots"   :@{@"monday"    :[CUSalonCollection getRandomDefaultTimeSlots],
//                                                                               @"tuesday"   :[CUSalonCollection getRandomDefaultTimeSlots],
//                                                                               @"wednesday" :[CUSalonCollection getRandomDefaultTimeSlots],
//                                                                               @"thursday"  :[CUSalonCollection getRandomDefaultTimeSlots],
//                                                                               @"friday"    :[CUSalonCollection getRandomDefaultTimeSlots],
//                                                                               @"saturday"  :[CUSalonCollection getRandomDefaultTimeSlots],
//                                                                               @"sunday"    :[CUSalonCollection getRandomDefaultTimeSlots]},
//                                             @"customAvailableTimeSlots"    :@{@"1451635200":@YES}};
//    
//    NSDictionary *testDesignersDictionary01 = @{@"designers":@{testDesignerDictionary[@"guid"]:testDesignerDictionary}};
//
//    NSDictionary *testSalonDictionary01 = @{@"images":@[[UIImage imageNamed:@"salon1.jpeg"]],
//                                             @"hours":@{@"monday"       :@[@"9:00AM", @"6:00PM"],
//                                                        @"tuesday"      :@[@"9:00AM", @"6:00PM"],
//                                                        @"wednesday"    :@[@"9:00AM", @"6:00PM"],
//                                                        @"thursday"     :@[@"9:00AM", @"6:00PM"],
//                                                        @"friday"       :@[@"9:00AM", @"6:00PM"],
//                                                        @"saturday"     :@[@"10:00AM", @"5:00PM"],
//                                                        @"sunday"       :@[@"12:00PM", @"4:00PM"]},
//                                              @"name":@"박철 헤어",
//                                          @"location":@{@"latitude":@30.513925, @"longitude":@97.688555},    //  30.513925, -97.688555 -> test location (location of old town square, rr, tx)
//                                           @"address":@"",
//                                           @"reviews":reviews,
//                                            @"rating":[NSNumber numberWithFloat:4.5],
//                                       @"phoneNumber":@"512-555-5555",
//                                              @"guid":[CUUtilities createGUID],
//                                      @"reservations":reservations,
//                                         @"designers":testDesignersDictionary01};
//
//    NSDictionary *testSalonDictionary02 = @{@"images":@[[UIImage imageNamed:@"salon2.jpeg"]],
//                                             @"hours":@{@"monday"       :@[@"9:00AM", @"6:00PM"],
//                                                        @"tuesday"      :@[@"9:00AM", @"6:00PM"],
//                                                        @"wednesday"    :@[@"9:00AM", @"6:00PM"],
//                                                        @"thursday"     :@[@"9:00AM", @"6:00PM"],
//                                                        @"friday"       :@[@"9:00AM", @"6:00PM"],
//                                                        @"saturday"     :@[@"10:00AM", @"5:00PM"],
//                                                        @"sunday"       :@[@"12:00PM", @"4:00PM"]},
//                                              @"name":@"CNN 헤어",
//                                          @"location":@{@"latitude":@30.513925, @"longitude":@97.688555},    //  30.513925, -97.688555 -> test location (location of old town square, rr, tx)
//                                           @"address":@"",
//                                           @"reviews":reviews,
//                                            @"rating":[NSNumber numberWithFloat:4.5],
//                                       @"phoneNumber":@"512-555-5555",
//                                              @"guid":[CUUtilities createGUID],
//                                      @"reservations":reservations,
//                                         @"designers":testDesignersDictionary01};
//    
//    NSDictionary *testSalonDictionary03 = @{@"images":@[[UIImage imageNamed:@"salon3.jpeg"]],
//                                             @"hours":@{@"monday"       :@[@"9:00AM", @"6:00PM"],
//                                                        @"tuesday"      :@[@"9:00AM", @"6:00PM"],
//                                                        @"wednesday"    :@[@"9:00AM", @"6:00PM"],
//                                                        @"thursday"     :@[@"9:00AM", @"6:00PM"],
//                                                        @"friday"       :@[@"9:00AM", @"6:00PM"],
//                                                        @"saturday"     :@[@"10:00AM", @"5:00PM"],
//                                                        @"sunday"       :@[@"12:00PM", @"4:00PM"]},
//                                              @"name":@"박승철 헤어",
//                                          @"location":@{@"latitude":@30.513925, @"longitude":@97.688555},    //  30.513925, -97.688555 -> test location (location of old town square, rr, tx)
//                                           @"address":@"",
//                                           @"reviews":reviews,
//                                            @"rating":[NSNumber numberWithFloat:4.5],
//                                       @"phoneNumber":@"512-555-5555",
//                                              @"guid":[CUUtilities createGUID],
//                                      @"reservations":reservations,
//                                         @"designers":testDesignersDictionary01};
//    
//    NSDictionary *testSalonDictionary04 = @{@"images":@[[UIImage imageNamed:@"salon4.jpeg"]],
//                                             @"hours":@{@"monday"       :@[@"9:00AM", @"6:00PM"],
//                                                        @"tuesday"      :@[@"9:00AM", @"6:00PM"],
//                                                        @"wednesday"    :@[@"9:00AM", @"6:00PM"],
//                                                        @"thursday"     :@[@"9:00AM", @"6:00PM"],
//                                                        @"friday"       :@[@"9:00AM", @"6:00PM"],
//                                                        @"saturday"     :@[@"10:00AM", @"5:00PM"],
//                                                        @"sunday"       :@[@"12:00PM", @"4:00PM"]},
//                                              @"name":@"UFO 헤어",
//                                          @"location":@{@"latitude":@30.513925, @"longitude":@97.688555},    //  30.513925, -97.688555 -> test location (location of old town square, rr, tx)
//                                           @"address":@"",
//                                           @"reviews":reviews,
//                                            @"rating":[NSNumber numberWithFloat:4.5],
//                                       @"phoneNumber":@"512-555-5555",
//                                              @"guid":[CUUtilities createGUID],
//                                      @"reservations":reservations,
//                                         @"designers":testDesignersDictionary01};
//    
//    NSDictionary *testSalonDictionary05 = @{@"images":@[[UIImage imageNamed:@"salon5.jpeg"]],
//                                             @"hours":@{@"monday"       :@[@"9:00AM", @"6:00PM"],
//                                                        @"tuesday"      :@[@"9:00AM", @"6:00PM"],
//                                                        @"wednesday"    :@[@"9:00AM", @"6:00PM"],
//                                                        @"thursday"     :@[@"9:00AM", @"6:00PM"],
//                                                        @"friday"       :@[@"9:00AM", @"6:00PM"],
//                                                        @"saturday"     :@[@"10:00AM", @"5:00PM"],
//                                                        @"sunday"       :@[@"12:00PM", @"4:00PM"]},
//                                              @"name":@"FarWest Hair",
//                                          @"location":@{@"latitude":@30.513925, @"longitude":@97.688555},    //  30.513925, -97.688555 -> test location (location of old town square, rr, tx)
//                                           @"address":@"",
//                                           @"reviews":reviews,
//                                            @"rating":[NSNumber numberWithFloat:4.5],
//                                       @"phoneNumber":@"512-555-5555",
//                                              @"guid":[CUUtilities createGUID],
//                                      @"reservations":reservations,
//                                         @"designers":testDesignersDictionary01};
//    
//    NSDictionary *testSalonsDictionary = @{@"salons":@{testSalonDictionary01[@"guid"]:testSalonDictionary01,
//                                                       testSalonDictionary02[@"guid"]:testSalonDictionary02,
//                                                       testSalonDictionary03[@"guid"]:testSalonDictionary03,
//                                                       testSalonDictionary04[@"guid"]:testSalonDictionary04,
//                                                       testSalonDictionary05[@"guid"]:testSalonDictionary05,}};
//    
//    return testSalonsDictionary;
//}
//
//+ (void)set_g_Salons:(NSDictionary*)salonsDictionary
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^
//    {
//        _salons = [[NSMutableArray alloc] init];
//    });
//    [_salons removeAllObjects];
//    NSDictionary *salons = salonsDictionary[@"salons"];
//    for (id key in salons)
//    {
//        CUSalon *salon = [CUSalon dictionaryToSalon:salons[key]];
//        [_salons addObject:salon];
//    }
//}
//
//+ (id)g_Salons
//{
//    if (_salons)
//    {
//        return _salons;
//    }
//    else
//    {
//        return NULL;
//    }
//}
//
//@end
