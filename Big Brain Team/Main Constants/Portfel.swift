//
//  Portfel.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 10.10.2021.
//

class Portfel {
    
    var difersification: PortfelDiversification
    var risk: PortfelRisk
    
    
    init(divers: PortfelDiversification, risk: PortfelRisk) {
        self.difersification = divers
        self.risk = risk
    }
}
