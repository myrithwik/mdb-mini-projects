//
//  SettingsVC.swift
//  WeatherDB
//
//  Created by Rithwik Mylavarapu on 3/31/21.


import UIKit

class SettingsVC: UIViewController {

    let placeHolder: UILabel = {
        let lbl = UILabel()
        lbl.text = "Place Holder"

        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var toggleBT: UIButton = {

        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.isSelected = false
        button.setTitle("Grid", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleToggleBT), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func handleToggleBT(sender: UIButton) {

        sender.isSelected = !sender.isSelected

        if sender.isSelected {

        }

        else {

        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(placeHolder)

        NSLayoutConstraint.activate([
            placeHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeHolder.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Do any additional setup after loading the view.
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
