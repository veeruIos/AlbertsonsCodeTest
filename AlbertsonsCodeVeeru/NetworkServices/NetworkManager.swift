//
//  NetworkManager.swift
//  AlbertsonsCodeVeeru
//
//  Created by Suthari, Veerabrahmam on 1/20/23.
//

import Foundation
import UIKit

class NetworkManager {
    typealias CompletionHandler = (_ fact: String)-> Void
    
    private static let imageUrl = "https://placekitten.com/"
    private static let factUrl = "https://meowfacts.herokuapp.com/"
    private static var imageWidth = UIScreen.main.bounds.width
    private static var imageHeight = UIScreen.main.bounds.height
    private static var randomNumber = Int.random(in: Int(imageWidth)..<900)
    private static var session: URLSession = URLSession.shared
    
#if DEBUG
    public func config(session: URLSession) {
        NetworkManager.session = session
    }
#endif
    
    public static func randomImageUrl()-> String {
        NetworkManager.randomNumber += 1
        return imageUrl + String(randomNumber) + "/" + String(Int(imageHeight))
    }
    
    public static func resetRandomNumber(isPortrait : Bool) {
        
        NetworkManager.imageWidth = isPortrait ? UIScreen.main.bounds.width : UIScreen.main.bounds.width * 0.5
        NetworkManager.imageHeight = isPortrait ? UIScreen.main.bounds.height * 0.5 : UIScreen.main.bounds.height
        NetworkManager.randomNumber = Int.random(in: Int(imageWidth)..<900)
    }
    
    public static func getRandomFact(completion: @escaping CompletionHandler) {
        
        guard let url = URL(string: factUrl) else { return }
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else {
                completion("")
                return
            }
            do {
                let catfacts = try JSONDecoder().decode(CatFact.self, from: data)
                completion(catfacts.data.first ?? "")
            } catch {
                completion("")
            }
        }.resume()
    }
}

