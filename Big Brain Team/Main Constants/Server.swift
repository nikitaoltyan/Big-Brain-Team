//
//  Server.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 10.10.2021.
//

import UIKit

class Server {
    
    func fetchData(forRisk risk: PortfelRisk, andDiv div: PortfelDiversification, completion: @escaping ([String:Any]?, Error?) -> Void) {
        let normalURL = URL(string: "httsp://bbt-vtb.herokuapp.com/")!
        let riskURL = URL(string: "https://bbt-vtb.herokuapp.com/?case=risk")!
        let divURL = URL(string: "https://bbt-vtb.herokuapp.com/?case=div")!
        
        if risk == .risk {
            let task = URLSession.shared.dataTask(with: riskURL) { (data, response, error) in
                guard let data = data else { return }
                do {
                    if let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
                        completion(array, nil)
                    }
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
            task.resume()
        }
        
        else if div == .notDiversified {
            let task = URLSession.shared.dataTask(with: divURL) { (data, response, error) in
                guard let data = data else { return }
                do {
                    if let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
                        completion(array, nil)
                    }
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
            task.resume()
        }
        
        else {
            let task = URLSession.shared.dataTask(with: normalURL) { (data, response, error) in
                guard let data = data else { return }
                do {
                    if let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
                        completion(array, nil)
                    }
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
            task.resume()
        }
    }
    
}
