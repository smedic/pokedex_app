//
//  PokemonDetailsVC.swift
//  PokeApp
//
//  Created by Stevan Medic on 10/22/17.
//  Copyright © 2017 Stevan Medic. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var pokemonDesc: UILabel!
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var defence: UILabel!
    @IBOutlet weak var pokedexId: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    var pokemon : Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.text = pokemon.name.capitalized
        self.pokedexId.text = "\(pokemon.index)"
        
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
        
        image.image = UIImage(named: "\(pokemon.index)")
        if(pokemon.index % 3 == 1) {
            currentEvoImage.image = UIImage(named: "\(pokemon.index + 1)")
            nextEvoImage.image = UIImage(named: "\(pokemon.index + 2)")
        } else if (pokemon.index % 3 == 2){
            currentEvoImage.image = UIImage(named: "\(pokemon.index + 1)")
            //nextEvoImage.image = UIImage(named: "\(pokemon.index + 1)")
            nextEvoImage.isHidden = true
        } else {
            currentEvoImage.image = UIImage(named: "\(pokemon.index)")
            //nextEvoImage.image = UIImage(named: "\(pokemon.index)")
            evoLabel.text = "No evolutions"
            currentEvoImage.isHidden = true
            nextEvoImage.isHidden = true
        }
    }
    
    func updateUI() {
        weight.text = pokemon.weight
        height.text = pokemon.height
        type.text = pokemon.type
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
