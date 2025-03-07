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
    
    init(contentView: MyReceiptsView, flowDelegate: MyReceiptsViewFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupActions()
    }
    
    func setup(){
        view.addSubview(contentView)
        view.backgroundColor = Colors.gray800
        setupContraints()
    }
    
    func setupContraints(){
        setupContentViewToBounds(contentView: contentView, isTopSafe: false)
    }
    
    @objc
    func didTapBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func didTapAddButton(){
        flowDelegate?.navigateToAddReceipt()
    }
    
    func setupActions(){
        contentView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        contentView.addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
}
