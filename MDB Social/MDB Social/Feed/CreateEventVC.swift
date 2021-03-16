//
//  CreateEventVC.swift
//  MDB Social
//
//  Created by Rithwik Mylavarapu on 3/11/21.
//

import UIKit
import NotificationBannerSwift
import FirebaseFirestore
import FirebaseStorage

class CreateEventVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let storage = Storage.storage()
    var photoURL: URL?
    
    
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
    
    private let pictureField: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        btn.backgroundColor = .primary
        btn.setTitle("Select Photo", for: .normal)
        btn.titleLabel?.font = UIFont(name: "...", size: 15)
        btn.tintColor = .black
        btn.layer.cornerRadius = 15
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let descriptionTextField: AuthTextField = {
        let tf = AuthTextField(title: "Description (Up to 140 Characters):")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let dateField: AuthTextField = {
        let tf = AuthTextField(title: "Start Daate (DD/MM/YY):")
        
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
        pictureField.addTarget(self, action: #selector(didTapPicture(_:)), for: .touchUpInside)


        // Do any additional setup after loading the view.
    }
    
    func completion()->Void{
        return
    }
    
    @objc func didTapPicture(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        var data = Data()
        //How to return string with image path
        //Then put it in event consturctor
        
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        let storageRef = storage.reference()
        let imageRef = storageRef.child("\(imagePath)")
        
        let jpegData = image.jpegData(compressionQuality: 0.8)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        let uploadTask = imageRef.putData(jpegData!, metadata: metaData) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            print(error?.localizedDescription)
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
            imageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              print("error setting downloadURL")
              return
            }
            print("Download URL: \(downloadURL)")
            self.photoURL = downloadURL
          }
        }
        
        dismiss(animated: true) {
            return
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @objc func didTapCreate(_ sender: UIButton) {
        guard let name = nameTextField.text, name != "" else {
            showErrorBanner(withTitle: "Missing Event Name",
                            subtitle: "Please provide a name")
            return
        }
        guard let picture = photoURL, photoURL != nil else {
            showErrorBanner(withTitle: "Missing Picture",
                            subtitle: "Please provide a picture")
            return
        }
        guard let description = descriptionTextField.text, description != "" else {
            showErrorBanner(withTitle: "Missing Description",
                            subtitle: "Please provide an description")
            return
        }
        if description.count > 140 {
            showErrorBanner(withTitle: "Description too Long",
                            subtitle: "Please keep description under 140 characters")
            return
        }
        guard let date = dateField.text, date != "" else {
            showErrorBanner(withTitle: "Missing Date",
                            subtitle: "Please provide a date")
            return
        }
        
        //take string from date and convert to timeStamp (dateFormatter)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.date(from: date)
        let dateTimeStamp  = dateString!.timeIntervalSince1970
        let dateTS:Timestamp = Timestamp(date: dateString!)
        let newEvent = Event(name: name, description: description, photoURL: "\(picture)", startTimeStamp: dateTS, creator: FIRAuthProvider.shared.currentUser!.uid!, rsvpUsers: [UserID]())
        
        FIRDatabaseRequest.shared.setEvent(newEvent) {
            //update UI after the event is created
            self.navigationController?.popViewController(animated: true)
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
