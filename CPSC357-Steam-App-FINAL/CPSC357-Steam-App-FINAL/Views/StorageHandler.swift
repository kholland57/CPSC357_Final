//
//  StorageHandler.swift
//  CPSC357-Steam-App-FINAL
//
//  Created by cpsc on 5/14/21.
//

import Foundation


//Handles stored Game Data on startup of app
struct StorageHandler{
    var defaultStorage: UserDefaults = UserDefaults.standard
    var defaultKey = "GameStorage"


    //Updates the Default Storage with a passed in Dictionary
    mutating func setStorage(input: [Game]){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(input){
            defaultStorage.set(encoded, forKey: defaultKey)
        }
    }
    
    //Accesses the stored dictionary
    mutating func getStorage() -> [Game] {
        if let savedGame = defaultStorage.object(forKey: defaultKey) as? Data{
            let decoder = JSONDecoder()
            let loadedGames = (try? decoder.decode([Game].self, from: savedGame))!
            return loadedGames
        }else{
            return []
        }
    }
}
