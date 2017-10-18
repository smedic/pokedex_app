//
//  ViewController.swift
//  PokeApp
//
//  Created by Stevan Medic on 10/17/17.
//  Copyright © 2017 Stevan Medic. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var pokemonsCollection: UICollectionView!
    
    var pokemons = [Pokemon]()
    
    var audioPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pokemonsCollection.delegate = self
        pokemonsCollection.dataSource = self
        
        initAudio()
        parsePokemonCSV()
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch let err as NSError {
            print("Audio init failed \(err)")
        }
    }

    func parsePokemonCSV() {
        if let path = Bundle.main.path(forResource: "pokemon", ofType: "csv") {
            do {
                let text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                let arrays = text.csvRows()
                for entry in arrays {
                    let pokemon = Pokemon(name: entry[1], index: entry[0])
                    pokemons.append(pokemon)
                }
            } catch {
                print("Failed to read text from")
            }
        } else {
            print("Failed to load file from app bundle ")
        }
        
        print("Pokemon size: \(pokemons.count)")
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let pokemon = pokemons[indexPath.row]
            cell.configureCell(pokemon: pokemon)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
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
}

