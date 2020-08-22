//
//  LocalDB.swift
//  iOS-Code-Challenge
//
//  Created by Shubham Vinod Kamdi on 21/08/20.
//  Copyright © 2020 Persausive Tech. All rights reserved.
//

import Foundation
import RealmSwift
class LocalDBDataModel: Object {
    
    @objc dynamic var isImageFlag: Bool = false
    @objc dynamic var date = ""
    @objc dynamic var id = ""
    @objc dynamic var data = ""
    @objc dynamic var image_data: Data?
   
}
