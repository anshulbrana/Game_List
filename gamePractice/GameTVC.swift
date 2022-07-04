//
//  GameTVC.swift
//  gamePractice
//
//  Created by Anshul Bikram Rana on 11/05/2022.
//

import UIKit

class GameTVC: UITableViewController {
    
    var games = [Game]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getGames()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.games.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gCell", for: indexPath)

        cell.textLabel?.text = self.games[indexPath.row].name
        
        DispatchQueue.main.async {
            let data = try? Data.init(contentsOf: URL(string: self.games[indexPath.row].smallImageURL)!)
            guard let data = data else { return }
            cell.imageView?.image = UIImage(data: data)
//
//            cell.imageView?.image = self.getGameImage(game: self.games[indexPath.row])
        }
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender:nil)
    }
    
    
    func getGameImage(game: Game) -> UIImage{
        let data = try? Data.init(contentsOf: URL(string: game.smallImageURL)!)
        guard let data = data else{
            return UIImage()
        }
        return UIImage(data: data)!
    }
    
    func download(at url: String, handler: @escaping (Data?) -> Void){
                    
        guard let url = URL(string: url) else{
            return
        }
               
        var request = URLRequest (url: url)
        request.httpMethod="GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            handler(data)
        }
               
        task.resume()
        
    }
    
    func getGames(){
        self.download(at: "https://education.3ie.fr/ios/StarterKit/GameCritic/GameCritics.json"){
            data in
            if let data = data {
                do{
                    self.games = try JSONDecoder().decode([Game].self, from: data)

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
           catch{
                print("Parsing data failed")
            }
            }else{
                print("Data loading failed")
            }
    }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let index = tableView.indexPathForSelectedRow
            let destinationVC = segue.destination as! GameDetailVC
            destinationVC.game = games[index!.row]
        }
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
