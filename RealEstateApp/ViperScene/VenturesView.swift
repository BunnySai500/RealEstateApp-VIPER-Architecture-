 

import UIKit

class RealEstateBuyingOptionsScreen: UITableViewController {
    var presenter: VenturesPresentation!
    override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    setupTableView()
    guard let pres = presenter else {return}
    pres.viewDidLoad()
    self.title = pres.title
    }

   private func setNavigation()
   {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
   }
   @objc private func doneTapped()
   {
   guard let pres = presenter else {return}
   pres.finishSelecting()
   }
   private func setupTableView()
   {
    tableView.register(UINib(nibName: "VentureOptionCell", bundle: nil), forCellReuseIdentifier: VentureOptionCell.reuseId)
    tableView.separatorStyle = .none
   }
}
extension RealEstateBuyingOptionsScreen: VenturesView
{
    func reloadData() {
    tableView.reloadData()
    }
    func updateCells(atIndexpaths indexPaths: [IndexPath], withAnimationType type: VenturesPresenter.AnimationType) {
        let anim = UITableView.RowAnimation.none
        tableView.beginUpdates()
        switch type {
        case .insert:
        tableView.insertRows(at: indexPaths, with: anim)
        case .delete:
        tableView.deleteRows(at: indexPaths, with: anim)
        }
        tableView.endUpdates()
    }
}
extension RealEstateBuyingOptionsScreen
{
    override func numberOfSections(in tableView: UITableView) -> Int {
    return presenter.sectionCount
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = VentureOptionHeader()
    view.tag = section
    let tap = UITapGestureRecognizer(target: self, action: #selector(animateCells(_:)))
    view.addGestureRecognizer(tap)
    presenter.configure(modelforSection: section, toHeader: view)
    return view
    }
    @objc func animateCells(_ sender: UITapGestureRecognizer)
    {
    guard let vie = sender.view else {return}
    presenter.didSelectHeader(vie.tag)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.cellCount(forSection: section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: VentureOptionCell.reuseId, for: indexPath) as? VentureOptionCell else{return UITableViewCell()}
    presenter.configure(modelforIndexpath: indexPath, toCell: cell)
    return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didselectCell(ofIndexPath: indexPath)
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
