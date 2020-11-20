//
//  ConformationPresenter.swift
//  RealEstateApp
//
//  Created by Bunny Bhargav on 20/11/20.
//  Copyright © 2020 Bunny Bhargav. All rights reserved.
//

import Foundation



class ConformationPresenter: ConformationPresentation {
    var router: ConformationWireFrame?
    func returnBookingDetailsString() -> String {
        guard let object = APP_DELEGATE.dataStore.object(RealEstateData.self) else{return ""}
    let vent = object.ventures.filter({ ven -> Bool in
        return ven.selectedVenture != nil
    })
    var str = ""
vent.forEach { st in
    guard let name = st.name, let selv = st.selectedVenture, let opname = selv.name else{return}
    str.append("\(name): \(opname)\n\n")
        }
    return str
    }
    
    func naviGate()
    {
    guard let ri = router else {return}
    ri.showRegistrationFinished()
    }
}
