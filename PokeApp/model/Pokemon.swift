//
//  Pokemon.swift
//  PokeApp
//
//  Created by Stevan Medic on 10/17/17.
//  Copyright © 2017 Stevan Medic. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name : String!
    private var _index : String!
    
    var name : String {
        return _name
    }
    
    var index : String {
        return _index
    }
    
    init(name: String, index : String) {
        _name = name
        _index = index
    }
    
}
