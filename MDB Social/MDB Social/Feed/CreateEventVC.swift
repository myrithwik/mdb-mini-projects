//
//  CreateEventVC.swift
//  MDB Social
//
//  Created by Rithwik Mylavarapu on 3/11/21.
//

import UIKit
import NotificationBannerSwift


class CreateEventVC: UIViewController {

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 25

        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let createLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Create Event"
        lbl.textColor = .primaryText
        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    } ()
    
    private let nameTextField: AuthTextField = {
        let tf = AuthTextField(title: "Event Name:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let pictureField: AuthTextField = {
        let tf = AuthTextField(title: "Picture (Add more formatting):")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let descriptionTextField: AuthTextField = {
        let tf = AuthTextField(title: "Description (Up to 140 Characters):")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let dateField: AuthTextField = {
        let tf = AuthTextField(title: "Start Daate (MM/DD/YYYY):")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let createButton: LoadingButton = {
        let btn = LoadingButton()
        btn.layer.backgroundColor = UIColor.primary.cgColor
        btn.setTitle("Create Event", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.isUserInteractionEnabled = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let contentEdgeInset = UIEdgeInsets(top: 120, left: 40, bottom: 30, right: 40)
    private let createButtonHeight: CGFloat = 44.0
    private var bannerQueue = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .background
        view.addSubview(createLabel)
        
        NSLayoutConstraint.activate([
            createLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            createLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(stack)
        stack.addArrangedSubview(nameTextField)
        stack.addArrangedSubview(pictureField)
        stack.addArrangedSubview(descriptionTextField)
        stack.addArrangedSubview(dateField)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: contentEdgeInset.left),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -contentEdgeInset.right),
            stack.topAnchor.constraint(equalTo: createLabel.bottomAnchor,
                                       constant: 60)
        ])
        
        view.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            createButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            createButton.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            createButton.heightAnchor.constraint(equalToConstant: createButtonHeight)
        ])
        
        createButton.layer.cornerRadius = createButtonHeight / 2
        
        createButton.addTarget(self, action: #selector(didTapCreate(_:)), for: .touchUpInside)
        

        // Do any additional setup after loading the view.
    }
    
    func completion()->Void{
        return
    }
    
    @objc func didTapCreate(_ sender: UIButton) {
        guard let name = nameTextField.text, name != "" else {
            showErrorBanner(withTitle: "Missing Event Name",
                            subtitle: "Please provide a name")
            return
        }
        guard let picture = pictureField.text, picture != "" else {
            showErrorBanner(withTitle: "Missing Picture",
                            subtitle: "Please provide a picture")
            return
        }
        guard let description = descriptionTextField.text, description != "" else {
            showErrorBanner(withTitle: "Missing Description",
                            subtitle: "Please provide an description")
            return
        }
        guard let date = dateField.text, date != "" else {
            showErrorBanner(withTitle: "Missing Date",
                            subtitle: "Please provide a date")
            return
        }
        
            
    }
        
        private func showErrorBanner(withTitle title: String, subtitle: String? = nil) {
            guard bannerQueue.numberOfBanners == 0 else { return }
            let banner = FloatingNotificationBanner(title: title, subtitle: subtitle,
                                                    titleFont: .systemFont(ofSize: 17, weight: .medium),
                                                    subtitleFont: subtitle != nil ?
                                                        .systemFont(ofSize: 14, weight: .regular) : nil,
                                                    style: .warning)
            
            banner.show(bannerPosition: .top,
                        queue: bannerQueue,
                        edgeInsets: UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15),
                        cornerRadius: 10,
                        shadowColor: .primaryText,
                        shadowOpacity: 0.3,
                        shadowBlurRadius: 10)
        }

}
