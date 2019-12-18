//
//  CategoryCollectionViewCell.swift
//  Hakathon-Say_Somthing
//
//  Created by Mr Wonderful on 12/18/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class CongressPeopleCollectionViewCell: UICollectionViewCell {
    
    lazy var congressImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .brown
        return image
    }()
    
    lazy var name:UILabel  = {
        let label = UILabel()
        label.backgroundColor  = .blue
        return label
    }()
   
    lazy var district:UILabel  = {
           let label = UILabel()
        label.backgroundColor  = .blue
           return label
       }()
    
    lazy var address:UILabel  = {
           let label = UILabel()
        label.backgroundColor  = .blue
           return label
       }()
    
    lazy var number:UILabel  = {
           let label = UILabel()
        label.backgroundColor  = .blue
           return label
       }()
    
    lazy var email:UILabel  = {
           let label = UILabel()
        label.backgroundColor  = .blue
           return label
       }()
    
    //MARK: Lifecycle
    override init (frame:CGRect){
        super.init(frame:frame)
  configureImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureImageViewConstraints(){
        self.addSubview(congressImage)
        congressImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([congressImage.topAnchor.constraint(equalTo: self.topAnchor), congressImage.leadingAnchor.constraint(equalTo: self.leadingAnchor), congressImage.trailingAnchor.constraint(equalTo: self.trailingAnchor), congressImage.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -(self.layer.frame.height  / 2))])
    }
    
}
