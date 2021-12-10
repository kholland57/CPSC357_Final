//
//  LibraryViewController.swift
//  CPSC357-Steam-App-FINAL
//
//  Created by Kelsey Holland on 4/29/21.
//

import Foundation
import UIKit



//View for the library of games
class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   

    
    @IBOutlet var LibraryViewController: UIView!
    
    @IBOutlet weak var LibraryLabel: UILabel!
    @IBOutlet weak var LibraryVerticalStackController: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    
    //Game array set to the pre-loaded array in the ViewController
    var gamesArrayLibrary: [Game] {
        get {
            return (self.tabBarController!.viewControllers![0] as! ViewController).gamesArray
        }
        set {
            (self.tabBarController!.viewControllers![0] as! ViewController).gamesArray = gamesArrayLibrary
        }
    }
    

    var tableRowTitle: [String] = []
    var filteredLibrary : [Game] = []
    var filteredTitles: [String] = []
    let rowCellReuseID = "cell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initalize data
        setUpRows()
        filteredTitles = tableRowTitle
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    //Search Bar to filter game library
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTitles = []
        if searchText == ""
        {
            filteredTitles = tableRowTitle
        }
        else {
            for item in tableRowTitle {
                if item.lowercased().contains(searchText.lowercased())
                {
                    filteredTitles.append(item)
                }
            }
        }
        self.tableView.reloadData()
    }
    
   // reference:   https://www.youtube.com/watch?v=iH67DkBx9Jc&ab_channel=AjayGandechaAjayGandecha
    
    
//    //reference : https://www.youtube.com/watch?v=DAHG0orOxKo&ab_channel=CodeWithCal
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return self.filteredTitles.count
    }

    
    //cell for each row, customizations for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        let cell:CustomLibraryCell = self.tableView.dequeueReusableCell(withIdentifier: rowCellReuseID) as! CustomLibraryCell

        var imageName = self.filteredTitles[indexPath.row].lowercased()
        imageName.append(".jpg")
        if let newImage = UIImage(named : imageName){
            cell.customLibraryImage.image = newImage
        }
        else {
            cell.customLibraryImage.image = UIImage(named : "steam.jpg")
        }
        
        cell.customLibraryCellLabel.text = self.filteredTitles[indexPath.row]
        
       
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("selected row : \(indexPath.row)")
    }
    
    //creates rows for each game in gamesArrayLibrary
    func setUpRows(){
        for (index, element) in gamesArrayLibrary.enumerated()
        {
            let tempGame : Game = element
            let tempTitle : String = tempGame.gameName
            tableRowTitle.append(tempTitle)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
 
        
        if segue.identifier == "ShowGameLibraryInfo"{
            let indexPath = self.tableView.indexPathForSelectedRow
            let tempGame = gamesArrayLibrary[indexPath!.row]
            let destination = segue.destination as! GameInfoView
            destination.gameDetail = tempGame
        }
        
      
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        
        
    }
}
