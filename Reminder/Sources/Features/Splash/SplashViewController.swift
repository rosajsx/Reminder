//
//  SplashViewController.swift
//  Reminder
//
//  Created by Lucas Rosa  on 17/12/24.
//

import Foundation
import UIKit

// View controller cabe a decisão de navegação, alguns fluxos ou chamar o coordinator. Não cabe layout.
class SplashViewController: UIViewController {
    
    let contentView: SplashView
    weak var flowDelegate: SplashViewFlowDelegate?
    
    
    init(contentView: SplashView, flowDelegate: SplashViewFlowDelegate){
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Ciclo de vida da tela
    // Executa quando a tela carregar
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBreathingAnimation()
        setup()
        
    }
    
    private func decideNavigationFlow(){
        //Verifica se existe um usuário e ai cria ele, se existir se o isUserSaved true entra na closure.
        if let user =  UserDefaultsManager.loadUser(), user.isUserSaved {
            flowDelegate?.navigateHome()
        } else {
            showLoginBottomSheet()
        }
    }
    
    private func setup(){
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.primaryRedBase
        setupConstraints()
        //setupGesture()
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
    
//    private func setupGesture(){
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLoginBottomSheet))
//        self.view.addGestureRecognizer(tapGesture)
//    }
    
   
    @objc
    private func showLoginBottomSheet(){
        animateLogoUp()
        self.flowDelegate?.openLoginBottomSheet()
        
    }
    
   
}


//MARK: - Animations
extension SplashViewController {
    private func startBreathingAnimation(){
        UIView.animate(withDuration: 1.5, delay: 0.0, animations: {
            self.contentView.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            self.decideNavigationFlow()
        })
        
    }
    
    private func animateLogoUp(){
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
            self.contentView.logoImageView.transform = self.contentView.logoImageView.transform.translatedBy(x: 0, y: -140)
        })
    }
}
