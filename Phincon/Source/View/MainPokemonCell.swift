//
//  MainPokemonCell.swift
//  Phincon
//
//  Created by Sayyid Maulana Khakul Yakin on 28/10/21.
//

import UIKit

class MainPokemonCell: UICollectionViewCell {

    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var labelPokemon: UILabel!
    @IBOutlet weak var containerPokemon: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerPokemon.layer.cornerRadius = 5
        containerPokemon.layer.borderWidth = 0.3
        containerPokemon.layer.borderColor = UIColor(named: "pokeColor")?.cgColor
        
        // Initialization code
    }
    
    func setData(data: Response) {
//        guard let thumb = data.url else { return }
//        imagePokemon.loadImage(using: thumb)
        labelPokemon.text = "Hello I am \(data.name ?? "")"
    }

}
