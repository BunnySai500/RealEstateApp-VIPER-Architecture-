//
//  ConformationBuilder.swift
//  RealEstateApp
//
//  Created by Bunny Bhargav on 20/11/20.
//  Copyright © 2020 Bunny Bhargav. All rights reserved.
//

import Foundation
import UIKit


class ConformationBuilder {
   static func makeVc() -> UIViewController
   {
    let vi = ConformationView()
    let ro = ConformationRouter()
    ro.view = vi
    let presenter = ConformationPresenter()
    presenter.router = ro
    vi.presenter = presenter
    return vi
    }
}
