//
//  TableViewCell.swift
//  iOS-Code-Challenge
//
//  Created by Shubham Vinod Kamdi on 19/08/20.
//  Copyright © 2020 Persausive Tech. All rights reserved.
//

import UIKit
import SnapKit

class ImageTableViewCell: UITableViewCell {
    
    static let identifier: String = "Image_Cell"
    
    var parentView: CardView!
    var Img: UIImageView!
    var dateLabel: UILabel!
    var id: UILabel!
    var vSTack: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureView()
        configureImage()
        configureStack()
        
    }
    
    func configureView(){
        //CREATING A CARD VIEW
        parentView = CardView()
        
        self.contentView.addSubview(parentView)
        
        parentView.snp.makeConstraints({
            make in
           // make.leading.top.trailing.bottom.equalTo(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        })
        
      
        parentView.layer.cornerRadius = 40
        parentView.backgroundColor = .white

        
        
    }
    
    func configureImage(){
        //CREATING UIIMAGEVIEW TO DIPLAY IMAGES
        Img = UIImageView()
        
        self.parentView?.addSubview(Img)
        
        self.Img.snp.makeConstraints({
            make in
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(65)
            make.width.equalTo(65)
            make.centerY.equalToSuperview()
        })
        
       
        self.Img.layer.cornerRadius = 9
        self.Img.clipsToBounds = false
        
        
    }
    
   
    
    func configureStack(){
        //CREATING STACK VIEW AND ADDING UILABELS TO IT
        vSTack = UIStackView()
        self.parentView.addSubview(vSTack)
        dateLabel = UILabel()
        id = UILabel()
        
        vSTack.addArrangedSubview(dateLabel)
        vSTack.addArrangedSubview(id)
        vSTack.spacing = 0
        
        vSTack.axis = .vertical
        vSTack.snp.makeConstraints({
            make in
                      
            make.left.equalTo(Img.snp.right).offset(10)
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalTo(Img)
            
        })
        
    }
    
    func showSkeletonTemp(){
        
        Img.isSkeletonable = true
        dateLabel.text = " "
        id.text = " "
        Img.showSkeleton()
        dateLabel.isSkeletonable = true
        dateLabel.showSkeleton()
        id.isSkeletonable = true
        id.showSkeleton()
    }
    
    func hideSkeletonTemp(){
        
        Img.hideSkeleton()
        dateLabel.hideSkeleton()
        id.hideSkeleton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

}


