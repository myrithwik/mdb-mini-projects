//
//  EventCollectionCell.swift
//  MDB Social
//
//  Created by Rithwik Mylavarapu on 3/7/21.
//

import UIKit
import FirebaseFirestore

class EventCollectionCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: EventCollectionCell.self)

    let db = Firestore.firestore()
    
    var eventName: Event? {
        didSet {
            guard let eventName = eventName else {
                print("Couldn't find eventName")
                return
            }
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
            nameView.text = "Event Name: " + eventName.name
//            posterView.text = "Posted By: " + String(user1.fullname) //Have to change this to user name
            rsvpView.text = "Number RSVP'd: " + String(eventName.rsvpUsers.count)
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let posterView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rsvpView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameView)
        contentView.addSubview(posterView)
        contentView.addSubview(rsvpView)
        
        NSLayoutConstraint.activate([
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            nameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameView.topAnchor.constraint(equalTo: posterView.topAnchor, constant: 20),
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
//
            rsvpView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            rsvpView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
