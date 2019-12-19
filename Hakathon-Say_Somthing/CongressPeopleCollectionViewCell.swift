//
//  CategoryCollectionViewCell.swift
//  Hakathon-Say_Somthing
//
//  Created by Mr Wonderful on 12/18/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import Kingfisher

protocol CollectionViewCellDelegate: AnyObject {
    func showCongressSummary(tag: Int)
}

class CongressPeopleCollectionViewCell: UICollectionViewCell {
    weak var delegate: CollectionViewCellDelegate?
    
    lazy var congressImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .brown
        return image
    }()
    
    lazy var name:UILabel  = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir-Light", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var district:UILabel  = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir-Bold", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var address:UITextView  = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.adjustsFontForContentSizeCategory = false
        tv.isUserInteractionEnabled = false
        tv.font = UIFont(name: "Avenir-Light", size: 16)
        return tv
    }()
    
    lazy var phoneNumber:UILabel  = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Light", size: 17)
        return label
    }()
    
    lazy var hairLineView:UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var infoButton:UIButton = {
    let button  = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.layer.borderColor = UIColor.white.cgColor
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.layer.cornerRadius = button.layer.frame.height / 2
        button.addTarget(self, action: #selector(handleInfoButtonPressed(sender:)), for: .touchUpInside)
    return button
    }()
    
    //MARK: Lifecycle
    override init (frame:CGRect){
        super.init(frame:frame)
        configureImageViewConstraints()
        configureDistrictConstraints()
        configureNameConstraints()
        configureAddressConstraints()
        configurePhoneNumberConstraints()
        configureHairLineViewConstraints()
        configureInfoButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleInfoButtonPressed(sender:UIButton){
        delegate?.showCongressSummary(tag: sender.tag)
    }
    
    public func configureCellFromCongressPerson(person: CongressPerson) {
        name.text = person.name
        phoneNumber.text = person.number
        address.text = person.address
        district.text = "District \(person.district)"
        congressImage.kf.indicatorType = .activity
        congressImage.kf.setImage(with: URL(string: person.imageURL))
        
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
    
    func configureHairLineViewConstraints(){
        self.addSubview(hairLineView)
        hairLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([hairLineView.topAnchor.constraint(equalTo: phoneNumber.topAnchor, constant:  25), hairLineView.centerXAnchor.constraint(equalTo: self.centerXAnchor), hairLineView.heightAnchor.constraint(equalToConstant: 1), hairLineView.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    func configureInfoButtonConstraints(){
        self.addSubview(infoButton)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([infoButton.centerXAnchor.constraint(equalTo: congressImage.trailingAnchor), infoButton.topAnchor.constraint(equalTo: congressImage.topAnchor, constant:  20)])
    }
}
