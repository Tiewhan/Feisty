//
//  APIManager.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

///Structure is only used to model JSON respones. Contains the a structure of Apps
private struct AppList: Codable {
    let applist: Apps
}

///Structure is used to model JSON respones. Contains the list of games
private struct Apps: Codable {
    let apps: [JsonGame]
}

///Structure is used to model JSON respones. This is the actual game
struct JsonGame: Codable {
    let appid: Int
    let name: String
}

///Handles the calling of API services and also handles the decoding thereof.
struct APIManager {

  // MARK: - Variable Declaration
  private let baseURL: String = "https://api.steampowered.com"
  private let steamAppsURL: String = "/ISteamApps"

  /**
              
   Queries the Steampowered API for a complete list of games offered by the Steam store
   
   - Parameter completionHandler: Escapling closure that is called when the service call returns
   
   - Returns: Nothing
   
   */
  func getGames(completionHandler: @escaping([Game]) -> Void) {

    let specificURL = "/GetAppList/v2"
    let fullUrl: String = baseURL + steamAppsURL + specificURL + ""
    let url: URL = URL(string: fullUrl)!

    //This task will do the actual call and take the closure that is called at the end
    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

      if error != nil {
        return
      }

      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        return
      }

      //Unbox the data and also decode the JSON response with the AppList struct
      if
        let data = data,
        let decodedGames = try? JSONDecoder().decode(AppList.self, from: data) {

          var games: [Game] = []

          decodedGames.applist.apps.forEach { (jsonGame) in
              games.append(Game(jsonGame))
          }

          completionHandler(games)

      }
    })
    task.resume()
  }
}
