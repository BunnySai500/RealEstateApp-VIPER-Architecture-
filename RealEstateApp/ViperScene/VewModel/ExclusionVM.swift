//
//  ExclusionVM.swift
//  RealEstateApp
//
//  Created by Bunny Bhargav on 20/11/20.
//  Copyright © 2020 Bunny Bhargav. All rights reserved.
//

import Foundation
import RealmSwift


class ExclusionVM: Equatable {
    var fId: String? = ""
    var oId: String? = ""
    init(_ fid: String, _ oid: String) {
    self.fId = fid
    self.oId = oid
    }
    static func == (lhs: ExclusionVM, rhs: ExclusionVM) -> Bool {
    lhs.fId == rhs.fId && lhs.oId == rhs.oId
    }
    func exclusionItemNames() -> (String?, String?)
    {
    guard let item = APP_DELEGATE.dataStore.object(Venture.self, self.fId), let option = item.options.first(where: {return $0.id == self.oId}) else {return ("", "")}
    return (item.name, option.name)
    }
}
