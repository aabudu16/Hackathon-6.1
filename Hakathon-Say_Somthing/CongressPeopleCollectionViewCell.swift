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
        //label.backgroundColor  = .blue
        label.text = "Brian Smith"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir-Light", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var district:UILabel  = {
        let label = UILabel()
         label.text = "District 11"
       // label.backgroundColor  = .blue
        
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir-Bold", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var address:UITextView  = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.textAlignment = .left
        tv.adjustsFontForContentSizeCategory = false
        tv.isUserInteractionEnabled = false
        tv.text = "218-28 Merrick Blvd, Springfield Gardens, NY 11413"
        tv.font = UIFont(name: "Avenir-Light", size: 16)
        return tv
    }()
    
    lazy var phoneNumber:UILabel  = {
        let label = UILabel()
       // label.backgroundColor  = .blue
        label.text = "(212)567-2956"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Light", size: 17)
        return label
    }()
    
    //MARK: Lifecycle
    override init (frame:CGRect){
        super.init(frame:frame)
        configureImageViewConstraints()
        configureDistrictConstraints()
        configureNameConstraints()
        configureAddressConstraints()
        configurePhoneNumberConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureImageViewConstraints(){
        self.addSubview(congressImage)
        congressImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([congressImage.topAnchor.constraint(equalTo: self.topAnchor), congressImage.centerXAnchor.constraint(equalTo: self.centerXAnchor), congressImage.widthAnchor.constraint(equalToConstant: 110), congressImage.heightAnchor.constraint(equalToConstant: 165)])
    }
   
    func configureDistrictConstraints(){
       self.addSubview(district)
        district.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([district.topAnchor.constraint(equalTo: congressImage.bottomAnchor, constant: 2), district.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2), district.trailingAnchor.constraint(equalTo: self.trailingAnchor), district.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    func configureNameConstraints(){
        self.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([name.topAnchor.constraint(equalTo: district.bottomAnchor, constant: 2), name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2), name.trailingAnchor.constraint(equalTo: self.trailingAnchor), name.heightAnchor.constraint(equalTo: district.heightAnchor)])
    }
    
    func configureAddressConstraints(){
        self.addSubview(address)
        address.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([address.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 2), address.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2), address.trailingAnchor.constraint(equalTo: self.trailingAnchor), address.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    func configurePhoneNumberConstraints(){
         self.addSubview(phoneNumber)
           phoneNumber.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([phoneNumber.topAnchor.constraint(equalTo: address.bottomAnchor, constant: 3), phoneNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2), phoneNumber.trailingAnchor.constraint(equalTo: self.trailingAnchor), phoneNumber.heightAnchor.constraint(equalTo: district.heightAnchor)])
       }
}
