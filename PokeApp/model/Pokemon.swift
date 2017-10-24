//
//  Pokemon.swift
//  PokeApp
//
//  Created by Stevan Medic on 10/17/17.
//  Copyright © 2017 Stevan Medic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Pokemon {
    
    private var _name : String!
    private var _index : Int!
    private var _desc : String!
    private var _type: String!
    private var _defence : String!
    private var _height : String!
    private var _weight : String!
    private var _attack : String!
    private var _evoLabel : String!

    private var _pokeUrl : String!
    
    var name : String {
        return _name
    }
    
    var index : Int {
        return _index
    }
    
    var type : String {
        return _type
    }
    
    var height : String {
        return _height
    }
    
    var weight : String {
        return _weight
    }
    
    init(name: String, index : String) {
        self._name = name
        self._index = Int(index)
        
        self._pokeUrl = "\(URL_BASE)\(URL_POKEMON)\(self._index!)"
    }
    
    func downloadPokemonDetails(completed : @escaping DownloadComplete) {
        
        Alamofire.request(self._pokeUrl!).responseJSON { response in
            
            let json = JSON(response.result.value!)
            self._weight = "\(json["weight"].int!)"
            self._height = "\(json["height"].int!)"
            
            let array = json["types"].array!
            
            var pokeType : String = ""
            var counter : Int = 0
            
            for it in array {
                if(counter > 0) {
                    pokeType += "/"
                }
                pokeType += it["type"]["name"].string!
                counter = counter + 1
            }
            self._type = pokeType.capitalized
            
            completed()
        }
    }
    
}
