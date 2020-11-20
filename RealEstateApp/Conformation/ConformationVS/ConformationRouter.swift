//
//  ConformationRouter.swift
//  RealEstateApp
//
//  Created by Bunny Bhargav on 20/11/20.
//  Copyright © 2020 Bunny Bhargav. All rights reserved.
//

import Foundation
import UIKit


class ConformationRouter: ConformationWireFrame {
      var view: UIViewController?
      func showRegistrationFinished()
      {
        guard let vi = view else {
            return
        }
    HelperClass.showAlertWithOneOption(title: "Registration Successful", subTitle: "You have successfully booked the venture. Our agent will get in touch with you soon", controller: vi, onSelectButton: nil)
      }
}
