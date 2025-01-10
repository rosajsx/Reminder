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
    let viewModel: HomeViewModel
    weak var flowDelegate: HomeFlowDelegate?

    init(contentView: HomeView, flowDelegate: HomeFlowDelegate){
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        self.viewModel = HomeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
        checkForExistingData()
    }
    
    
    private func setup(){
        self.view.addSubview(contentView)
        self.view.backgroundColor = Colors.gray600
        
        contentView.delegate = self
        setupConstraints()
    }
    
    private func setupConstraints(){
        setupContentViewToBounds(contentView: contentView)
    }
    
    private func checkForExistingData(){
        if let user = UserDefaultsManager.loadUser(){
            contentView.nameTextField.text = UserDefaultsManager.loadUserName()
            if let userImage = UserDefaultsManager.loadUserPhoto(){
                contentView.profileImage.image = userImage
            }
        }
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

extension HomeViewController: HomeViewDelegate {
    func didTapProfileImage() {
        self.selectProfileImage()
    }
    
   
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func selectProfileImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let edditedImage = info[.editedImage] as? UIImage {
            contentView.profileImage.image = edditedImage
            UserDefaultsManager.saveUserPhoto(image: edditedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            contentView.profileImage.image = originalImage
            UserDefaultsManager.saveUserPhoto(image: originalImage)
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
