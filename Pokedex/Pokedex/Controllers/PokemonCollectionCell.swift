//
//  PokemonCollectionCell.swift
//  Pokedex
//
//  Created by Rithwik Mylavarapu on 2/24/21.
//

import UIKit

class PokemonCollectionCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: PokemonCollectionCell.self)
    
    var pokemonName: Pokemon? {
        didSet {
            guard let pokemonName = pokemonName else { return }
            guard let url = URL(string: pokemonName.imageUrl) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            let image: UIImage = UIImage(data: data)!
            imageView.image = image
            titleView.text = pokemonName.name
            idView.text = "ID: " + String(pokemonName.id)
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let idView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        contentView.addSubview(idView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            idView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            idView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            idView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            idView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
