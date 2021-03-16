//
//  EventPreviewVC.swift
//  MDB Social
//
//  Created by Rithwik Mylavarapu on 3/11/21.
//

import UIKit
import FirebaseFirestore

class EventPreviewVC: UIViewController {
    
    //Add logic for if the person is the owner of the post
    
    let db = Firestore.firestore()

    private let posterView = UILabel()
    private let nameView = UILabel()
    private let imageView = UIImageView()
    private let numRSVPView = UILabel()
    private let descriptionView = UILabel()
    private var actionButton = UIButton()
    private var event: Event?
    
    lazy var removeButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button.backgroundColor = .systemRed
        button.setTitle("Remove Event", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleRemoveBT), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rsvpButton: UIButton = {

        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button.backgroundColor = .systemGreen
        button.isSelected = false
        button.setTitle("RSVP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleToggleBT), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleToggleBT(sender: UIButton) {
        //Set logic to send RSVP to database and delete
        
        sender.isSelected = !sender.isSelected

        if sender.isSelected {
            
            if !event!.rsvpUsers.contains(FIRAuthProvider.shared.auth.currentUser!.uid) {
                event!.rsvpUsers.append(FIRAuthProvider.shared.auth.currentUser!.uid)
            }
            sender.backgroundColor = .systemRed
            sender.setTitleColor(.black, for: .normal)
            rsvpButton.setTitle("Cancel", for: .normal)
        }

        else {

            event!.rsvpUsers.removeAll(where: {$0 == FIRAuthProvider.shared.auth.currentUser!.uid})
            sender.backgroundColor = .systemGreen
            sender.setTitleColor(.white, for: .normal)
            rsvpButton.setTitle("RSVP", for: .normal)
        }
        db.collection("events").document(event!.id!).setData([ "rsvpUsers": event!.rsvpUsers], merge: true)

        numRSVPView.text = "Number RSVP'd: " + String(event!.rsvpUsers.count)
        self.reloadInputViews()
    }
    
    @objc func handleRemoveBT(sender: UIButton) {
        //use db to remove from Firestone
        db.collection("events").document(event!.id!).delete()
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        view.addSubview(posterView)
        view.addSubview(nameView)
        view.addSubview(numRSVPView)
        view.addSubview(imageView)
        view.addSubview(actionButton)
//        view.addSubview(rsvpButton)
//        view.addSubview(removeButton)
        view.addSubview(descriptionView)
        view.backgroundColor = .white

        let width = 110
        let height = 110
        preferredContentSize = CGSize(width: width, height: height)
        
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            posterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            nameView.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 10),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            imageView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            descriptionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            
            numRSVPView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 10),
            numRSVPView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            actionButton.topAnchor.constraint(equalTo: numRSVPView.bottomAnchor, constant: 10),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
//            removeButton.topAnchor.constraint(equalTo: numRSVPView.bottomAnchor, constant: 10),
//            removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }

    init(eventName: Event) {
        super.init(nibName: nil, bundle: nil)
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        let userListener = db.collection("users").document(eventName.creator).addSnapshotListener { [weak self] docSnapshot, error in
            guard let document = docSnapshot else {
                print("Error finding docSnapshot")
                return
            }
            guard let user = try? document.data(as: User.self) else {
                print("Error opening user data")
                return
            }
            self?.posterView.text = "Posted By: " + String(user.fullname) //Have to change this to user name
        }
        let gsReference = FIRStorage.shared.storage.reference(forURL: eventName.photoURL)
        gsReference.getData(maxSize: 25*1024*1024) { (data, error) in
            if let error = error {
                print(error)
            } else {
                self.imageView.image = UIImage(data: data!) ?? UIImage()
            }
        }
        event = eventName
        nameView.text = "Event Name: " + eventName.name
        numRSVPView.text = "Number RSVP'd: " + String(eventName.rsvpUsers.count)
        descriptionView.text = "Description: " + eventName.description
        descriptionView.lineBreakMode = .byWordWrapping
        descriptionView.numberOfLines = 0
                
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameView.translatesAutoresizingMaskIntoConstraints = false
        numRSVPView.translatesAutoresizingMaskIntoConstraints = false
        posterView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false

        if event!.creator != FIRAuthProvider.shared.auth.currentUser!.uid {
            actionButton = rsvpButton
            rsvpButton.translatesAutoresizingMaskIntoConstraints = false
        } else {
            actionButton = removeButton
            removeButton.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
