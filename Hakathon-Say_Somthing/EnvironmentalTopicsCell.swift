//
//  EnvironmentalTopicsCell.swift
//  Hakathon-Say_Somthing
//
//  Created by Mr Wonderful on 12/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class EnvironmentalTopicsCell: UITableViewCell {
  //MARK: UI OBJECTS
   
  lazy var topicLabel : UILabel = {
    let label = UILabel()
    label.numberOfLines = 0

    label.text = "Topics"
    label.font = UIFont(name: "Avenir-Light", size: 30)
    label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    label.textAlignment = .center
    return label
     
     
  }()
   
   
   
  //MARK: PRIVATE FUNCTIONS
    
   private func setUpLabel(){
    self.addSubview(topicLabel)
     topicLabel.translatesAutoresizingMaskIntoConstraints = false
     NSLayoutConstraint.activate([
       topicLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
       topicLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
       topicLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30)])
      
   }
    
    
    
    
   private func setUpViews(){
     setUpLabel()
   }
    
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = #colorLiteral(red: 0.0961939469, green: 0.2122457325, blue: 0.06203992665, alpha: 1)
    setUpViews()
    let selectedView = UIView()
    selectedView.backgroundColor = .black
    selectedBackgroundView = selectedView
  }
   
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
   
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
     
  }
}


