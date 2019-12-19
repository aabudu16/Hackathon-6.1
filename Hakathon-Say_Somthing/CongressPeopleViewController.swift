//
//  CongressPeopleViewController.swift
//  Hakathon-Say_Somthing
//
//  Created by Mr Wonderful on 12/18/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import Kingfisher


class CongressPeopleViewController: UIViewController {
    
    var congressPeople = CongressPerson.congressPeople
    
    let summaryMenuHeight:CGFloat = 250
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.scopeButtonTitles = ["Congress", "District"]
        searchBar.showsScopeBar = true
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        return searchBar
    }()
    
    //MARK: UI Objects
    lazy var congressCollectionView:UICollectionView = {
        var layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.register( CongressPeopleCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.congressCell.rawValue)
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var summaryView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var summaryDiscription:UITextView  = {
        let tv = UITextView()
        tv.textAlignment = .center
        tv.textAlignment = .left
        tv.adjustsFontForContentSizeCategory = true
        tv.isUserInteractionEnabled = false
        tv.font = UIFont(name: "Avenir-Light", size: 13)
        return tv
    }()
    
    lazy var summaryLabel:UILabel  = {
        let label = UILabel()
        label.text = "*** Summary ***"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    
    lazy var email:UILabel  = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    lazy var deemView:UIView = {
           let deemView = UIView()
           let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(dismissDeemView))
           deemView.backgroundColor = UIColor(white: 0, alpha: 0.6)
           deemView.alpha = 0
           deemView.addGestureRecognizer(tapGuesture)
           return deemView
       }()
    
    var searchCongressResult:[CongressPerson]{
        get{
            guard let searchCongressString = searchCongressString else {
                return congressPeople
            }
            guard searchCongressString != "" else {
                return congressPeople
            }
            
            if let scoptTitles = searchBar.scopeButtonTitles {
                let currentScopeIndex = searchBar.selectedScopeButtonIndex
                
                switch scoptTitles[currentScopeIndex]{
                case "Congress":
                    return congressPeople.filter({$0.name.contains(searchCongressString)})
                case "District":
                    return
                        congressPeople.filter({$0.district == Int(searchCongressString)})
                default:
                    return congressPeople
                }
            }
            return congressPeople
        }

    }
    
    var searchCongressString:String? = nil {
        didSet {
            self.congressCollectionView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBarConstaints()
        configureCollectionViewConstraints()
        configureSummaryLabelConstraint()
        configureSummaryDiscriptionConstraint()
        configureEmailLabelConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSummaryMenuHeightConstraint()
    }
    
   
    @objc func dismissDeemView(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.deemView.alpha = 0
            self.summaryView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.summaryMenuHeight)

        }, completion: { (_) in
            self.deemView.removeFromSuperview()
        })
    }
    
    private func configureSearchBarConstaints(){
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor), searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), searchBar.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    func configureCollectionViewConstraints(){
        view.addSubview(congressCollectionView)
        congressCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([congressCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor), congressCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), congressCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), congressCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
    
    private func configureSummaryMenuHeightConstraint(){
        view.addSubview(summaryView)
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([summaryView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0), summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor), summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor), summaryView.heightAnchor.constraint(equalToConstant: summaryMenuHeight)])
    }
    
    func configureSummaryLabelConstraint(){
        summaryView.addSubview(summaryLabel)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([summaryLabel.topAnchor.constraint(equalTo: summaryView.topAnchor,constant: 2), summaryLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor), summaryLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor), summaryLabel.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    func configureSummaryDiscriptionConstraint(){
        summaryView.addSubview(summaryDiscription)
        summaryDiscription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([summaryDiscription.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor), summaryDiscription.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor), summaryDiscription.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor),summaryDiscription.heightAnchor.constraint(equalToConstant: 150)])
    }
    
    func configureEmailLabelConstraints(){
        summaryView.addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([email.topAnchor.constraint(equalTo:summaryDiscription.bottomAnchor, constant: 5), email.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor), email.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor), email.heightAnchor.constraint(equalToConstant: 40)])
    }
}

extension CongressPeopleViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let PreviewVC = PreviewViewController()
        navigationController?.pushViewController(PreviewVC, animated: true)
    }
    
}

extension CongressPeopleViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchCongressResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.congressCell.rawValue, for: indexPath) as? CongressPeopleCollectionViewCell else {return UICollectionViewCell()}
        let singlePerson = searchCongressResult[indexPath.row]
        cell.delegate = self
        cell.infoButton.tag = indexPath.item
        cell.configureCellFromCongressPerson(person: singlePerson)
        
        return cell
    }
}

extension CongressPeopleViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let virticalCellCGSize = CGSize(width: 200, height: 300)
        return virticalCellCGSize
    }
}

extension CongressPeopleViewController: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          searchCongressString = searchBar.text
      }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }

}

extension CongressPeopleViewController: CollectionViewCellDelegate{
    func showCongressSummary(tag: Int) {
        
        if let window = UIApplication.shared.keyWindow{
               window.addSubview(deemView)
            window.addSubview(summaryView)
               deemView.frame = window.frame
        
        let singlePerson = self.congressPeople[tag]
         UIView.animate(withDuration: 0.7, delay: 0.5, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                        self.summaryDiscription.text = singlePerson.description
                        self.email.text = "Email: \(singlePerson.email)"
             self.deemView.alpha = 1
             self.summaryView.frame = CGRect(x: 0, y: (self.view.frame.height - self.summaryMenuHeight) + 20, width: self.view.frame.width, height: self.summaryMenuHeight)
            
         }, completion: nil)
        
        }
    }
    
    
}
