//
//  Protocal.swift
//  iOS-Code-Challenge
//
//  Created by Shubham Vinod Kamdi on 20/08/20.
//  Copyright © 2020 Persausive Tech. All rights reserved.
//

import Foundation


protocol Message{
    var shouldLocalDBUpdate: Bool {get set}
    func displayMessage(msg: String, isError: Bool)
    
}


