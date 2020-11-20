 

import Foundation
import RealmSwift


 //MARK:  DidSelect Cell Handling
/*
 Realm Model classes with object conformation
 variables should be dynamic and objc
 */



@objcMembers
class VentureOption: Object, Decodable, VenturOptionPresentable  {
   dynamic var id: String? = ""
   dynamic var icon: String? = ""
   dynamic var name: String? = ""
    override init() {
        super.init()
    }
    
}


@objcMembers
class Venture: Object, Decodable {
   dynamic var id: String? = ""
   dynamic var name: String? = ""
   dynamic var selectedVenture: VentureOption? = VentureOption()
   dynamic var options: List<VentureOption> = List()
   override static func primaryKey() -> String?
   {
    return "id"
   }
    override init() {
        super.init()
    }

    private enum CodingKeys: String, CodingKey {
        case name, options, selectedVenture
        case id = "facility_id"
    }
}

@objcMembers
class RealEstateData: Object, Decodable, RealEstatePartuculars {
    dynamic var ventures: List<Venture> = List()
    dynamic var exclusions: List<DoubleExclusions> = List()
    private enum VentureCodingKeys: String, CodingKey {
        case ventures = "facilities"
        case exclusions
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: VentureCodingKeys.self)
        let ventures = try container.decode([Venture].self, forKey: .ventures)
        let exclusions = try container.decode([[Exclusion]].self, forKey: .exclusions)
        self.ventures.append(objectsIn: ventures)
        for ex in exclusions
        {
        let tempExli = List<Exclusion>()
        for exi in ex
        {
        tempExli.append(exi)
        }
        self.exclusions.append(DoubleExclusions(tempExli))
        }
        super.init()
     }
    override init() {
        super.init()
    }
}

@objcMembers
class Exclusion: Object, Decodable {
  dynamic var fId: String? = ""
  dynamic var oId: String? = ""
   convenience init(_ fid: String, _ oid: String) {
    self.init()
    self.fId = fid
    self.oId = oid
    }
   private enum CodingKeys: String, CodingKey {
        case fId = "facility_id"
        case oId = "options_id"
    }
    required override init()
    {
    super.init()
    }
   static func == (lhs: Exclusion, rhs: Exclusion) -> Bool {
       lhs.fId == rhs.fId && lhs.oId == rhs.oId
   }
}

@objcMembers
class DoubleExclusions: Object {
    dynamic var exclusionSet = List<Exclusion>()
    convenience init(_ exc: List<Exclusion>)
    {
    self.init()
    self.exclusionSet = exc
    }
}



class VenturHeaderViewModel {
    var optionName: String?
    var name: String?
    init(_ op_name: String, _ nm: String) {
        optionName = op_name
        name = nm
    }
}

 
 
 
 
