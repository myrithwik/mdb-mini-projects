//
//  FeedVC.swift
//  MDB Social
//
//  Created by Michael Lin on 2/25/21.
//

import UIKit

class FeedVC: UIViewController {
        
//    var events = [Event]()
    
    func startEvents (){
        FIRDatabaseRequest.shared.getEvents(reloadFeed: reloadFeed)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.collectionView.reloadData()
//            print("Events: \(FIRDatabaseRequest.shared.events)")
//            return
//        }
    }
    
    func reloadFeed() {
        collectionView.reloadData()
//        print(FIRDatabaseRequest.shared.events)
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(EventCollectionCell.self, forCellWithReuseIdentifier: EventCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    private let signOutButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        btn.backgroundColor = .primary
        btn.setTitle("Sign Out", for: .normal)
        btn.titleLabel?.font = UIFont(name: "...", size: 15)
        btn.tintColor = .black
        btn.layer.cornerRadius = 15
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    override func viewDidLoad() {
        startEvents()
        view.addSubview(signOutButton)
        view.addSubview(collectionView)
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 150, left: 30, bottom: 0, right: 30))
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            signOutButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -85)
        ])
        
        signOutButton.addTarget(self, action: #selector(didTapSignOut(_:)), for: .touchUpInside)
    }
    
    @objc func didTapSignOut(_ sender: UIButton) {
        FIRDatabaseRequest.shared.clearEvents()
        FIRAuthProvider.shared.signOut {
            guard let window = UIApplication.shared
                    .windows.filter({ $0.isKeyWindow }).first else { return }
//            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
            let vc = SigninVC()
            window.rootViewController = vc
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
        }
    }
}

extension FeedVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FIRDatabaseRequest.shared.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.reuseIdentifier, for: indexPath) as! EventCollectionCell
        let eventName  = FIRDatabaseRequest.shared.events[indexPath.item]
        cell.eventName = eventName
        return cell
    }
}

extension FeedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 100, height: 300)
    }
}
