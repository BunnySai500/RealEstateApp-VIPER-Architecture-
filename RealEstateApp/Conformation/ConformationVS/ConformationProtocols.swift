//
//  ConformationProtocols.swift
//  RealEstateApp
//
//  Created by Bunny Bhargav on 20/11/20.
//  Copyright © 2020 Bunny Bhargav. All rights reserved.
//

import Foundation
import UIKit



protocol ConformationPresentation {
    var router: ConformationWireFrame? {get}
    func returnBookingDetailsString() -> String
    func naviGate()
}

protocol ConformationWireFrame {
    var view: UIViewController? {get}
    func showRegistrationFinished()
}

