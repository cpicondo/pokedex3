//
//  pokemon.swift
//  pokedex
//
//  Created by christian Picondo on 18/02/2017.
//  Copyright © 2017 cpicondo. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    
    //GETTERS
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    
    var height: String {
        
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    
    
    //LAZY loading 
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    
                    self._height = height
                
                }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                
                }
                
                if let defense = dict["defense"] as? Int {
                
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                
                //Check if the types of the pokemon is more than if yes, we do a for loop
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count  {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    print(self._type)
                    
                } else {
                    self._type = ""
                }
                
                
                
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>],  descArray.count > 0 {
                    
                    if let url = descArray[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        //adding another Alamofire request before the data is from another JSON url
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            let result = response.result
                            
                            if let descDict = result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDescription
                                    print(self._description)
                                }
                                
                            }
                            completed()
                        })
                    }
                }
                else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        //Check if the next evolution is mega
                        if nextEvo.range(of: "mega") == nil {
                            
                           self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                //the return of uri is URL, all we need is the last number of link. so need to remove some of the values
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoID = newString.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionID = nextEvoID
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                }else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                    print(self._nextEvolutionLevel)
                    print(self._nextEvolutionName)
                    print(self._nextEvolutionID)
                }
                
            }
            completed()
        }
    }
}





















