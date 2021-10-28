//
//  DummyPokemonController.swift
//  Phincon
//
//  Created by Sayyid Maulana Khakul Yakin on 28/10/21.
//

import UIKit

class DummyPokemonController: UITableViewController {

    var pokemonData = [Response]()
    
    var spinner = UIActivityIndicatorView(style: .large)
    
    let cellProduct = UINib(nibName: "DummyPokemonCell", bundle: nil)
    let cellProductInit = "MainPokemonCellInit"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkPokemon()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellProduct, forCellReuseIdentifier: cellProductInit)
        tableView.reloadData()
        navigationItem.title = "My Poke"
        // Do any additional setup after loading the view.
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
                    self.tableView.reloadData()

                    self.spinner.isHidden = true
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellProductInit, for: indexPath) as? DummyPokemonCell else { return UITableViewCell() }
        cell.setData(data: pokemonData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
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
