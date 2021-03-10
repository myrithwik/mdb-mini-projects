//
//  SignUpVC.swift
//  MDB Social
//
//  Created by Rithwik Mylavarapu on 3/4/21.
//

import UIKit
import NotificationBannerSwift
import FirebaseAuth
import Firebase


class SignUpVC: UIViewController {

    //Make Fields for name, email, username, password
    //Submit those fields into the pod
    //Send the data back to scene delegate
    //See if it will work to have them sign in again after going back
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 25

        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let signUpLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sign Up"
        lbl.textColor = .primaryText
        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    } ()
    
    private let nameTextField: AuthTextField = {
        let tf = AuthTextField(title: "Name:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let emailTextField: AuthTextField = {
        let tf = AuthTextField(title: "Email:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let usernameTextField: AuthTextField = {
        let tf = AuthTextField(title: "Username:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let passwordTextField: AuthTextField = {
        let tf = AuthTextField(title: "Password:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let signUpButton: LoadingButton = {
        let btn = LoadingButton()
        btn.layer.backgroundColor = UIColor.primary.cgColor
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.isUserInteractionEnabled = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let contentEdgeInset = UIEdgeInsets(top: 120, left: 40, bottom: 30, right: 40)
    private let signUpButtonHeight: CGFloat = 44.0
    private var bannerQueue = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .background
        view.addSubview(signUpLabel)
        
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(stack)
        stack.addArrangedSubview(nameTextField)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(usernameTextField)
        stack.addArrangedSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: contentEdgeInset.left),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -contentEdgeInset.right),
            stack.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor,
                                       constant: 60)
        ])
        
        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            signUpButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            signUpButton.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: signUpButtonHeight)
        ])
        
        signUpButton.layer.cornerRadius = signUpButtonHeight / 2
        
        signUpButton.addTarget(self, action: #selector(didTapSignUp1(_:)), for: .touchUpInside)
        

        // Do any additional setup after loading the view.
    }
    
    func completion()->Void{
        return
    }
    
    @objc func didTapSignUp1(_ sender: UIButton) {
        guard let name = nameTextField.text, name != "" else {
            showErrorBanner(withTitle: "Missing Name",
                            subtitle: "Please provide a Name")
            return
        }
        guard let email = emailTextField.text, email != "" else {
            showErrorBanner(withTitle: "Missing email",
                            subtitle: "Please provide an email")
            return
        }
        guard let username = usernameTextField.text, username != "" else {
            showErrorBanner(withTitle: "Missing username",
                            subtitle: "Please provide an username")
            return
        }
        guard let password = passwordTextField.text, password != "" else {
            showErrorBanner(withTitle: "Missing password",
                            subtitle: "Please provide a password")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let _eror = error {
                //something bad happning
                self.showErrorBanner(withTitle: "Error Signing Up",
                                subtitle: _eror.localizedDescription)
                print(_eror.localizedDescription )
            }else {
                var emptyEvents = [EventID] ()
                let newUser = User(uid: authResult?.user.uid, username: username, email: email, fullname: name, savedEvents: emptyEvents)
                FIRDatabaseRequest.shared.setUser(newUser, completion: {
                    self.completion()
                })
                guard let window = UIApplication.shared
                        .windows.filter({ $0.isKeyWindow }).first else { return }
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                window.rootViewController = vc
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3
                UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
            }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
