//
//  DataModel.swift
//  iOS-Code-Challenge
//
//  Created by Shubham Vinod Kamdi on 19/08/20.
//  Copyright © 2020 Persausive Tech. All rights reserved.
//

import Foundation

struct DataModel {
    
    var isImageFlag: Bool!
    var date: String!
    var id: String!
    var data: String!
    var imgdata: Data? = nil
    
    init(isImageFlag: Bool, date: String, id: String, data: String) {
        
        self.isImageFlag = isImageFlag
        self.date = date
        self.id = id
        self.data = data
        
    }
}
