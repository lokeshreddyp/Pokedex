//
//  Pokemon.swift
//  Poxedex
//
//  Created by lokeshreddy on 1/19/17.
//  Copyright © 2017 lokeshreddy. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class Pokemon {
    private var _name:String!
    private var _pokemonid:Int!
    private var _description:String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextevolution:String!
    private var _pokemonurl:String!
    private var _nextevolutionName:String!
    private var _nextevolutionid:String!
    private var _nextevolutionLVL:String!
    
    
    var nextevolutionName:String! {
        if _nextevolutionName == nil {
            _nextevolutionName = ""
        }
        return _nextevolutionName
    }
    var nextevolutionid:String! {
        if _nextevolutionid == nil {
            _nextevolutionid = ""
        }
        return _nextevolutionid
    }
    var nextevolutionLVL:String! {
        if _nextevolutionLVL == nil {
            _nextevolutionLVL = ""
        }
        return _nextevolutionLVL
    }
    var name:String! {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    
    
    var type:String! {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense:String! {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var height:String! {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight:String! {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var nextevolution:String! {
        if _nextevolution == nil {
            _nextevolution = ""
        }
        return _nextevolution
    }
    
    
    
    var attack:String! {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
 
    
    var pokemonurl:String! {
        if _pokemonurl == nil {
            _pokemonurl = ""
        }
        return _pokemonurl
    }
    var descrip: String! {
        if _description == nil {
            _description = ""
        }
        
        return _description
    }
    
    var pokemonid:Int {
      
        return _pokemonid
    }
    
    
    init(name:String , pokemonid:Int) {
        self._name = name
        self._pokemonid = pokemonid
        _pokemonurl = "\(URL_base)\(URL_Pokemon)\(self.pokemonid)"
    }
    
   // func downloaddetailsfromapi(completed : Downloadcomplete).
    func downloaddetailsfromapi(completed : @escaping Downloadcomplete){
        Alamofire.request(_pokemonurl).responseJSON {
            response in
           // print("hey im in")
        //    print(response)
       
            
            if let dict = response.result.value as? Dictionary<String , AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as?  Int{
                    self._defense = "\(defense)"
                }
                if let types  = dict["types"] as? [Dictionary<String,String>] , types.count > 0{
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                        
                        
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                        
                        
                    else {
                        self._type = ""
                    }
                    if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                        if let url = descArr[0]["resource_uri"]
                        
                        
                        {
                            
                            let Completeurl = "\(URL_base)\(url)"
                            Alamofire.request(Completeurl).responseJSON {response in
                                if let descriptiondict = response.result.value as? Dictionary<String ,AnyObject> {
                                    if let description = descriptiondict["description"] as? String {
                                        
                                        let newdescription = description.replacingOccurrences(of: "POKMON", with: "POKEMON")
                                        print("new description is \(newdescription) ")
                                        
                                        self._description = newdescription
                                        print(self._description)
                                    }
                                    else {
                                        self._description = "Sorry no description found for this pokemon"
                                    }
                                    
                                    if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] , evolutions.count > 0 {
                                        if let nextevo = evolutions[0]["to"] as? String {
                                            if nextevo.range(of: "mega") == nil {
                                                self._nextevolutionName = nextevo
                                                
                                                if let uri = evolutions[0]["resource_uri"] as? String {
                                                    let newstr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                                    let nextevoid = newstr.replacingOccurrences(of: "/", with: "")
                                                    print("Hey nextev id is\(nextevoid)")
                                                    self._nextevolutionid = nextevoid
                                                    if let lvlExist = evolutions[0]["level"] {
                                                        if let lvl = lvlExist as? Int {
                                                            self._nextevolutionLVL = "\(lvl)"
                                                        }
                                                        else {
                                                            self._nextevolutionLVL = ""
                                                        }
                                                        }
                                                    }
                                                }
                                                
                                            }
                                        
                                        }
                                    print(self.nextevolutionName)
                                    print(self.nextevolutionid)
                                    print(self.nextevolutionLVL)
                                }
                                completed()    
                                }
                            
                                
                            }
                       
                        }
                   
                    }
         
                }
            completed()
             //   print(self.type)
         
//                
//                print("hi")
//                print(dict)
//            print(self._weight)
//                print(self._height)
//                print(self._attack)
//                print(self._defense)
//            }
    }
}
}

