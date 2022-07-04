//
//  GameDetailVC.swift
//  gamePractice
//
//  Created by Anshul Bikram Rana on 11/05/2022.
//

import UIKit

class GameDetailVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var platformLabel: UILabel!
    
    var game : Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let game = game{
            self.nameLabel.text = game.name
            self.scoreLabel.text = "\(game.score)"
            self.platformLabel.text = game.platform
            DispatchQueue.main.async {
                self.image.image = self.getGameImage(game: game)

                }
            }
    }
    
    func getGameImage(game: Game) -> UIImage{
        let data = try? Data.init(contentsOf: URL(string: game.smallImageURL)!)
        guard let data = data else{
            return UIImage()
        }
        return UIImage(data: data)!
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
