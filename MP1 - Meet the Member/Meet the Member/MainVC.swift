//
//  MainVC.swift
//  Meet the Member
//
//  Created by Michael Lin on 1/18/21.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    
    // Create a property for our timer, we will initialize it in viewDidLoad
    var timer: Timer?
    var timer2: Timer?
    var isPaused = false
    var correct: Int = 0
    var score: Int = 0
    var streak: Int = 0
    var lastThree:[String] = ["NA", "NA", "NA"]
    var numAnswered: Int = 0
    var currTime: Int = 8
    
    // MARK: STEP 8: UI Customization
    // Customize your imageView and buttons. Run the app to see how they look.
    
    let imageView: UIImageView = {
        let view = UIImageView()
        
        // MARK: >> Your Code Here <<
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let buttons: [UIButton] = {
        // Creates 4 buttons, each representing a choice.
        // Use ..< or ... notation to create an iterable range
        // with step of 1. You can manually create these using the
        // stride() method.
        return (0..<4).map { index in
            let button = UIButton()

            // Tag the button its index
            button.tag = index
            
            button.setTitleColor(.black, for: .normal)

            button.backgroundColor = .systemGray
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }
        
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        
        // == UIColor.darkGray
        label.textColor = .darkGray
        
        label.text = "Score: 0"
            
        // == NSTextAlignment(expected type).center
        label.textAlignment = .center
        
        // == UIFont.systemFont(ofSize: 27, UIFont.weight.medium)
        label.font = .systemFont(ofSize: 27, weight: .medium)
        
        // Must have if you are using constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: STEP 12: Stats Button
    // Follow the examples you've learned so far, initialize a
    // stats button used for going to the stats screen, add it
    // as a subview inside the viewDidLoad and set up the
    // constraints. Finally, connect the button's with the @objc
    // function didTapStats.
    
    private let statsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Stats", for: .normal)
        
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .systemBlue

        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        // Create a timer that calls timerCallback() every one second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        
        // If you don't like the default presentation style,
        // you can change it to full screen too! This way you
        // will have manually to call
        // dismiss(animated: true, completion: nil) in order
        // to go back.
        //
        // modalPresentationStyle = .fullScreen
        
        // MARK: STEP 7: Adding Subviews and Constraints
        // Add imageViews and buttons to the root view. Create constaints
        // for the layout. Then run the app with ⌘+r. You should see the image
        // for the first question as well as the four options.
        
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        view.addSubview(buttons[0])
        
        NSLayoutConstraint.activate([
            buttons[0].topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            buttons[0].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttons[0].widthAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(buttons[1])
        
        NSLayoutConstraint.activate([
            buttons[1].topAnchor.constraint(equalTo: buttons[0].bottomAnchor, constant: 10),
            buttons[1].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttons[1].widthAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(buttons[2])
        
        NSLayoutConstraint.activate([
            buttons[2].topAnchor.constraint(equalTo: buttons[1].bottomAnchor, constant: 10),
            buttons[2].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttons[2].widthAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(buttons[3])
        
        NSLayoutConstraint.activate([
            buttons[3].topAnchor.constraint(equalTo: buttons[2].bottomAnchor, constant: 10),
            buttons[3].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttons[3].widthAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(statsButton)
        
        NSLayoutConstraint.activate([
            statsButton.topAnchor.constraint(equalTo: buttons[3].bottomAnchor, constant: 10),
            statsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsButton.widthAnchor.constraint(equalToConstant: 200)
        ])

        getNextQuestion()
        
        // MARK: STEP 10: Adding Callback to the Buttons
        // Use addTarget to connect the didTapAnswer function to the four
        // buttons touchUpInside event.
        //
        // Challenge: Try not to use four separate statements. There's a
        // cleaner way to do this, see if you can figure it out.
        
        buttons[0].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        buttons[1].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        buttons[2].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        buttons[3].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)

        
        
        // MARK: STEP 12: Stats Button
        // Follow instructions at :49
        
        statsButton.addTarget(self, action: #selector(didTapStats(_:)), for: .touchUpInside)
    }
    
    // What's the difference between viewDidLoad() and
    // viewWillAppear()? What about viewDidAppear()?
    override func viewWillAppear(_ animated: Bool) {
        // MARK: STEP 15: Resume Game
        // Restart the timer when view reappear.
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    func getNextQuestion() {
        // MARK: STEP 5: Connecting to the Data Model
        // Read the QuestionProvider class in Utils.swift. Get an instance of
        // QuestionProvider.Question and use a *guard let* statement to conditionally
        // assign it to a constant named question. Return if the guard let
        // condition failed.
        //
        // After you are done, take a look at what's in the
        // QuestionProvider.Question type. You will need that for the
        // following steps.
        
        let QP = QuestionProvider()
        
        guard let question = QP.getNextQuestion() else { return }
        
        for n in 0...3 {
            if question.choices[n] == question.answer {
                correct = n
            }
        }
        
        
        // MARK: STEP 6: Data Population
        // Populate the imageView and buttons using the question object we obtained
        // above.
        imageView.image = question.image
        buttons[0].setTitle(question.choices[0], for: .normal)
        buttons[1].setTitle(question.choices[1], for: .normal)
        buttons[2].setTitle(question.choices[2], for: .normal)
        buttons[3].setTitle(question.choices[3], for: .normal)
    }
    
    // This function will be called every one second
    @objc func timerCallback() {
        // MARK: STEP 11: Timer's Logic
        // Complete the callback for the one-second timer. Add instance
        // properties and/or methods to the class if necessary. Again,
        // the instruction here is intentionally vague, so read the spec
        // and take some time to plan. you may need
        // to come back and rework this step later on.
        currTime -= 1
        if currTime == 0 {
            currTime = 8
            timer?.invalidate()
            streak = 0
            lastThree[numAnswered%3] = "Incorrect"
            numAnswered+=1
            getNextQuestion()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        }
    }
    
    @objc func stopTimer() {
        timer2?.invalidate()
    }
    
    @objc func didTapAnswer(_ sender: UIButton) {
        // MARK: STEP 9: Buttons' Logic
        // Add logic for the 4 buttons. Take some time to plan what
        // you are gonna write. The 4 buttons should be able to share
        // the same callback. Add instance properties and/or methods
        // to the class if necessary. The instruction here is
        // intentionally vague as I'd like you to decide what you
        // have to do based on the spec. You may need to come back
        // and rework this step later on.
        //
        // Hint: You can use `sender.tag` to identify which button is tapped
        timer?.invalidate()
        if sender.tag == correct {
            sender.backgroundColor = .systemGreen
        } else {
            sender.backgroundColor = .systemRed
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if sender.tag == self.correct {
                self.score = self.score + 1
                self.streak+=1
                self.lastThree[self.numAnswered%3] = "Correct"
                self.numAnswered+=1
                self.scoreLabel.text = "Score: " + String(self.score)
            } else {
                self.streak = 0
                self.lastThree[self.numAnswered%3] = "Incorrect"
                self.numAnswered+=1
            }
            sender.backgroundColor = UIColor.systemGray
            self.getNextQuestion()
            self.currTime = 8
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerCallback), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func didTapStats(_ sender: UIButton) {
        
        timer?.invalidate()
        
        currTime = 8
        
        let vc = StatsVC(data: "Hello")
        
        vc.dataWeNeedExample1 = "Hello"
        
        vc.streak = streak
        
        vc.lastThree = lastThree
        
        vc.numAnswered = numAnswered
        
        // MARK: STEP 13: StatsVC Data
        // Follow instructions in StatsVC. You also need to invalidate
        // the timer instance to pause game before going to StatsVC.
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: STEP 16:
    // Read the spec again and run the app. Did you cover everything
    // mentioned in it? Play around it for a bit, see if you can
    // uncover any bug. Is there anything else you want to add?
}
