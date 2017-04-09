//
//  CollectionViewCell.swift
//  PokeFinder
//
//  Created by PRO on 3/11/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 8.0
        
    }
    
    func configureCell(poke: String) {
        var indexNumber: Int
        
        self.lbl.text = poke
        indexNumber = pokemon.index(of: poke)!
        self.img.image = UIImage(named: "\(indexNumber + 1)")
        
    }
    
}
