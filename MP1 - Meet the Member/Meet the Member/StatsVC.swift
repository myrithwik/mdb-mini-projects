//
//  StatsVC.swift
//  Meet the Member
//
//  Created by Michael Lin on 1/18/21.
//

import UIKit

class StatsVC: UIViewController {
    
    // MARK: STEP 13: StatsVC Data
    // When we are navigating between VCs (e.g MainVC -> StatsVC),
    // since MainVC doesn't directly share its instance properties
    // with other VCs, we often need a mechanism of transferring data
    // between view controllers. There are many ways to achieve
    // this, and I will show you the two most common ones today. After
    // carefully reading these two patterns, pick one and implement
    // the data transferring for StatsVC.
    
    // Method 1: Implicit Unwrapped Instance Property
    var dataWeNeedExample1: String!
    var streak: Int!
    var lastThree: [String]!
    var numAnswered: Int!
    //
    // Check didTapStats in MainVC.swift on how to use it.
    //
    // Explaination: This method is fairly straightforward: you
    // declared a property, which will then be populated after
    // the VC is instantiated. As long as you remember to
    // populate it after each instantiation, the implicit forced
    // unwrap will not result in a crash.
    //
    // Pros: Easy, no boilerplate required
    //
    // Cons: Poor readability. Imagine if another developer wants to
    // use this class, unless it's been well-documented, they would
    // have no idea that this variable needs to be populated.
    
    // Method 2: Custom initializer
    var dataWeNeedExample2: String
    init(data: String) {
        dataWeNeedExample2 = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    // Check didTapStats in MainVC.swift on how to use it.
    //
    // Explaination: This method creates a custom initializer which
    // takes in the required data. This pattern results in a cleaner
    // initialization and is more readable. Compared with method 1
    // which first initialize the data to nil then populate, in this
    // method the data is directly initialized in the init so there's
    // no need for unwrapping of any kind.
    //
    // Pros: Clean. Null safe.
    //
    // Cons: Doesn't work with interface builder (storyboard)
    
    // MARK: >> Your Code Here <<
    
    // MARK: STEP 14: StatsVC UI
    // You know the drill. Initialize the UI components, add subviews,
    // and create contraints.
    //
    // Note: You cannot use self inside these closures because they
    // happens before the instance is fully initialized. If you want
    // to use self, do it in viewDidLoad.
    
    // MARK: >> Your Code Here <<
    
    private let streakLabel: UILabel = {
        let label = UILabel()
        
        // == UIColor.darkGray
        label.textColor = .darkGray
        
//        label.text = String("\(streak)")
        
        label.text = "Longest Streak: 0"
        
        // == NSTextAlignment(expected type).center
        label.textAlignment = .center
        
        // == UIFont.systemFont(ofSize: 27, UIFont.weight.medium)
        label.font = .systemFont(ofSize: 27, weight: .medium)
        
        // Must have if you are using constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let lastThreeLabel: UILabel = {
        let label = UILabel()
        
        // == UIColor.darkGray
        label.textColor = .darkGray
        
        
//        label.text = lastThree[0] + ", " + lastThree[1] + ", " + lastThree[2]
        
        label.text = "Sample, Last, Three"
        
        // == NSTextAlignment(expected type).center
        label.textAlignment = .center
        
        // == UIFont.systemFont(ofSize: 27, UIFont.weight.medium)
        label.font = .systemFont(ofSize: 27, weight: .medium)
        
        // Must have if you are using constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Dismiss", for: .normal)
        
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .systemBlue

        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        
        streakLabel.text = "Longest Streak: " + String(streak)
        lastThreeLabel.text = lastThree[numAnswered % 3] + ", " + lastThree[(numAnswered + 1) % 3] + ", " + lastThree[(numAnswered + 2) % 3]
        
        view.addSubview(streakLabel)
        
        NSLayoutConstraint.activate([
            streakLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            streakLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(lastThreeLabel)
        NSLayoutConstraint.activate([
            lastThreeLabel.topAnchor.constraint(equalTo: streakLabel.bottomAnchor, constant: 100),
            lastThreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: lastThreeLabel.bottomAnchor, constant: 100),
            
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        dismissButton.addTarget(self, action: #selector(didTapDismiss(_:)), for: .touchUpInside)

    }
    
    @objc func didTapDismiss(_ sender: UIButton) {
//        let vc = MainVC()
        
        dismiss(animated: true, completion: nil)
        
    }
}
