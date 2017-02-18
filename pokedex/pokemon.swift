//
//  pokemon.swift
//  pokedex
//
//  Created by christian Picondo on 18/02/2017.
//  Copyright © 2017 cpicondo. All rights reserved.
//

import Foundation

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    
    //getter
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
    }
    
}
