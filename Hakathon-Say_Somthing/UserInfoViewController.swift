//
//  ViewController.swift
//  Hakathon-Say_Somthing
//
//  Created by Mr Wonderful on 12/18/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//
import UIKit
class UserInfoViewController: UIViewController {
    //MARK: Lazy Properties
    lazy var nameTextField = Utilities.createTextfield(placeholderMsg: "Name", isSecureEntry: false)
    lazy var zipCodeTextField = Utilities.createTextfield(placeholderMsg: "Zipcode", isSecureEntry: false)
    lazy var whiteView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        return uv
    }()
    lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "congress")
        iv.backgroundColor = .clear
        whiteView.addSubview(iv)
        return iv
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.0961939469, green: 0.2122457325, blue: 0.06203992665, alpha: 1)
        label.text = "Say Something!"
        whiteView.addSubview(label)
        label.textAlignment = .center
        return label
    }()
    lazy var findButton: UIButton = {
        let button = UIButton()
        button.setTitle("Find My Representative", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 25
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 1.0
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(findButtonPressed), for: .touchUpInside)
        return button
    }()
    var scrollView = UIScrollView(frame: UIScreen.main.bounds)
    var contentView = UIView()
    private func validateTextFields(){
          if !nameTextField.hasText || !zipCodeTextField.hasText {
              Utilities.showAlert(vc: self, message: "Please fill in all required fields")
          }
      }
    @objc private func findButtonPressed(){
        validateTextFields()
        let destVC = CongressPeopleViewController()
        destVC.userName = nameTextField.text!
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    @objc func handleKeyboardAppearing(sender: Notification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 185)
        scrollView.updateContentView()
    }
    @objc func handleKeyboardDisappearing(sender: Notification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.updateContentView()
    }
    private func addKeyboardObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardAppearing(sender:)), name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDisappearing(sender:)), name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    //MARK: -- Lifecycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        zipCodeTextField.keyboardType = .numberPad
        setConstraints()
        addKeyboardObserver()
        [zipCodeTextField, nameTextField].forEach{$0.delegate = self}
    }
}
//MARK: -- Constraints
extension UserInfoViewController {
    private func setConstraints(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [nameTextField, zipCodeTextField, whiteView, logoImageView, titleLabel, findButton, scrollView, contentView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        [nameTextField, zipCodeTextField, whiteView, findButton].forEach{contentView.addSubview($0)}
        configureScrollViewConstraints()
        configureContentViewConstraints()
        setWhiteViewConstraints()
        setLogoImageConstraints()
        setTitleLabelConstraints()
        setNameTextFieldConstraints()
        setZipCodeTextFieldConstraints()
        setFindButtonConstraints()
    }
    private func configureScrollViewConstraints(){
        scrollView.backgroundColor = #colorLiteral(red: 0.2914385796, green: 0.1974040866, blue: 0.4500601888, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func configureContentViewConstraints() {
        contentView.backgroundColor = #colorLiteral(red: 0.0961939469, green: 0.2122457325, blue: 0.06203992665, alpha: 1)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
    private func setWhiteViewConstraints(){
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
            whiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 40),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.widthAnchor.constraint(equalTo: whiteView.widthAnchor, multiplier: 0.9)
        ])
    }
    private func setLogoImageConstraints(){
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: whiteView.centerYAnchor, constant: 50),
            logoImageView.widthAnchor.constraint(equalTo: whiteView.widthAnchor, multiplier: 0.7),
            logoImageView.heightAnchor.constraint(equalToConstant: 225)
        ])
    }
    private func setNameTextFieldConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: 40),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
    private func setZipCodeTextFieldConstraints() {
        NSLayoutConstraint.activate([
            zipCodeTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            zipCodeTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 55),
            zipCodeTextField.heightAnchor.constraint(equalToConstant: 40),
            zipCodeTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
    private func setFindButtonConstraints() {
        NSLayoutConstraint.activate([
            findButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            findButton.topAnchor.constraint(equalTo: zipCodeTextField.bottomAnchor, constant: 45),
            findButton.widthAnchor.constraint(equalToConstant: 350),
            findButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
//MARK: -- Extensions
extension UserInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
extension UIView {
    var textFieldsInView: [UITextField] {
        return subviews
            .filter ({ !($0 is UITextField) })
            .reduce (( subviews.compactMap { $0 as? UITextField }), { summ, current in
                return summ + current.textFieldsInView
        })
    }
    var selectedTextField: UITextField? {
        return textFieldsInView.filter { $0.isFirstResponder }.first
    }
}
extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
        contentSize.width = subviews.sorted(by: { $0.frame.maxX < $1.frame.maxX }).last?.frame.maxX ?? contentSize.width
    }
}
