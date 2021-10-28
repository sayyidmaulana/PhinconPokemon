//
//  DetailPokemonController.swift
//  Phincon
//
//  Created by Sayyid Maulana Khakul Yakin on 28/10/21.
//

import UIKit

class DetailPokemonController: UIViewController {

    var name = ""
    
    var pokemonDetail: DetailPokemonResponse? = nil
    
    lazy var imgMenu: UIImageView = {
        let imgViewMenu = UIImageView()
        imgViewMenu.contentMode = .scaleAspectFit
        return imgViewMenu
    }()
    let textMenu: UILabel = {
        let textViewMenu = UILabel()
        textViewMenu.textAlignment = .center
        textViewMenu.font = UIFont.systemFont(ofSize: 12)
        textViewMenu.text = ""
        textViewMenu.numberOfLines = 50
        return textViewMenu
    }()
    
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setData()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        view.addSubview(imgMenu)
        imgMenu.setAnchor(top: view.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width * 8 / 2, height: 300)
        view.addSubview(textMenu)
        textMenu.setAnchor(top: imgMenu.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 30, paddingLeft: 30, paddingBottom: 20, paddingRight: 30, width: 0, height: 0)

        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.setAnchor(top: view.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 150, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
    }
    
    private func setData() {

        self.spinner.isHidden = false
        let myUrl = URL(string: filterPokemon(idPokemon: name))
        var request = URLRequest(url: myUrl!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }

            do {
                
                
                let JSONData = try JSONDecoder().decode(DetailPokemonResponse.self, from: data)
                self.pokemonDetail = JSONData
    
                DispatchQueue.main.async {

//                    guard let thumb = self.pokemonDetail. else { return }
//                    self.imgMenu.loadImage(using: thumb)
                    self.textMenu.text = "Name:\n \(self.pokemonDetail?.name ?? "")\n\nHeight:\(self.pokemonDetail?.height ?? 0)\nWeight:\(self.pokemonDetail?.weight ?? 0)"
                    
                    self.spinner.isHidden = true
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
