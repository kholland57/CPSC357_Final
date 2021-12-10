//
//  GameInfoView.swift
//  CPSC357-Steam-App-FINAL
//
//  Created by Kelsey Holland on 4/29/21.
//

import Foundation
import UIKit
import Charts




//View of Line Chart for details game playtime
class GameInfoView : UIViewController, ChartViewDelegate {
    @IBOutlet var GameViewController: UIView!
    @IBOutlet weak var GameStackView: UIStackView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var placeholderView01: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lineChart: LineChartView!
    
    
    
    var gameDetail : Game!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGameInfo()
        lineChart.delegate = self
        linechartView()
    }
    
    
    func setUpGameInfo()
    {
        gameTitleLabel.text = gameDetail.gameName
        
    }
    
    //Creates a Linechart using monthly playtime statistics
    func linechartView() {
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        var ourEntries = [ChartDataEntry]()
        
        let tempMonthlyPlaytime = [Int] (gameDetail.monthPlaytime())
        
        //for each week add the time played to the linechart data entries
        for x in tempMonthlyPlaytime.indices {
            ourEntries.append(ChartDataEntry(x: Double(x), y: Double(tempMonthlyPlaytime[x])))
            print(x)
        }
        
        let ourDataSet = LineChartDataSet(entries: ourEntries)
        ourDataSet.colors = ChartColorTemplates.joyful()
        
        let data = LineChartData(dataSet: ourDataSet)
        lineChart.data = data
    }
}
