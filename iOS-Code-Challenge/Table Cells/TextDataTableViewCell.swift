//
//  TextDataTableViewCell.swift
//  iOS-Code-Challenge
//
//  Created by Shubham Vinod Kamdi on 19/08/20.
//  Copyright © 2020 Persausive Tech. All rights reserved.
//

import UIKit

class TextDataTableViewCell: UITableViewCell {

    static let identifier: String = "Text_Cell"
    
    var parentView: UIView!
    var dateLabel: UILabel!
    var descriptionLabel: UILabel!
    var id: UILabel!
    var vStack: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureStack()
        self.selectionStyle = .none
    }
    
    func showSkeletonTemp(){
        self.dateLabel.isSkeletonable = true
        self.dateLabel.showSkeleton()
    }
    
    func removeSkeleton(){
        self.dateLabel.hideSkeleton()
        self.dateLabel.isSkeletonable = false
        
    }
    
      func configureView(){
        parentView = CardView()
        
        self.contentView.addSubview(parentView)
        
        parentView.snp.makeConstraints({
              make in
            
              make.left.equalToSuperview().offset(5)
              make.right.equalToSuperview().offset(-5)
              make.top.equalToSuperview().offset(10)
              make.bottom.equalToSuperview().offset(-10)
        })
          
          parentView.layer.cornerRadius = 40
          parentView.backgroundColor = .white

      }
    
    func configureStack(){
        vStack = UIStackView()
        
        self.parentView.addSubview(vStack)
        
        vStack.axis = .vertical
        
        dateLabel = UILabel()
        descriptionLabel = UILabel()
        id = UILabel()
        
        vStack.addArrangedSubview(dateLabel)
        vStack.addArrangedSubview(descriptionLabel)
        vStack.addArrangedSubview(id)
        
        vStack.spacing = 0
        vStack.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
