//
//  PreviewViewController.swift
//  Hakathon-Say_Somthing
//
//  Created by Mr Wonderful on 12/18/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class EnvironmentalTopicsVC: UIViewController {
   
  var topics = Topic.topics {
    didSet{
      topicTableView.reloadData()
    }
  }
   
  lazy var topicTableView : UITableView = {
    let tv = UITableView()
    tv.register(EnvironmentalTopicsCell.self, forCellReuseIdentifier: Identifiers.topicCell.rawValue)
    return tv
  }()
   
  
  private func setUpDelegates(){
    topicTableView.delegate = self
    topicTableView.dataSource = self
     
  }
   
  private func setUpTableView(){
    view.addSubview(topicTableView)
    topicTableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topicTableView.topAnchor.constraint(equalTo: view.topAnchor),
      topicTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      topicTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topicTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
       
    ])
  }
   
   
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpDelegates()
    setUpTableView()
    self.navigationItem.title = "Topics"
     
  }
   
}
extension EnvironmentalTopicsVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return topics.count
  }
   
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.topicCell.rawValue, for: indexPath) as? EnvironmentalTopicsCell else {return UITableViewCell()}
    cell.topicLabel.text = topics[indexPath.row].topic
    return cell
  }
   
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
