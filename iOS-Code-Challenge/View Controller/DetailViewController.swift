//
//  SecondViewController.swift
//  iOS-Code-Challenge
//
//  Created by Shubham Vinod Kamdi on 19/08/20.
//  Copyright © 2020 Persausive Tech. All rights reserved.
//

import UIKit
import SnapKit
import ViewAnimator
import SwiftyGif

class DetailViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var displayImage: UIImageView!
    var descriptionLabel: UILabel!
    var dateLabel: UILabel!
    var idLabel: UILabel!
    var screenData: DataModel!
    var local: LocalDBDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        setUpScreen()
        self.view.backgroundColor = .white
        
    }
    
    func setUpScreen(){
        
        self.scrollView = UIScrollView()
        self.displayImage = UIImageView()
        self.descriptionLabel = UILabel()
        self.idLabel = UILabel()
        self.dateLabel = UILabel()
        
        displayImage.alpha = 0
        descriptionLabel.alpha = 0
        idLabel.alpha = 0
        dateLabel.alpha = 0
        
        dateLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        idLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(displayImage)
        self.scrollView.addSubview(descriptionLabel)
        self.scrollView.addSubview(idLabel)
        self.scrollView.addSubview(dateLabel)
        
        
        //SETTING UP SCROLL VIEW
        self.scrollView.snp.makeConstraints{
        
            $0.top.bottom.leading.trailing.equalToSuperview()
        
        }
        
        //SETTING UP DISPLAY IMAGE
        self.displayImage.snp.makeConstraints{
            
            $0.top.left.right.equalToSuperview()
           
            $0.height.equalTo(UIScreen.main.bounds.height * 0.4)
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-5)
            
        }
        
        //SETTING UP DESCRIPTION LABEL
        self.descriptionLabel.snp.makeConstraints{
            
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            
            $0.left.equalTo(self.view.snp.left).offset(10)
            $0.right.equalTo(self.view.snp.right).offset(-10)
            
            $0.bottom.equalTo(dateLabel.snp.top).offset(-5)
            
        }
        
        //SETTING UP DATE LABEL
        self.dateLabel.snp.makeConstraints{
            
            $0.left.equalTo(descriptionLabel.snp.left)
            $0.right.equalTo(descriptionLabel.snp.right)
            $0.bottom.equalTo(idLabel.snp.top).offset(-5)
            
        }
        
        //SETTING UP ID
        self.idLabel.snp.makeConstraints{
            
            $0.left.equalTo(descriptionLabel.snp.left)
            $0.right.equalTo(descriptionLabel.snp.right)
            $0.bottom.equalToSuperview().offset(-10)
            
        }
        idLabel.numberOfLines = 0
        
        
        descriptionLabel.numberOfLines = 0
        
        if !local.id.isEmpty{
            self.idLabel.text = "ID: " + local.id
        }else{
            self.idLabel.text = "ID Unavailable"
        }
        
        if !local.date.isEmpty{
            self.dateLabel.text = "Date: " + local.date
        }else{
            self.dateLabel.text = "Date Unavailable"
        }
        
        if !local.isImageFlag {
            self.displayImage.image = UIImage(named: "missing")
        }
        
        if !local.data.isEmpty  {
            self.descriptionLabel.text = local.data
            
        }else{
            self.descriptionLabel.text = "Desc.: " + "Unavailable"
        }
        
        
        
        if local.isImageFlag && local.image_data != nil{
            self.displayImage.image = UIImage(data: local.image_data!)
            self.descriptionLabel.text = "Image URL: \(local.data)"
        }else{
            if local.isImageFlag{
                self.descriptionLabel.text = "Image URL: \(local.data) \nThe image url is broken!"
               do {
                //SETTING ERROR GIF
                    let gif = try UIImage(gifName: "Error_GIF.gif")
                    self.displayImage.setGifImage(gif, loopCount: -1)
                    displayImage.startAnimatingGif()
                
                } catch {
                    print(error)
                }
            }
             
        }
        
        UIView.animate(views: [self.displayImage, self.descriptionLabel, self.idLabel, self.dateLabel ], animations: [AnimationType.from(direction: .left, offset: 200)], delay: 0.5)
        
    }
    

}
