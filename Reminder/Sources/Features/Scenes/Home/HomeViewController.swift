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
    }
    

    private func setup(){
        self.view.addSubview(contentView)
       // self.navigationController?.navigationBar.isHidden = true
        
        //contentView.translatesAutoresizingMaskIntoConstraints = false
        buildHierarchy()
    }
    
    private func buildHierarchy(){
        setupContentViewToBounds(contentView: contentView)
    }
    
    
}
