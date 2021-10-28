//
//  MainPokemonController.swift
//  Phincon
//
//  Created by Sayyid Maulana Khakul Yakin on 28/10/21.
//

import UIKit

class MainPokemonController: UIViewController {

    @IBOutlet weak var list: UITableView!
    
    var pokemonData = [Response]()
    
    var spinner = UIActivityIndicatorView(style: .large)
    
    let cellProduct = UINib(nibName: "DummyPokemonCell", bundle: nil)
    let cellProductInit = "MainPokemonCellInit"
    
    lazy var titleStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Pokemon"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.tag = 0
        $0.addArrangedSubview(titleLabel)
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "List of the Pokemon"
        subtitleLabel.font = UIFont.italicSystemFont(ofSize: 10)
        subtitleLabel.tintColor = .darkGray
        subtitleLabel.tag = 1
        $0.addArrangedSubview(subtitleLabel)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = titleStackView
        // Do any additional setup after loading the view.
        checkPokemon()
        
        list.delegate = self
        list.dataSource = self
        list.register(cellProduct, forCellReuseIdentifier: cellProductInit)
        list.reloadData()
        
        let btnRight = UIBarButtonItem(title: "My Poke", style: .plain, target: self, action: #selector(self.clicked))
        navigationItem.rightBarButtonItem = btnRight
    }
    
    func checkPokemon() {
        
        self.spinner.isHidden = false
        
        let myUrl = URL(string: endPointPokemon)
        var request = URLRequest(url: myUrl!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                
                
                let JSONData = try JSONDecoder().decode(PokemonResponse.self, from: data)
                
                self.pokemonData = JSONData.results ?? []
                
                print(JSONData)
                
                DispatchQueue.main.async {
                    self.list.reloadData()

                    self.spinner.isHidden = true
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
    
    @objc func clicked() {
        let navigation = DummyPokemonController()
        navigationController?.pushViewController(navigation, animated: true)
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

extension MainPokemonController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigation = DetailPokemonController()
        navigation.name = pokemonData[indexPath.row].name ?? ""
        navigationController?.pushViewController(navigation, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellProductInit, for: indexPath) as? DummyPokemonCell else { return UITableViewCell() }
        cell.setData(data: pokemonData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
