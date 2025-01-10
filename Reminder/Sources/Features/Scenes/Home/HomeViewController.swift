//
//  HomeViewController.swift
//  Reminder
//
//  Created by Lucas Rosa on 07/01/25.
//

import Foundation
import UIKit

class HomeViewController:UIViewController {
    let contentView: HomeView
    public weak var flowDelegate: HomeFlowDelegate?
    
    init(contentView: HomeView, flowDelegate: HomeFlowDelegate){
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
        setupNavigationBar()
    }
    
    
    private func setup(){
        self.view.addSubview(contentView)
        self.view.backgroundColor = Colors.gray600
        
        //contentView.translatesAutoresizingMaskIntoConstraints = false
        buildHierarchy()
    }
    
    private func buildHierarchy(){
        setupContentViewToBounds(contentView: contentView)
    }
    
    private func setupNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        
        let logoutButton = UIBarButtonItem(image: UIImage(named: "log-out-icon"), style: .plain, target: self, action: #selector(logoutAction))
        logoutButton.tintColor = Colors.primaryRedBase
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc
    private func logoutAction(){
        UserDefaultsManager.removeUser()
        self.flowDelegate?.logout()
    }
    
    
}
