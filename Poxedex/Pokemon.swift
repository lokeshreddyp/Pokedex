//
//  Pokemon.swift
//  Poxedex
//
//  Created by lokeshreddy on 1/19/17.
//  Copyright © 2017 lokeshreddy. All rights reserved.
//

import UIKit

class Pokemon {
    fileprivate var _name:String!
    fileprivate var _pokemonid:Int!
    
    var name:String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    var pokemonid:Int {
        if _pokemonid == nil {
            _pokemonid = 0
        }
        return _pokemonid
    }
    
    
    init(name:String , pokemonid:Int) {
        self._name = name
        self._pokemonid = pokemonid
    }
}
