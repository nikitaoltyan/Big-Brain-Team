//
//  Share.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 10.10.2021.
//



class Share {
    
    var name: String?
    var risk: ShareRisk
    
    
    init(name:  String, risk: ShareRisk) {
        self.name = name
        self.risk = risk
    }
}
