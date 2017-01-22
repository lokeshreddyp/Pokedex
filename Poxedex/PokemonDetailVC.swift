//
//  PokemonDetailVC.swift
//  Poxedex
//
//  Created by lokeshreddy on 1/20/17.
//  Copyright © 2017 lokeshreddy. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokevc :PokeVC!
    var pokemon_detailVC : Pokemon!
    
    @IBOutlet weak var nameLBL: UILabel!
    
    
    @IBOutlet weak var mainIMG: UIImageView!
    
    @IBOutlet weak var descriptionLBL: UILabel!
    
    @IBOutlet weak var TypeLBL: UILabel!
    
    @IBOutlet weak var DefenseLBL: UILabel!
    
    @IBOutlet weak var HeightLBL: UILabel!
    
    @IBOutlet weak var weightLBL: UILabel!
    
    @IBOutlet weak var BaseAttackLBL: UILabel!
    
    @IBOutlet weak var NextEvplution: UILabel!
    
    @IBOutlet weak var PokedexIdLBL: UILabel!
    
    
    @IBOutlet weak var CurrentEvolutionIMG: UIImageView!
    
    @IBOutlet weak var NextEvolutionIMG: UIImageView!
    
    //var pokemodel : Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLBL.text = pokemon_detailVC.name
        let img = UIImage(named: "\(pokemon_detailVC.pokemonid)")
        
        mainIMG.image = img
        CurrentEvolutionIMG.image = img
        pokemon_detailVC.downloaddetailsfromapi {
            //when network call is completed this will be called
            self.updateUI()
        }
//        nameLBL.text = pokemon_detailVC.name
//        let img = UIImage(named: "\(pokemon_detailVC.pokemonid)")
//        
//        mainIMG.image = img
//        CurrentEvolutionIMG.image = img
//        pokemon_detailVC.downloaddetailsfromapi {
////when network call is completed this will be called
//            self.updateUI()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    func updateUI() {
        DefenseLBL.text = pokemon_detailVC.defense
     HeightLBL.text = pokemon_detailVC.height
       BaseAttackLBL.text = pokemon_detailVC.attack
        weightLBL.text = pokemon_detailVC.weight
    TypeLBL.text = pokemon_detailVC.type
        descriptionLBL.text = pokemon_detailVC.descrip
        PokedexIdLBL.text = "\(pokemon_detailVC.pokemonid)"
        if pokemon_detailVC.nextevolutionid == "" {
            NextEvplution.text = "No Evolution"
            NextEvolutionIMG.isHidden = true
        }
        else {
            NextEvolutionIMG.isHidden = false
            NextEvolutionIMG.image = UIImage(named: pokemon_detailVC.nextevolutionid)
            
            let str = "Next Evolution: \(pokemon_detailVC.nextevolutionName!) -LVL \(pokemon_detailVC.nextevolutionLVL!)"
            NextEvplution.text = str
        }
    }
    
    
    @IBAction func backbuttonpressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    

}
