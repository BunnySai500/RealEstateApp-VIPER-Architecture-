//
//  ConformationView.swift
//  RealEstateApp
//
//  Created by Bunny Bhargav on 20/11/20.
//  Copyright © 2020 Bunny Bhargav. All rights reserved.
//

import Foundation
import UIKit


class ConformationView: UIViewController {
    @IBOutlet weak var detailsLbl: UILabel!
    var presenter: ConformationPresentation?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Conformation"
        detailsLbl.numberOfLines = 50
        getBookingDetails()
        setNavigation()
    }
    func getBookingDetails()
    {
        guard let pres = presenter else {
            return
        }
    detailsLbl.text = pres.returnBookingDetailsString()
    }
    func setNavigation()
    {
   let rightBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(navigate))
    //let leftBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navigate))
    navigationItem.rightBarButtonItem = rightBtn
     //   navigationItem.leftBarButtonItem = leftBtn
    }
    @objc func navigate()
    {
        guard let pres = presenter else {
            return
        }
        pres.naviGate()
    }
}

