//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by Lucas Rosa  on 27/12/24.
//

import Foundation
import Firebase

// Responsavel pela camada das regras de negócios.

class LoginBottomSheetViewModel {
    var successResult: ((String) -> Void)?
    
    func doAuth(usernameLogin: String, password: String){
        print(usernameLogin, password)
        Auth.auth().signIn(withEmail: usernameLogin, password: password) { [weak self] authResult, error in
            if let error = error {
               
                print("Autenticação falhou! \(error)")
            } else {
                self?.successResult?(usernameLogin)
                print(authResult)
            }
        }
    }
}
