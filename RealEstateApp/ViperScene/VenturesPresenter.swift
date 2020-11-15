

import Foundation



class VenturesPresenter: VenturesPresentation {
    
    enum AnimationType
    {
    case insert
    case delete
    }
    
    var view: VenturesView?
    
    var router: VenturesWireframe?
    
    var interactor: VenturesUseCase?
    
    var data : RealEstatePartuculars?
    
    var sectionCount: Int = 0
    var selectedIndexes: [Int] = []
    var title = "Ventures"
    init(_ vie: VenturesView, _ route: VenturesWireframe, _ interact: VenturesUseCase) {
        view = vie
        router = route
        interactor = interact
    }
    
    //MARK:  Loading Data In ViewDidload
    
    func viewDidLoad() {
    guard let int = interactor else{return}
        int.getVenturesData { [weak self] result in
        guard let strSelf = self else {return}
        switch result
        {
        case .success(let model):
        strSelf.data = model
        guard let data = strSelf.data else{return}
        strSelf.sectionCount = data.ventures.count
        guard let vi = strSelf.view else {return}
        DispatchQueue.main.async {
        vi.reloadData()
        }
        case .failure(let err):
        guard let ri = strSelf.router else {return}
        DispatchQueue.main.async
            {
        ri.showAlert(withMessage: "Data Fetch Failed", andSubtitle: "\(err)")
            }
        }
        }
    }
    
   //MARK:  Cell COnfiguration
    
    func configure(modelforIndexpath indexpath: IndexPath, toCell cell: ConfigurableCell) {
    guard let data = self.data else{return}
    let option = data.ventures[indexpath.section].options[indexpath.row]
    cell.configureCell(withItem: option)
    }
    
    //MARK:  Header COnfiguration
    
    func configure(modelforSection section: Int, toHeader header: ConfigurableHeader) {
    guard let data = self.data else{return}
    guard let venname = data.ventures[section].name else{return}
    var opme = ""
    if let selectV = data.ventures[section].selectedVenture, let opname = selectV.name
    {
    opme = opname
    }
    let vm = VenturHeaderViewModel(opme, venname)
    header.configureHeader(withVm: vm)
    }
    
    //MARK:  Getting noOfCells
    
    func cellCount(forSection sec: Int) -> Int
    {
    if selectedIndexes.contains(sec)
    {
    guard let data = data else {return 0}
    return data.ventures[sec].options.count
    }
    else
    {
    return 0
    }}
    
    //MARK:  DidSelect Cell Handling
    func didselectCell(ofIndexPath indexpath: IndexPath)
    {
    guard let data = self.data else{return}
    let _ = APP_DELEGATE.dataStore.update {
    data.ventures[indexpath.section].selectedVenture = data.ventures[indexpath.section].options[indexpath.row]
        }
    guard let vi = view else {return}
    vi.reloadData()
    }
    
    //MARK:  DidSelect Header Handling
    func didSelectHeader(_ tag: Int)
    {
    let section = tag
    var indexpaths = [IndexPath]()
    guard let data = self.data else{return}
    for row in data.ventures[section].options.indices
    {
    let indexpath = IndexPath(row: row, section: section)
    indexpaths.append(indexpath)
    }
    guard let vi = view else {return}
    if let index = selectedIndexes.firstIndex(of: section)
    {
    selectedIndexes.remove(at: index)
    vi.updateCells(atIndexpaths: indexpaths, withAnimationType: .delete)
    }
    else
    {
    selectedIndexes.append(section)
    vi.updateCells(atIndexpaths: indexpaths, withAnimationType: .insert)
    }
    }
    
    //MARK:  Routing Functions
    func finishSelecting()
    {
    guard let rt = router else { return }
    let message = "You have Registered"

    var subtitle = ""
    guard let dat = data else{return}
    dat.ventures.forEach {
    if let ven = $0.selectedVenture, let name = ven.name
        {
    subtitle.append("\($0.name ?? ""):\(name)")
        }
        }
    rt.showAlert(withMessage: message, andSubtitle: subtitle)
    }
    
    
     //MARK:  ImproVIng Code
    private func presentRestriction(exc: [Exclusion])
    {
    guard let data = data else{return}
    let name1 = data.ventures.first { ven -> Bool in
        return ven.id == exc[0].fId
        }?.options.first(where: {return $0.id == exc[0].oId})?.name
    let name2 = data.ventures.first { ven -> Bool in
    return ven.id == exc[1].fId
    }?.options.first(where: {return $0.id == exc[1].oId})?.name
    let message = "Property Mismatch"
    let subtitle = "Property \(name1 ?? "") and Property \(name2 ?? "") cant be selected"
    guard let ri = router else {return}
    ri.showAlert(withMessage: message, andSubtitle: subtitle)
    }
}




//MARK:- ExperimantalCode
/*
//    guard let dat = data else{return}
//    let exc = dat.ventures.compactMap { ven -> Exclusion? in
//    guard let vid = ven.id, let sel = ven.selectedVenture, let oid = sel.id else{return nil}
//    return Exclusion(vid, oid)
//        }
//    print(Array(exc))
//    print(Array(dat.exclusions))
//    print(Array(dat.exclusions[0].exclusionSet))
//    let commexc = Array(dat.exclusions).filter { Array($0.exclusionSet).allSatisfy { exl in Array(exc).contains(exl)}}
//        //exc.forEach{print($0)}
//    print("Common excs", commexc)
*/
