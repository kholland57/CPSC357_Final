//
//  AddGameView.swift
//  CPSC357-Steam-App-FINAL
//
//  Created by Kelsey Holland on 5/20/21.
//

import Foundation
import UIKit


//View to add a game to the library
class AddGameView: UIViewController{
    
    //Main Game Structures
    var gamesArrayLibrary = GameLibrary(gamesLibrary: [])
    var gamesArray : [Game] = []
    

    @IBOutlet weak var userTextFeild: UITextField!
    @IBOutlet weak var userIntFeild: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGamesData()
    }
    
    //Adds new Game to gamesArrayLibrary and updates StorageHandler
    func addGame(name: String, total: Int){
        var tempGame: Game = Game(gameName: name, total_playtime: total, last_month_playtime: 0, last_week_playtime: 0, date_last_played: Date(), date_added: Date())
        gamesArray.append(tempGame)
        gamesArrayLibrary.updateStorage(inputArray: gamesArray)
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        if (userTextFeild.hasText == true) && (userIntFeild.hasText == true)
        {
            var tempString : String = userTextFeild.text! ?? "UntitledGame"
            var tempInt : Int = Int(userIntFeild.text!) ?? 0
            addGame(name: tempString, total: tempInt)
        }
        
    }
    
    
    //Loads data from Storage handler
    func createGamesData()
    {
        gamesArray = gamesArrayLibrary.getStorage()
    }
}
