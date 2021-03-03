//
//  FilterVCViewController.swift
//  Pokedex
//
//  Created by Rithwik Mylavarapu on 3/2/21.
//

import UIKit

class FilterVCViewController: UIViewController {
    
    var typeFilters = [PokeType]()
    
    var typeNames = ["Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Psychic", "Rock", "Steel", "Water"]

    let typeButtons: [UIButton] = {
        
        return (0..<18).map { index in
            let button = UIButton()

            // Tag the button its index
            button.tag = index
                        
            button.setTitleColor(.black, for: .normal)

            button.backgroundColor = .systemGray
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Submit", for: .normal)
        
        button.setTitleColor(.black, for: .normal)

        button.backgroundColor = .systemBlue
        
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for n in 0...17 {
            typeButtons[n].setTitle(typeNames[n], for: .normal)
            view.addSubview(typeButtons[n])
        }
        
        view.addSubview(submitButton)
        
//        view.addSubview(typeButtons[0])
//        view.addSubview(typeButtons[1])
//        view.addSubview(typeButtons[2])
//        view.addSubview(typeButtons[3])
//        view.addSubview(typeButtons[4])
//        view.addSubview(typeButtons[5])
//        view.addSubview(typeButtons[6])
//        view.addSubview(typeButtons[7])
//        view.addSubview(typeButtons[8])
//        view.addSubview(typeButtons[9])
//        view.addSubview(typeButtons[10])
//        view.addSubview(typeButtons[11])
//        view.addSubview(typeButtons[12])
//        view.addSubview(typeButtons[13])
//        view.addSubview(typeButtons[14])
//        view.addSubview(typeButtons[15])
//        view.addSubview(typeButtons[16])
//        view.addSubview(typeButtons[17])
        
        NSLayoutConstraint.activate([
            typeButtons[0].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            typeButtons[0].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[1].topAnchor.constraint(equalTo: typeButtons[0].bottomAnchor, constant: 10),
            typeButtons[1].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[2].topAnchor.constraint(equalTo: typeButtons[1].bottomAnchor, constant: 10),
            typeButtons[2].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[3].topAnchor.constraint(equalTo: typeButtons[2].bottomAnchor, constant: 10),
            typeButtons[3].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[4].topAnchor.constraint(equalTo: typeButtons[3].bottomAnchor, constant: 10),
            typeButtons[4].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[5].topAnchor.constraint(equalTo: typeButtons[4].bottomAnchor, constant: 10),
            typeButtons[5].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[6].topAnchor.constraint(equalTo: typeButtons[5].bottomAnchor, constant: 10),
            typeButtons[6].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[7].topAnchor.constraint(equalTo: typeButtons[6].bottomAnchor, constant: 10),
            typeButtons[7].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[8].topAnchor.constraint(equalTo: typeButtons[7].bottomAnchor, constant: 10),
            typeButtons[8].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[9].topAnchor.constraint(equalTo: typeButtons[8].bottomAnchor, constant: 10),
            typeButtons[9].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[10].topAnchor.constraint(equalTo: typeButtons[9].bottomAnchor, constant: 10),
            typeButtons[10].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[11].topAnchor.constraint(equalTo: typeButtons[10].bottomAnchor, constant: 10),
            typeButtons[11].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[12].topAnchor.constraint(equalTo: typeButtons[11].bottomAnchor, constant: 10),
            typeButtons[12].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[13].topAnchor.constraint(equalTo: typeButtons[12].bottomAnchor, constant: 10),
            typeButtons[13].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[14].topAnchor.constraint(equalTo: typeButtons[13].bottomAnchor, constant: 10),
            typeButtons[14].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[15].topAnchor.constraint(equalTo: typeButtons[14].bottomAnchor, constant: 10),
            typeButtons[15].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[16].topAnchor.constraint(equalTo: typeButtons[15].bottomAnchor, constant: 10),
            typeButtons[16].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeButtons[17].topAnchor.constraint(equalTo: typeButtons[16].bottomAnchor, constant: 10),
            typeButtons[17].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: typeButtons[17].bottomAnchor, constant: 10),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])


        
        typeButtons[0].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[1].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[2].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[3].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[4].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[5].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[6].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[7].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[8].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[9].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[10].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[11].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[12].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[13].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[14].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[15].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[16].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        typeButtons[17].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submit(_:)), for: .touchUpInside)

        //add buttons and button handlers and constraints
        //send the array of typeFilters to PokeDex with initializer
        
    }
    
    @objc func submit(_ sender: UIButton) {
        let VC = PokedexVC(inputFilters: typeFilters)
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func didTapAnswer(_ sender: UIButton) {
        if (sender.tag == 0) {
            typeFilters.append(PokeType.Bug)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 1) {
            typeFilters.append(PokeType.Dark)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 2) {
            typeFilters.append(PokeType.Dragon)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 3) {
            typeFilters.append(PokeType.Electric)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 4) {
            typeFilters.append(PokeType.Fairy)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 5) {
            typeFilters.append(PokeType.Fighting)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 6) {
            typeFilters.append(PokeType.Fire)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 7) {
            typeFilters.append(PokeType.Flying)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 8) {
            typeFilters.append(PokeType.Ghost)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 9) {
            typeFilters.append(PokeType.Grass)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 10) {
            typeFilters.append(PokeType.Ground)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 11) {
            typeFilters.append(PokeType.Ice)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 12) {
            typeFilters.append(PokeType.Normal)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 13) {
            typeFilters.append(PokeType.Poison)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 14) {
            typeFilters.append(PokeType.Psychic)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 15) {
            typeFilters.append(PokeType.Rock)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 16) {
            typeFilters.append(PokeType.Steel)
            sender.backgroundColor = .systemGreen
        } else if (sender.tag == 17) {
            typeFilters.append(PokeType.Water)
            sender.backgroundColor = .systemGreen
        }
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
