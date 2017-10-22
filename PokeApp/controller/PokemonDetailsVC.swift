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
    
    var pokemon : Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.name.text = pokemon.name
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
