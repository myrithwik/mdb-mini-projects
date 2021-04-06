//
//  ViewController.swift
//  WeatherDB
//
//  Created by Michael Lin on 3/20/21.
//

import UIKit
import CoreLocation
import GooglePlaces

class ViewController: UIViewController {
    
    var placesClient: GMSPlacesClient!
    
    let myLocation = CLLocation(latitude: 37.8715, longitude: 122.2730)
    
    
    let secondLocation = CLLocation(latitude: 24.33, longitude: 100.12)
    
    var darkMode = false
    
    var locations: [CLLocation] = [] {
        didSet {
//            locations.map { (location : CLLocation) -> Void in
//
//            }
//            let latitudeArray = UserDefaults.standard.NSArray(ßforKey: "latitudes") ?? []
            collectionView.reloadData()
        }
    }
    
    var currLocation: CLLocation? {
        didSet {
            locations.append(currLocation!)
        }
    }
    
    let weatherLabel = UILabel()
    
    var currLocationWeather = WeatherViewCollectionViewCell(frame: .zero)
        
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(WeatherViewCollectionViewCell.self, forCellWithReuseIdentifier: WeatherViewCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    func getData() {
        
    }
    
    func addLocation(location: CLLocation) {
        locations.append(location)
    }
    
    private let darkButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        btn.backgroundColor = .systemBlue
        btn.setTitle("Dark Mode", for: .normal)
        btn.titleLabel?.font = UIFont(name: "...", size: 18)
        btn.tintColor = .black
        btn.layer.cornerRadius = 15
        btn.isSelected = false
        btn.addTarget(self, action: #selector(didTapDark), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    override func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currLocation = LocationManager.shared.location!
        }

        super.viewDidLoad()
//        locations.append(myLocation)
//        locations.append(secondLocation)
        
        view.addSubview(collectionView)
        view.addSubview(darkButton)
        let gplaceButton = makeButton()
        self.view.addSubview(gplaceButton)

        
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 100, left: 30, bottom: 100, right: 30))
        
        collectionView.allowsSelection = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            gplaceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            gplaceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            gplaceButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            
            darkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            darkButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130),
            darkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
                
    }
    
    @objc func autocompleteClicked(_ sender: UIButton) {
      let autocompleteController = GMSAutocompleteViewController()
      autocompleteController.delegate = self

      // Specify the place data types to return.
      let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
        UInt(GMSPlaceField.placeID.rawValue))
      autocompleteController.placeFields = fields

      // Specify a filter.
      let filter = GMSAutocompleteFilter()
      filter.type = .address
      autocompleteController.autocompleteFilter = filter

      // Display the autocomplete view controller.
      present(autocompleteController, animated: true, completion: nil)
    }

    // Add a button to the view.
    func makeButton() -> UIButton {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        btn.backgroundColor = .systemBlue
        btn.setTitle("Add Location", for: .normal)
        btn.titleLabel?.font = UIFont(name: "...", size: 18)
        btn.tintColor = .black
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)

        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }
    
    @objc func didTapDark(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            //Dark
            view.backgroundColor = .black
            darkMode = true
            sender.setTitle("Light Mode", for: .normal)
            self.view.overrideUserInterfaceStyle = .dark
        } else {
            //light
            sender.setTitle("Dark Mode", for: .normal)
            self.view.backgroundColor = .white
            self.view.overrideUserInterfaceStyle = .light
            darkMode = false
        }
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherViewCollectionViewCell.reuseIdentifier, for: indexPath) as! WeatherViewCollectionViewCell
        
        if darkMode {
            cell.color = .white
        } else {
            cell.color = .black
        }
        
        let location  = locations[indexPath.item]
        WeatherRequest.shared.weather(at: location, completion: { result in
           switch result {
              case .success(let weather):
                cell.weather = weather
                return
              case .failure(let error):
                print(error)
                return
           }
        })
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 100, height: view.bounds.height)
    }
}

extension ViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    print("Place ID: \(place.placeID)")
    print("Place attributions: \(place.attributions)")
//    let newLocation = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
    let geoCoder = CLGeocoder()
    print(String(place.coordinate.latitude) + ", " + String(place.coordinate.longitude))
    geoCoder.geocodeAddressString(place.name!) { (placemarks, error) in
        guard
            let placemarks = placemarks,
            let location = placemarks.first?.location
        else {
            // handle no location found
            return
        }
        print(type(of: location))
        self.locations.append(location)
    }
//    self.locations.append(newLocation)
    dismiss(animated: true, completion: nil)

  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}

