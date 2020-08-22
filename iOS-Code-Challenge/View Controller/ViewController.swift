//
//  ViewController.swift
//  iOS-Code-Challenge
//
//  Created by Shubham Vinod Kamdi on 19/08/20.
//  Copyright © 2020 Persausive Tech. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift
import SwiftyJSON
import SkeletonView
import ViewAnimator

class ViewController: UIViewController {
    
    var shouldLocalDBUpdate: Bool = false
    var dataTable: UITableView!
    
    var webService: WebServiceManager!
    var data: [DataModel] = []
    
    var isImage: Bool = false
   
    
    var dataImgSort: [DataModel] = []
    var dataTextSort: [DataModel] = []
    
    var local: Results<LocalDBDataModel>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "iOS-Code-Challege"
        dataTable = UITableView()
       
        self.view.addSubview(dataTable)
       
        dataTable.snp.makeConstraints {
            
            $0.top.left.right.bottom.equalToSuperview()
            
        }
       
        self.dataTable.dataSource = self
        self.dataTable.delegate = self
        self.dataTable.reloadData()
        
        dataTable.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        
        dataTable.register(TextDataTableViewCell.self, forCellReuseIdentifier: TextDataTableViewCell.identifier)
        dataTable.rowHeight = 100
       
        let realm = try! Realm()
        
        
        
        webService = WebServiceManager()
        webService.messageDelegate = self
        
