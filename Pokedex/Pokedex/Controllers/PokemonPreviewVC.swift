//
//  PokemonPreviewVC.swift
//  Pokedex
//
//  Created by Rithwik Mylavarapu on 2/27/21.
//

import UIKit

class PokemonPreviewVC: UIViewController {
    
    private let imageView = UIImageView()
    private let nameView = UILabel()
    private let idView = UILabel()
    private let attackView = UILabel()
    private let defenseView = UILabel()
    private let healthView = UILabel()
    private let spAttackView = UILabel()
    private let spDefenseView = UILabel()
    private let speedView = UILabel()
    private let totalView = UILabel()
//    private let typeView = UILabel()

    override func viewDidLoad() {
        view.addSubview(imageView)
        view.addSubview(nameView)
        view.addSubview(idView)
        view.addSubview(attackView)
        view.addSubview(defenseView)
        view.addSubview(healthView)
        view.addSubview(spAttackView)
        view.addSubview(spDefenseView)
        view.addSubview(speedView)
        view.addSubview(totalView)
//        view.addSubview(typeView)
        view.backgroundColor = .clear


        nameView.textColor = .white
        idView.textColor = .white
        attackView.textColor = .white
        defenseView.textColor = .white
        healthView.textColor = .white
        spAttackView.textColor = .white
        spDefenseView.textColor = .white
        speedView.textColor = .white
        totalView.textColor = .white
//        typeView.textColor = .white

        let width = 110
        let height = 110
        preferredContentSize = CGSize(width: width, height: height)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20),
            idView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            attackView.topAnchor.constraint(equalTo: idView.bottomAnchor, constant: 20),
            attackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            defenseView.topAnchor.constraint(equalTo: attackView.bottomAnchor, constant: 20),
            defenseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            healthView.topAnchor.constraint(equalTo: defenseView.bottomAnchor, constant: 20),
            healthView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spAttackView.topAnchor.constraint(equalTo: healthView.bottomAnchor, constant: 20),
            spAttackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spDefenseView.topAnchor.constraint(equalTo: spAttackView.bottomAnchor, constant: 20),
            spDefenseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speedView.topAnchor.constraint(equalTo: spDefenseView.bottomAnchor, constant: 20),
            speedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalView.topAnchor.constraint(equalTo: speedView.bottomAnchor, constant: 20),
            totalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            typeView.topAnchor.constraint(equalTo: totalView.bottomAnchor, constant: 20),
//            typeView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
//    override func viewDidLayoutSubviews() {
//        imageView.frame = view.bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }

    init(pokemonName: Pokemon) {
        super.init(nibName: nil, bundle: nil)

        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        guard let url = URL(string: pokemonName.imageUrl) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        let image: UIImage = UIImage(data: data)!
        imageView.image = image
                
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameView.translatesAutoresizingMaskIntoConstraints = false
        idView.translatesAutoresizingMaskIntoConstraints = false
        attackView.translatesAutoresizingMaskIntoConstraints = false
        defenseView.translatesAutoresizingMaskIntoConstraints = false
        healthView.translatesAutoresizingMaskIntoConstraints = false
        spAttackView.translatesAutoresizingMaskIntoConstraints = false
        spDefenseView.translatesAutoresizingMaskIntoConstraints = false
        speedView.translatesAutoresizingMaskIntoConstraints = false
        totalView.translatesAutoresizingMaskIntoConstraints = false
//        typeView.translatesAutoresizingMaskIntoConstraints = false

        nameView.text = "Name: " + pokemonName.name
        idView.text = "ID: " + String(pokemonName.id)
        attackView.text = "Attack: " + String(pokemonName.attack)
        defenseView.text = "Defense: " + String(pokemonName.defense)
        healthView.text = "Health: " + String(pokemonName.health)
        spAttackView.text = "Special Attack: " + String(pokemonName.specialAttack)
        spDefenseView.text = "Special Defense: " + String(pokemonName.specialDefense)
        speedView.text = "Speed: " + String(pokemonName.speed)
        totalView.text = "Total: " + String(pokemonName.total)
        
//        statsView.text = "Name: " + pokemonName.name + "\n" + "ID: " + String(pokemonName.id) + "\n" + "Types: " + pokemonName.types + "\n"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
