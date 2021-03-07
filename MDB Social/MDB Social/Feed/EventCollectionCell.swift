//
//  EventCollectionCell.swift
//  MDB Social
//
//  Created by Rithwik Mylavarapu on 3/7/21.
//

import UIKit

class EventCollectionCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: EventCollectionCell.self)
    
    var eventName: Event? {
        didSet {
            guard let eventName = eventName else { return }
//            guard let url = URL(string: eventName.photoURL) else { return }
//            guard let data = try? Data(contentsOf: url) else { return }
//            let image: UIImage = UIImage(data: data)!
//            imageView.image = image
//            nameView.text = "Event Name: " + eventName.name
            posterView.text = "Posted By: " + String(eventName.creator) //Have to change this to user name
            rsvpView.text = "Number RSVP'd: " + String(eventName.rsvpUsers.count)
            print("set")
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
        
//        contentView.addSubview(imageView)
        contentView.addSubview(nameView)
        contentView.addSubview(posterView)
//        contentView.addSubview(rsvpView)
        
        NSLayoutConstraint.activate([
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            nameView.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 10),
            nameView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 10),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//
//            rsvpView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            rsvpView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
