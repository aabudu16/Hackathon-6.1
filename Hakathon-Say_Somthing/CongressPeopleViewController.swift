//
//  CongressPeopleViewController.swift
//  Hakathon-Say_Somthing
//
//  Created by Mr Wonderful on 12/18/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class CongressPeopleViewController: UIViewController {
    
     let summaryMenuHeight:CGFloat = 200
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
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
           view.backgroundColor = .yellow
           return view
       }()
    
    lazy var email:UILabel  = {
          let label = UILabel()
          label.backgroundColor  = .blue
          
          label.textAlignment = .left
          label.adjustsFontSizeToFitWidth = true
          label.numberOfLines = 0
          return label
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBarConstaints()
        configureCollectionViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSummaryMenuHeightConstraint()
    }
    
  private func configureSearchBarConstaints(){
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor), searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), searchBar.heightAnchor.constraint(equalToConstant: 45)])
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
}

extension CongressPeopleViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
          UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                      self.summaryView.frame = CGRect(x: 0, y: (self.view.frame.height - self.summaryMenuHeight) + 20, width: self.view.frame.width, height: self.summaryMenuHeight)
                  }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.summaryView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.summaryMenuHeight)

        }
    }
}

extension CongressPeopleViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.congressCell.rawValue, for: indexPath) as? CongressPeopleCollectionViewCell else {return UICollectionViewCell()}
       // cell.layer.borderWidth = 2
       // cell.layer.borderColor = UIColor.blue.cgColor
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

