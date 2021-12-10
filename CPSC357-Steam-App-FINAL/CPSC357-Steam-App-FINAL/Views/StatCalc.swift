//
//  StatCalc.swift
//  CPSC357-Steam-App-FINAL
//
//  Created by cpsc on 5/13/21.
//

import Foundation


//Game Object Structure
struct Game : Codable{
    var gameName: String //name of the game
    var total_playtime: Int //how many hours were played by user in total
    var last_month_playtime: Int //how many hours were played by user within the last month
    var last_week_playtime: Int
    var date_last_played: Date //date the game was last played by user
    var date_added: Date //intial date when user added/purchased game to their library
    
    func calcDownTime() -> Int{ //calculates how long it has been since game was played
        let diffComponents = Calendar.current.dateComponents([.hour], from: date_last_played, to: Date())
        guard let hours = diffComponents.hour else { return 0 }
        return (hours)
    }
    
    func calcTimeAdded() -> Int{ //calculates how long the game has been owned by user
        let diffComponents = Calendar.current.dateComponents([.hour], from: date_added, to: Date())
        guard let hours = diffComponents.hour else { return 0 }
        return (hours)
    }
    
    func monthPlaytime() -> [Int]{ //Returns an array with the amount of months since date_added
        let components = Calendar.current.dateComponents([.month], from: date_added, to: Date())
        var monthlyHours = Array<Int>(repeating: 0, count: components.month!)
        for month in monthlyHours.indices {
            monthlyHours[month] = Int.random(in:1..<100)
        }
        return monthlyHours
    }
}


//Structure that acts as collection of Games
struct GameLibrary {
    //Intialize the Game array and storagehandler variable
    var gamesLibrary : [Game]
    var gamesStorage  = StorageHandler()
    
    
    //Default games for the app's first launch
    mutating func addTempGames(){
        //Date Formatting for ease of date creation
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH"
        
        
        let date1 = formatter.date(from: "2020/10/08 15")
        let date2 = formatter.date(from: "2016/11/09 12")
        let date3 = formatter.date(from: "2021/12/08 11")
        let date4 = formatter.date(from: "2017/03/09 3")
        let date5 = formatter.date(from: "2020/01/08 11")
        let date6 = formatter.date(from: "2019/03/10 3")
        let date7 = formatter.date(from: "2020/02/03 8")
        let date8 = formatter.date(from: "2019/03/21 3")
        let date9 = formatter.date(from: "2015/02/03 3")
        let date10 = formatter.date(from: "2015/03/21 3")
        let date11 = formatter.date(from: "2018/07/03 3")
        let date12 = formatter.date(from: "2020/04/21 3")
        
        
        //Sample Game Objects
        let Oblivion = Game(gameName: "Oblivion", total_playtime: 100, last_month_playtime: 3, last_week_playtime: 2, date_last_played: date1!, date_added: date2!)
       
        let Morrowind = Game(gameName: "Morrowind", total_playtime: 13, last_month_playtime: 4, last_week_playtime: 3, date_last_played: date3!, date_added: date4!)
       
        let Portal = Game(gameName: "Portal", total_playtime: 12, last_month_playtime: 5, last_week_playtime: 3, date_last_played: date5!, date_added: date6!)
        
        let MassEffect = Game(gameName: "MassEffect", total_playtime: 15, last_month_playtime: 5, last_week_playtime: 3, date_last_played: date7!, date_added: date8!)
        
        let Portal2 = Game(gameName: "Portal2", total_playtime: 10, last_month_playtime: 2, last_week_playtime: 1, date_last_played: date9!, date_added: date10!)
     
        let ElderScrollsOnline = Game(gameName: "ElderScrollsOnline", total_playtime: 50, last_month_playtime: 13, last_week_playtime: 4, date_last_played: date11!, date_added: date12!)
        
        gamesLibrary.append(Oblivion)
        gamesLibrary.append(Morrowind)
        gamesLibrary.append(Portal)
        gamesLibrary.append(MassEffect)
        gamesLibrary.append(Portal2)
        gamesLibrary.append(ElderScrollsOnline)
        
        //updates the StorageHandler with default games
        gamesStorage.setStorage(input : gamesLibrary)
    }
    
    //Updates Storage Handler with gamesLibrary
    mutating func updateStorage(inputArray : [Game])
    {
        self.gamesLibrary = inputArray
        var tempArray : [Game] = []
        for (index, element) in self.gamesLibrary.enumerated(){
            var tempGame : Game  = element
            tempArray.append(tempGame)
        }
        gamesStorage.setStorage(input : tempArray)
    }
    
    //Returns the stored Games array
    mutating func getStorage() -> [Game]
    {
        gamesLibrary = []
        gamesLibrary = gamesStorage.getStorage()
        return gamesLibrary
    }
}
