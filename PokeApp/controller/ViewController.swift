//
//  ViewController.swift
//  PokeApp
//
//  Created by Stevan Medic on 10/17/17.
//  Copyright © 2017 Stevan Medic. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
    UISearchBarDelegate{

    @IBOutlet weak var pokemonsCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var filtered = [Pokemon]()
    var isSearchMode = false
    
    var audioPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pokemonsCollection.delegate = self
        pokemonsCollection.dataSource = self
        
        searchBar.delegate = self
        
        initAudio()
        parsePokemonCSV()
        
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            //audioPlayer.play()
        } catch let err as NSError {
            print("Audio init failed \(err)")
        }
    }

    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let arrays = text.csvRows().dropFirst()
            for entry in arrays {
                let pokemon = Pokemon(name: entry[1], index: entry[0])
                pokemons.append(pokemon)
            }
        } catch let err as NSError {
            print("Parsing csv file failed \(err)")
        }
        
        print("Pokemon size: \(pokemons.count)")
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let pokemon : Pokemon!
            if isSearchMode {
                pokemon = filtered[indexPath.row]
            } else {
                pokemon = pokemons[indexPath.row]
            }
            cell.configureCell(pokemon: pokemon)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var pokemon: Pokemon!
        if isSearchMode {
            pokemon = filtered[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailsVC", sender: pokemon)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchMode {
            return filtered.count
        }
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    @IBAction func musicButtonClicked(_ sender: UIButton) {
        if(audioPlayer.isPlaying) {
            audioPlayer.pause()
            sender.alpha = 0.2
        } else {
            audioPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearchMode = false
            view.endEditing(true)
        } else {
            isSearchMode = true
            let lower = searchBar.text!.lowercased()
            filtered = pokemons.filter({$0.name.range(of: lower) != nil})
        }
        pokemonsCollection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailsVC" {
            if let detailsVC = segue.destination as? PokemonDetailsVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
}

