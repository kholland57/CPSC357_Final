//
//  ViewController.swift
//  CPSC357-Steam-App-FINAL
//
//  Created by Kelsey Holland on 4/26/21.
//

import UIKit
import Foundation
import Charts



//View Controller Will be Main menu/ home menu 



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  ChartViewDelegate{

   

    @IBOutlet var mainMenuViewController: UIView!
    @IBOutlet weak var MainMenuStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieChart: PieChartView!
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        super.viewDidLoad()
        createGamesData()
        
    }

    //Main Data Structures to hold the Game Objects
    var gamesLibrary = GameLibrary(gamesLibrary: [])
    var gamesArray : [Game] = []
    
    var filteredGamesArray : [Game] = []

    var tableRowTitle: [String] = []

    let collectionViewTitle : [String] = ["Playtime this week", "Total Playtime"]
    let rowCellReuseID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initializes all data in ViewController
        tableView.reloadData()
        createGamesData()
        gamesLibrary.updateStorage(inputArray: gamesArray)
        gamesArray = gamesLibrary.gamesLibrary
        setUpRows()

        
        tableView.delegate = self
        tableView.dataSource = self
       
        pieChart.delegate = self
        piechartView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return self.tableRowTitle.count

    }
    
    //cell for each row, customizations for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        let cell:CustomCell = self.tableView.dequeueReusableCell(withIdentifier: rowCellReuseID) as! CustomCell
        var imageName = self.tableRowTitle[indexPath.row].lowercased()
        imageName.append(".jpg")
        if let newImage = UIImage(named : imageName){
            cell.customImage.image = newImage
        }
        else {
            cell.customImage.image = UIImage(named : "steam.jpg")
        }
        
        cell.customCellLabel.text = self.tableRowTitle[indexPath.row]
        
        return cell
    }
    
    //action when button is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("selected row : \(indexPath.row)")
    }
    
    
    
    //ref : https://stackoverflow.com/questions/47572487/pass-array-from-tableview-to-tableview?noredirect=1&lq=1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowGameInfo"{
            let indexPath = self.tableView.indexPathForSelectedRow
            let tempGame = gamesArray[indexPath!.row]
            let destination = segue.destination as! GameInfoView
            destination.gameDetail = tempGame
        }
        
        if segue.identifier == "Settings"{
            gamesLibrary.updateStorage(inputArray: gamesArray)
            let destination = segue.destination as! SettingsView
            destination.gamesArray = gamesArray
            destination.gamesLibrary = gamesLibrary
        }
    }
    
    
    
    //loads game data from Storage Handler
    func createGamesData()
    {
        gamesArray = gamesLibrary.getStorage()
        //gamesArray = []
        if (gamesArray.isEmpty == true) {
            gamesLibrary.addTempGames()
            gamesArray = gamesLibrary.getStorage()
        }
        
    }
    func setUpRows(){
        var count : Int = 0
        gamesArray =  gamesArray.sorted(by: {$0.last_month_playtime < $1.last_month_playtime})
        for (index, element) in gamesArray.enumerated()
        {
            let tempGame : Game = element
            if count < 2 {
                let tempTitle : String = tempGame.gameName
                tableRowTitle.append(tempTitle)
                count += 1
            }
        }

        
    }
    func piechartView() {
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)

        var entrySlices = [PieChartDataEntry]()
        
        //array of the games and access their total time played
        for x in gamesArray.indices {
            entrySlices.append(PieChartDataEntry(value: Double(gamesArray[x].total_playtime), label: gamesArray[x].gameName))
        }

        let dataSet = PieChartDataSet(entries: entrySlices)
        dataSet.colors = ChartColorTemplates.joyful() //color theme
        
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        
        data.setValueFont(.systemFont(ofSize: 15, weight: .heavy))
        data.setValueTextColor(.white)
        
        pieChart.data = data
        pieChart.highlightValues(nil)
        
    }
}


//Sources :
//https://stackoverflow.com/questions/33234180/uitableview-example-for-swift
//https://stackoverflow.com/questions/31735228/how-to-make-a-simple-collection-view-with-swift
