//
//  ViewController.swift
//  TableView
//
//  Created by Robert Herley on 3/4/19.
//  Copyright © 2019 Robert Herley. All rights reserved.
//

import UIKit

struct Hero : Decodable {
    let heroName: String
    let name : String
}

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    private var heroes : [Hero]?
    
    func fetchHeros() {
        let jsonUrlString = "http://patrickhill.nyc/justiceleague.json"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if(err != nil) {
                print("An error occurred while fetching:", err ?? "unknown error")
                return
            }
            
            let status = (response as! HTTPURLResponse).statusCode
            if(!(status >= 200 && status < 300)){
                print("Invalid HTTP Response:", status)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let heroes = try JSONDecoder().decode([Hero].self, from: data)
                self.heroes = heroes;
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                print(self.heroes!)
            } catch let jsonErr {
                print("An error occurred while parsing the json:", jsonErr)
                return
            }
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        fetchHeros()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell") else { return UITableViewCell()}
        
        guard let currHero = self.heroes?[indexPath.row] else { return UITableViewCell() }
        
        cell.textLabel?.text = currHero.name
        cell.detailTextLabel?.text = currHero.heroName
        
        return cell
    }
    
}

