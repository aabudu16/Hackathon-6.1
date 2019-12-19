//
//  PreviewViewController.swift
//  Hakathon-Say_Somthing
//
//  Created by Mr Wonderful on 12/18/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import MessageUI

class EnvironmentalTopicsVC: UIViewController {
   
    var congressEmail = String()
    var congressPerson:CongressPerson!{
        didSet{
            congressEmail = congressPerson.email
            print(congressEmail)
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topic = topics[indexPath.row]
        let preview = UIAlertController(title: "Preview", message: topic.message, preferredStyle: .alert)
        let compose = UIAlertAction(title: "Compose", style: .default) { (email) in
            guard  MFMailComposeViewController.canSendMail() else {return}
            
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setSubject(topic.topic)
            composer.setMessageBody(topic.message, isHTML: false)
            composer.setToRecipients([self.congressEmail])
            
            self.present(composer, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        preview.addAction(compose)
        preview.addAction(cancel)
        
        present(preview, animated: true, completion: nil)
    }
}

extension EnvironmentalTopicsVC: MFMailComposeViewControllerDelegate{
    
}