        if Reachability.isInternetAvailable(){
            
            self.deleteAll()
            getData()
            
        }else{
            
            let local = realm.objects(LocalDBDataModel.self)
            if local.count > 0{
                self.alertWithCompletion(message: "It seems you do not have an internet connection at the moment. Would you like to see the locally stored data?", title: "Note", oncompletion: {
                    
                    self.local = realm.objects(LocalDBDataModel.self)
                    self.dataTable.reloadData()
                    
                }, onCancel: {})
            }else{
                self.displayMessage(msg: "Please restart the app, when you have a stable internet connection.", isError: true)
            }
        }
        
    }
    
   
    
    func getData(){
        //FETCHING THE DATA RAW DATA
        webService.requestGetService(url: Constant.SERVER_URL + Constant.CHALLENGE_URL, requestMethod: .get, onSucces: {
            (JSONResponse) -> Void in
                self.parseData(JSONResponse: JSONResponse)

            }, onFailure: {
                (Error) -> Void in
                
        })
        
    }
   
    func parseData(JSONResponse: JSON){
        //PARSING DATA
        for i in 0 ..< JSONResponse.count{
                       
            let date = JSONResponse[i]["date"].stringValue
            let data = JSONResponse[i]["data"].stringValue
            let type = JSONResponse[i]["type"].stringValue
            let id = JSONResponse[i]["id"].stringValue
            
            //IF RAW DATA CONTAINS THE IMAGE PARAMETER THEN IT IS STORED SEPARATELY FOR SORTING THE DATA
            if type == "image"{
                
                self.isImage = true
                self.self.dataImgSort.append(DataModel(isImageFlag: isImage, date: date, id: id, data: data))
            }else{
                self.isImage = false
                self.dataTextSort.append(DataModel(isImageFlag: isImage, date: date, id: id, data: data))
            }
                    
                    if i == JSONResponse.count - 1{
                           //APPENDING THE SORTED DATA TOGETHER
                            self.data = []
                            
                            self.data.append(contentsOf: dataImgSort)
                            self.data.append(contentsOf: dataTextSort)
                        //CALLING THE LOACAL STORAGE FUNCTION
                            self.saveData()
                    
                    }
                       
                }
    }
    
    func deleteAll(){
        
        let realm = try! Realm()
        try! realm.write{
            realm.deleteAll()
        }
    }
    
    func addToDB(id: String, data: String, isImage: Bool, date: String, imgData: Data?){
        
        //WRITING DATA TO REALM DB
        let local = LocalDBDataModel()
        local.id = id
        local.data = data
        local.date = date
        local.image_data = imgData
        local.isImageFlag = isImage
        
        let realm = try! Realm()
        
        try! realm.write(){
            realm.add(local)
        }
    }
    
    
    func saveData(){
        //STORING THE DATA LOACALLY
        for i in 0 ..< data.count{
            
            if data[i].isImageFlag{
                //DOWNLOADING THE IMAGE USING ALAMOFIRE IMAGE LIBRARY
                
                webService.downloadImage(strUrl: data[i].data ,onCompletion: {
                    (Image) -> Void in
                    //STORING THE IMAGE DATA INTO REALM DB
                    self.addToDB(id: self.data[i].id, data: self.data[i].data, isImage: self.data[i].isImageFlag, date: self.data[i].date, imgData: Image.jpegData(compressionQuality: 0.1)!)
                    
                }, onFailure: {
                    //STORING NIL IMAGE DATA FOR INVALID URL
                    self.addToDB(id: self.data[i].id, data: self.data[i].data, isImage: self.data[i].isImageFlag, date: self.data[i].date, imgData: nil)
                    
                })
                
            }else{
                //STORING THE DATA INTO REAlM DB WITHOUT IMAGE
                 self.addToDB(id: self.data[i].id, data: self.data[i].data, isImage: self.data[i].isImageFlag, date: self.data[i].date, imgData: nil)
            }
            
            if i == self.data.count - 1{
                //LOADING THE TABLE VIEW WHEN ALL DATA IS STORED IN REALM DATA
                let realm = try! Realm()
                self.local = realm.objects(LocalDBDataModel.self)
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    
                    self.dataTable.dataSource = self
                    self.dataTable.delegate = self
                    self.dataTable.reloadData()
                    
                   
                    
                })
               
            }
        }
    }
    
    
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if local == nil{
            //FOR SKELETAL ANIMATION
            return 10
        }else{
             return local.count
        }
       
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.local != nil{
            //REDIRECTION TO DETAILS SCREENS 
            let VC = DetailViewController()
            VC.local = self.local[indexPath.row]
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if local == nil{
            
          
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as! ImageTableViewCell
            
            //STARTING SKELETAL ANIMATION
            cell.showSkeletonTemp()

            return cell
          
        }else{
            if local[indexPath.row].isImageFlag{
               //SETTING UP THE IMAGE CELL
                let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as! ImageTableViewCell
                cell.hideSkeletonTemp()
                
                cell.Img.image = UIImage(named: "missing")
                
                
                
                if local[indexPath.row].image_data != nil{
                    
                    //TO AVOID IMAGE DUPLICATION OR WORG IMAGE FROM BEING DISPLAYED
                    cell.Img.image = nil
                    
                    //FETCHING IMAGE DATA FROM REALM DB
                    if let img = UIImage(data: local[indexPath.row].image_data! as Data){
                        
                        //Setting the image via main thread
                        DispatchQueue.main.async {
                            cell.Img.image = img
                        }
                        
                    }
                    
                }
                
                //FETCHING REAMAINING DATA FROM REALM DB
                if local[indexPath.row].date.isEmpty{
                    cell.dateLabel.text = "Date: " + "Unavailable"
                }else{
                    cell.dateLabel.text = "Date: " + local[indexPath.row].date
                }
                
                
                if local[indexPath.row].id.isEmpty{
                     cell.id.text = "ID :" + "Unavailable"
                }else{
                     cell.id.text = "ID :" + local[indexPath.row].id
                }
                
                cell.Img.layer.cornerRadius = 5
                cell.Img.clipsToBounds = true
               
            
                return cell
                
            }else{
                
                //SETTING UP THE TEXT DATA CELL
                let cell = tableView.dequeueReusableCell(withIdentifier: TextDataTableViewCell.identifier, for: indexPath) as! TextDataTableViewCell
                
                if local[indexPath.row].date.isEmpty{
                     cell.dateLabel.text = "Date: " + "Unavailable"
                }else{
                     cell.dateLabel.text = "Date: " + local[indexPath.row].date
                }
                
                if local[indexPath.row].id.isEmpty{
                    cell.id.text = "ID: " + "Unavailable"
                }else{
                    cell.id.text = "ID: " + local[indexPath.row].id
                }
                
                if local[indexPath.row].data.isEmpty{
                     cell.descriptionLabel.text = "Desc.: " + "Unavailable"
                }else{
                     cell.descriptionLabel.text = "Desc.: " + local[indexPath.row].data
                }
                
                return cell
                
            }
        }
        
    }
    
    
}

extension ViewController: Message{
    
    //Protocal Implementation to display messages
    
    func displayMessage(msg: String, isError: Bool) {
        
        var titleForAlert: String = ""
        
        if isError{
            titleForAlert = "Error"
        }else{
            titleForAlert = "Note"
        }
        
        self.alert(message: msg, title: titleForAlert)
    }
    
}


