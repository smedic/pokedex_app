//
//  PokeCell.swift
//  PokeApp
//
//  Created by Stevan Medic on 10/17/17.
//  Copyright © 2017 Stevan Medic. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var pokemon : Pokemon!
    
    func configureCell(pokemon : Pokemon) {
        
        self.pokemon = pokemon
        
        image.image = UIImage(named: pokemon.imagePath)
        name.text = pokemon.name
    }
}
