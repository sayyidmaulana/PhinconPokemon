//
//  DummyPokemonCell.swift
//  Phincon
//
//  Created by Sayyid Maulana Khakul Yakin on 28/10/21.
//

import UIKit

class DummyPokemonCell: UITableViewCell {

    @IBOutlet weak var pokemonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: Response) {
        pokemonLabel.text = "Hello I am \(data.name ?? "" )"
    }
    
}
