//
//  ViewController.swift
//  Poxedex
//
//  Created by lokeshreddy on 1/19/17.
//  Copyright © 2017 lokeshreddy. All rights reserved.
//

import UIKit
import AVFoundation

class PokeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource ,UISearchBarDelegate{

    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemons = [Pokemon]()
    var filteredpokemon = [Pokemon]()
    var musicplayer : AVAudioPlayer! = nil
    var inSearchmode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
   collection.dataSource = self
        collection.delegate = self
        searchbar.delegate = self
        
        
        searchbar.returnKeyType = UIReturnKeyType.done
        parsepokemonCSV()
        initAudio()
    }

    //to play the audio continuosly when app is loaded
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        do {
            musicplayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicplayer.prepareToPlay()
            //to play continuously
            musicplayer.numberOfLoops = -1
            musicplayer.play()
        }
        catch let err as NSError! {
            print(err.debugDescription)
        }
    }
    
    //parsing csv file
    func parsepokemonCSV() {
     
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows  = csv.rows
          //  print(rows)
            
            for row in rows {
                let pokeid  = Int(row["id"]!)
                let pokename = row["identifier"]!
            
            let pokemon_row =  Pokemon(name: pokename, pokemonid: pokeid!)
                pokemons.append(pokemon_row)
            
            }
            
            
        }
        catch let err as NSError! {
            print(err.debugDescription)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Pokecell", for: indexPath) as? Pokecell {
            
            var pokecell : Pokemon!
            //if we are searching anything we get the pokemon
            if inSearchmode {
                pokecell = filteredpokemon[indexPath.row]
                cell.configureCell(pokecell)
            }
                //if we dont search anything we get full list of pokemon
            else {
                pokecell = pokemons[indexPath.row]
                cell.configureCell(pokecell)
            }
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        var pokemon_seguedetails : Pokemon!
        
        if inSearchmode {
            pokemon_seguedetails = filteredpokemon[indexPath.row]
            
        }
        else {
            pokemon_seguedetails = pokemons[indexPath.row]
        }
        
performSegue(withIdentifier: "PokemonDetailVC", sender: pokemon_seguedetails)
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchmode {
            return filteredpokemon.count
        }
        
        return pokemons.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func MusicBTNpressed(_ sender: UIButton) {
    
        if musicplayer.isPlaying {
            musicplayer.pause()
            sender.alpha = 0.2
        }
        else {
            musicplayer.play()
            sender.alpha  = 1.0
        }
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchbar.text == "" {
            inSearchmode = false
            collection.reloadData()
            view.endEditing(true)
        }
        else {
            inSearchmode = true
            let lower = searchBar.text!.lowercased()
            filteredpokemon = pokemons.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier ==  "PokemonDetailVC" {
            if let detailsvc = segue.destination as? PokemonDetailVC {
                if let pok = sender as? Pokemon {
                    detailsvc.pokemon_detailVC = pok
                }
            }
        }
    }
    
}

