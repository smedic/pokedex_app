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
    private var _desc : String!
    private var _type: String!
    private var _defence : String!
    private var _height : String!
    private var _weight : String!
    private var _attack : String!
    private var _evoLabel : String!

    
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
