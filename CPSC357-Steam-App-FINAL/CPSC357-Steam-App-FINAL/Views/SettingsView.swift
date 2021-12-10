//
//  SettingsView.swift
//  CPSC357-Steam-App-FINAL
//
//  Created by Kelsey Holland on 4/29/21.
//

import UIKit



//View that allows for options such as Adding a Game
 class SettingsView: UIViewController {

    @IBOutlet weak var settingsViewController: UIView!
    
    @IBOutlet weak var settingsStackViewController: UIStackView!
    
    
    
    var gamesLibrary = GameLibrary(gamesLibrary: [])
    var gamesArray : [Game]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}




