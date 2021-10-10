//
//  Defaults.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 10.10.2021.
//

import Foundation


class Defaults {
    
    let userDefault = UserDefaults.standard
    
    func setStartBalance(_ balance: Int) {
        userDefault.set(balance, forKey: "balance")
        userDefault.set(balance, forKey: "start_balance")
    }
    
    func getBalance() -> Int {
        return userDefault.integer(forKey: "balance")
    }
    
    func getStartBalance() -> Int {
        return userDefault.integer(forKey: "start_balance")
    }
    
    func changeBalance(_ newBalance: Int) {
        userDefault.set(newBalance, forKey: "balance")
    }
    
    func setWinningTarget(_ target: Double) {
        userDefault.set(target, forKey: "win_target")
    }
    
    func getWinningTarget() -> Double {
        return userDefault.double(forKey: "win_target")
    }
    
    func setExpirience(_ exp: Int) {
        userDefault.set(exp, forKey: "exp")
    }
    
    func getExpirience() -> Int {
        return userDefault.integer(forKey: "exp")
    }
    
    func setPlayedGames(_ games: Int) {
        userDefault.set(games, forKey: "games_played")
    }
    
    func getPlayedGames() -> Int {
        return userDefault.integer(forKey: "games_played")
    }
 }
