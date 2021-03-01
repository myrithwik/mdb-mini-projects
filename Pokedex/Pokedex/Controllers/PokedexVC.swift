//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//

import UIKit

class PokedexVC: UIViewController, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var numPerRow = 3
    
    let pokemons = PokemonGenerator.shared.getPokemonArray()
    
    var filteredPokemons: [Pokemon]?
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(PokemonCollectionCell.self, forCellWithReuseIdentifier: PokemonCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    lazy var toggleBT: UIButton = {

        let button = UIButton()
        button.frame = CGRect(x: 40, y: 100, width: 200, height: 40)
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

            numPerRow = 2
            sender.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            sender.setTitleColor(.black, for: .normal)
            toggleBT.setTitle("Rows", for: .normal)
        }

        else {

            numPerRow = 3
            sender.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            sender.setTitleColor(.white, for: .normal)
            toggleBT.setTitle("Grid", for: .normal)
        }
        
        self.collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        filteredPokemons = pokemons
//        searchController.searchResultsUpdater = self
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.dimsBackgroundDuringPresentation = false
//        tableView.tableHeaderView = searchController.searchBar
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        view.backgroundColor = .clear
        
        view.addSubview(toggleBT)
        view.addSubview(collectionView)
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 88, left: 30, bottom: 0, right: 30))
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            toggleBT.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            toggleBT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //searchTest is what you gotta search for
    }
    
}

extension PokedexVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionCell.reuseIdentifier, for: indexPath) as! PokemonCollectionCell
        cell.pokemonName = pokemons[indexPath.item]
        return cell
    }
}

extension PokedexVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(UIScreen.main.bounds.width) / numPerRow, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let pokemonName = pokemons[indexPath.item]
        
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
            return PokemonPreviewVC(pokemonName: pokemonName)
        }) {_ in
            let previewItem = UIAction(title: "Preview", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left")) {_ in}
            return UIMenu(title: "", image: nil, identifier: nil, children: [previewItem])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonName = pokemons[indexPath.item]
        let VC = PokemonPreviewVC(pokemonName: pokemonName)
        
//        self.navigationController?.pushViewController(VC, animated: true)
    }
}

