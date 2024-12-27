//
//  LoginBottomSheetViewController.swift
//  Reminder
//
//  Created by Lucas Rosa  on 23/12/24.
//

import Foundation
import UIKit

// Da para comunicar entre classes com delegates ou com closures.
// Com closures, posso usar a abordagem da variavel ou, por parametro.


class LoginBottomSheetViewController: UIViewController {

    let loginView = LoginBottomSheetView()
    let viewModel = LoginBottomSheetViewModel()
    
    var handleAreaHeight: CGFloat = 50.0
    public weak var flowDelegate: LoginBottomSheetFlowDelegate?
    
    init(flowDelegate: LoginBottomSheetFlowDelegate){
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        setupUI()
        setupGesture()
        bindViewModel()
    }
    
    private func setupUI(){
        self.view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        let heightConstraint = loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    private func bindViewModel(){
        viewModel.successResult = { [weak self] in
            self?.flowDelegate?.navigateToHome()
        }
    }
    
    
    private func setupGesture(){
        
    }
    
    private func handlePanGesture(){
        
    }
    
     func animateShow(completion: (() -> Void)? = nil){
        self.view.layoutIfNeeded() // atualiza a tela
        loginView.transform = CGAffineTransform(translationX: 0, y: loginView.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.loginView.transform = .identity
            self.view.layoutIfNeeded()
        }) { _ in
            completion?()
        }
    }
}

extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendLoginData(user: String, password: String) {
        viewModel.doAuth(usernameLogin: user, password: password)
    }

}
