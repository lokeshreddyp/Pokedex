//
//  Pokecell.swift
//  Poxedex
//
//  Created by lokeshreddy on 1/20/17.
//  Copyright © 2017 lokeshreddy. All rights reserved.
//

import UIKit

class Pokecell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg : UIImageView!
    
    @IBOutlet weak var PokeLBL: UILabel!
    
    
    var pokemon : Pokemon!
    
    //to give rounded corner to cell
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon : Pokemon) {
        self.pokemon = pokemon
            PokeLBL.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokemonid)")
        
    }
}
