//
//  SecondVC.swift
//  PokeFinder
//
//  Created by PRO on 3/11/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit

protocol MyProtocol {
    func getSelectedID(id: Int)
}

class SecondVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: MyProtocol?
    var inSearchMode = false
    
    var filteredPokemon: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        searchBar.delegate = self
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            
            if inSearchMode {
                var poke: String
                poke = filteredPokemon[indexPath.row]
                
                cell.configureCell(poke: poke)
            }else {
                var poke: String
                poke = pokemon[indexPath.row]
                
                cell.configureCell(poke: poke)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var selectedID: Int
        var selectedPoke: String
        
        if inSearchMode {
            
            selectedPoke = filteredPokemon[indexPath.row]
            selectedID = pokemon.index(of: selectedPoke)! + 1
            
        } else{
            
            selectedID = indexPath.row + 1
            
        }
        
        delegate?.getSelectedID(id: selectedID)
        
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        }
        else {
            inSearchMode = true
            let keyword = searchBar.text!.lowercased()
            
            //Koristimo ovaj filter jer imamo listu stringova a ne objekta kao u pokedex aplikaciji
            filteredPokemon = pokemon.filter{$0.range(of:keyword, options: .caseInsensitive) !=  nil}
            
            collectionView.reloadData()
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
