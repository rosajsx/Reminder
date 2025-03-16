//
//  MyReceiptsViewController.swift
//  Reminder
//
//  Created by Lucas Rosa  on 07/03/25.
//

import Foundation
import UIKit


class MyReceiptsViewController: UIViewController {
    let contentView: MyReceiptsView
    weak var flowDelegate: MyReceiptsViewFlowDelegate?
    let viewModel =  MyReceiptsViewModel()
    
    
    private var medicines: [Medicine] = []
    
    init(contentView: MyReceiptsView, flowDelegate: MyReceiptsViewFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        contentView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        setup()
        setupActions()
        setupTableView()
        
    }
    
    func setup(){
        view.addSubview(contentView)
       
        view.backgroundColor = Colors.gray800
        setupContraints()
    }
    
    func setupContraints(){
        setupContentViewToBounds(contentView: contentView, isTopSafe: false)
    }
    
    private func setupTableView(){
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(RemedyCell.self, forCellReuseIdentifier: RemedyCell.identifier)
        contentView.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }

        
    func setupActions(){
        contentView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        contentView.addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    private func loadData(){
        medicines = viewModel.fetchData()
    }
}


extension MyReceiptsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return medicines.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
}

extension MyReceiptsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RemedyCell.identifier, for: indexPath) as! RemedyCell
        let medicine = medicines[indexPath.section]
        cell.configure(title: medicine.remedy, time: medicine.time, recurrency: medicine.recurrency)
        
        cell.onDelete =  {  [weak self] in
            guard let self = self else {return}
            if let actualIndexPath = tableView.indexPath(for: cell) {
                if(actualIndexPath.section < self.medicines.count ) {
                    self.viewModel.deleteReceipt(byId: self.medicines[actualIndexPath.section].id)
                    self.medicines.remove(at: actualIndexPath.row)
                    
                    tableView.deleteSections(IndexSet(integer: actualIndexPath.section), with: .automatic)
                    tableView.reloadData()
                }
            }else {
                print("Erro ao excluir uma sessão inválida")
            }
        }
        
        
        return cell
    }
}

extension MyReceiptsViewController: MyReceiptsViewDelegate {
    @objc
    func didTapBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func didTapAddButton(){
        flowDelegate?.navigateToAddReceipt()
    }
}
