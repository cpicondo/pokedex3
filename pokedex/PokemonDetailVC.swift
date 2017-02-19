//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by christian Picondo on 19/02/2017.
//  Copyright © 2017 cpicondo. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        
    }


    



}
