//
//  SplashViewController.swift
//  Reminder
//
//  Created by Lucas Rosa  on 17/12/24.
//

import Foundation
import UIKit


class SplashViewController: UIViewController {
    
    let contentView = SplashView()
    
    // View controller cabe a decisão de navegação, alguns fluxos ou chamar o coordinator. Não cabe layout.
    
    // Ciclo de vida da tela
    // Executa quando a tela carregar
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    private func setup(){
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.primaryRedBase
        setupConstraints()
        setupGesture()
    }
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Sempre colocar como false, para não confundir com Storyboard
        contentView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLoginBottomSheet))
        self.view.addGestureRecognizer(tapGesture)
    }
    
   
    @objc
    private func showLoginBottomSheet(){
        let loginButtonSheet = LoginBottomSheetViewController()
        loginButtonSheet.modalPresentationStyle = .overCurrentContext
        loginButtonSheet.modalTransitionStyle = .crossDissolve
        self.present(loginButtonSheet, animated: false, completion: {
            loginButtonSheet.animateShow()
        })
        
    }
    
   
}
