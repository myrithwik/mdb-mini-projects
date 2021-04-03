//
//  AddLocation.swift
//  WeatherDB
//
//  Created by Rithwik Mylavarapu on 3/31/21.
//
//
//import UIKit
//
//class AddLocation: UIViewController {
//
//    let placeHolder: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "Place Holder"
//
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(placeHolder)
//
//        NSLayoutConstraint.activate([
//            placeHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            placeHolder.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

import UIKit
import GooglePlaces

class AddLocation: UIViewController {
    
    var placesClient: GMSPlacesClient!
    
  override func viewDidLoad() {
    makeButton()
    placesClient = GMSPlacesClient.shared()
  }

  // Present the Autocomplete view controller when the button is pressed.
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
  func makeButton() {
    let btnLaunchAc = UIButton(frame: CGRect(x: 5, y: 150, width: 300, height: 35))
    btnLaunchAc.backgroundColor = .blue
    btnLaunchAc.setTitle("Launch autocomplete", for: .normal)
    btnLaunchAc.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
    self.view.addSubview(btnLaunchAc)
  }

}

extension AddLocation: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    print("Place ID: \(place.placeID)")
    print("Place attributions: \(place.attributions)")
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(place.formattedAddress!) { (placemarks, error) in
        guard
            let placemarks = placemarks,
            let location = placemarks.first?.location
        else {
            // handle no location found
            return
        }
        print(type(of: location))
    }
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
