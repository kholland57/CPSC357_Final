// NOTE: This file was meant for requesting the API JSON Data. Due to difficulties with the Steam API, we have decided to opt out of using the API. This file and its elements are not in use for this app.





//  GameRequest.swift
//  CPSC357-Steam-App-FINAL
//
//  Created by cpsc on 5/3/21.
//
/*
import Foundation


enum GameError: Error{
    case noDataAvailable
    case canNotProcessData
}

struct GameRequest{
    let resourceURL:URL
    let API_KEY = "D35534935ACE75DAF05B1EA158A0EC0A"
    
    init(steamID64:String){
        let resourceString = "https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=\(API_KEY)&steamid=\(steamID64)&format=json"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getGames (completion: @escaping(Result<[GamesLibrary], GameError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                print("decoder")
                let gamesResponse = try decoder.decode(GameResponse.self, from: jsonData)
                print(gamesResponse)
                print("gamesresponse")
                //let gamesLibrary = gamesResponse.response.
                print("gameDetails")
                //completion(.success(gamesLibrary))
            }catch{
                //print("DECODER DIDNT WORK ")
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
*/
