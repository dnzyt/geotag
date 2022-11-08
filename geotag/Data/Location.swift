//
//  Location.swift
//  geotag
//
//  Created by Ningze Dai on 11/7/22.
//

import Foundation

struct Location {
    let clubKey: String
    let address: String
    let primaryDsId: String
    let geoCode: String
    
}

/*
 "ErrorCode": "0",
     "ErrorMessage": "SUCCESS",
     "GetClubDetails": [
         {
             "ClubKey": "1090134",
             "ClubName": "club siHebat",
             "Address": "perum bangun surya abadi blok A2 no 9  tarai bangun tambang pekanbaru",
             "City": "PEKANBARU",
             "Province": "RIAU",
             "Zip": "28282",
             "Phone": "085376310199",
             "ClubType": "NON-RESIDENTIAL",
             "ClubStatus": "ACTIVE",
             "Opendate": "2017-10-01T00:00:00.000-07:00",
             "PrimaryDsId": "D1552506",
             "PrimaryDsName": "- FARIZAL",
             "UplineName": "D1050906",
             "GeoCode": "-6.270598386958833,106.53145176654043",
             "CountryCode": "ID"
         }
     ]
 }
 */
