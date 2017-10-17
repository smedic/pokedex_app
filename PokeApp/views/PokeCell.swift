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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon : Pokemon) {
        
        self.pokemon = pokemon
        
        image.image = UIImage(named: pokemon.index)
        name.text = pokemon.name
    }
}
