//
//  WebServiceManager.swift
//  iOS-Code-Challenge
//
//  Created by Shubham Vinod Kamdi on 20/08/20.
//  Copyright © 2020 Persausive Tech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireImage

struct WebServiceManager{
    
    var messageDelegate: Message!
    
    func downloadImage(strUrl: String,onCompletion: @escaping (UIImage) -> (), onFailure: @escaping () -> ()){
       Alamofire.request(strUrl).responseImage { response in
        //debugPrint(response)

        //print(response.request)
        //print(response.response)
        //debugPrint(response.result)

        if case .success(let image) = response.result {
            onCompletion(image)
            //print("image downloaded: \(image)")
            
        }else{
            onFailure()
        }
        
        
    
    }
    }
    
    func requestGetService(url: String,requestMethod : HTTPMethod, onSucces: @escaping (JSON) -> (), onFailure: @escaping (Error) -> ()){
        
        if Reachability.isInternetAvailable(){
            
            Alamofire.request(url, method: requestMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).downloadProgress(queue: DispatchQueue.global(qos: .utility)){
                progress in
            }.responseJSON{
                Response in
                
                if Response.result.isSuccess{

                    let responseJSON = JSON(Response.result.value!)
                    print(responseJSON)
                    
                    onSucces(responseJSON)

                }else if Response.result.isFailure{
                    
                    print(Response.result.error!)
                    
                    let error : NSError = Response.result.error! as NSError
                    onFailure(error)
                    
                }
                
            }
            
            
        }else{
            
            messageDelegate.displayMessage(msg: "Internet Not Available", isError: true)
            
        }
    }
    
    
}
