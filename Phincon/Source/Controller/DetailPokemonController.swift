//
//  DetailPokemonController.swift
//  Phincon
//
//  Created by Sayyid Maulana Khakul Yakin on 28/10/21.
//

import UIKit
import CoreData

class DetailPokemonController: UIViewController {

    var name = ""
    
    var pokemonDetail: DetailPokemonResponse? = nil
    lazy var gamesProvider: CatchProvider = { return CatchProvider() }()
    var there = false
    
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
    
    lazy var love: UIButton = {
       let button = UIButton(type: .system)
       button.layer.shadowOpacity = 0.5
       button.layer.shadowOffset = CGSize(width: 2, height: 2)
       button.layer.shadowRadius = 5.0
       button.layer.shadowColor = UIColor.black.cgColor
       button.setImage(UIImage(named: "heart.square.fill"), for: .normal)
        button.tintColor = .red
       button.addTarget(self, action: #selector(self.catchPokemon), for: .touchUpInside)
       return button
   }()
    
    lazy var loveButton: UIButton = {
       let button = UIButton(type: .system)
       button.layer.shadowOpacity = 0.5
       button.layer.shadowOffset = CGSize(width: 2, height: 2)
       button.layer.shadowRadius = 5.0
       button.layer.shadowColor = UIColor.black.cgColor
       button.setImage(UIImage(named: "heart.square"), for: .normal)
        button.tintColor = .gray
       button.addTarget(self, action: #selector(self.catchPokemon), for: .touchUpInside)
       return button
   }()
    
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setData()
        // Do any additional setup after loading the view.
    }
    
    @objc func catchPokemon() {
        
        if self.there {
        DispatchQueue.main.async {
            self.view.addSubview(self.love)
            self.love.setAnchor(top: self.imgMenu.topAnchor, left: nil, bottom: nil, right: self.imgMenu.trailingAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 28, width: 40, height: 40)
            }
        } else {
            DispatchQueue.main.async {
            self.view.addSubview(self.loveButton)
        self.loveButton.setAnchor(top: self.imgMenu.topAnchor, left: nil, bottom: nil, right: self.imgMenu.trailingAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 28, width: 40, height: 40)
            }
        }
        
//        if self.there {
//
//            gamesProvider.deleteData(pokemonDetail?.name ?? "") {
//                DispatchQueue.main.async {
//                    self.showAlert(controller: self, message: "Data berhasil dihapus", seconds: 1)
//                    self.there = false
//                    let btnRight = UIBarButtonItem(image: UIImage(named: "heart.square"), style: .plain, target: self, action: #selector(self.catchPokemon))
//                    self.navigationItem.rightBarButtonItem = btnRight
//                    btnRight.tintColor = .gray
//                }
//            }
//            print("false clicked")
//
//        } else {
//
//            gamesProvider.createData(pokemonDetail?.name ?? "", pokemonDetail?.name ?? "") {
//                DispatchQueue.main.async {
//                    self.showAlert(controller: self, message: "Data berhasil disimpan", seconds: 1)
//                    self.there = true
//                    let btnRight = UIBarButtonItem(image: UIImage(named: "heart.square.fill"), style: .plain, target: self, action: #selector(self.catchPokemon))
//                    self.navigationItem.rightBarButtonItem = btnRight
//                    btnRight.tintColor = .red
//                }
//            }
//            print("true clicked")
//
//        }
        
    }
    
    func showAlert(controller: UIViewController, message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .darkGray
        alert.view.alpha = 0.7
        alert.view.layer.cornerRadius = 10
        
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    private func getData() {
        
        
        
    }
    
    private func setupView() {
        let btnRight = UIBarButtonItem(image: UIImage(named: "heart.square"), style: .plain, target: self, action: #selector(self.catchPokemon))
        navigationItem.rightBarButtonItem = btnRight
        
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
