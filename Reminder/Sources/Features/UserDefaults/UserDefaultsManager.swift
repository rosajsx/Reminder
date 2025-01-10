//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Lucas Rosa  on 03/01/25.
//

import Foundation
import UIKit

class UserDefaultsManager {
    private static let userKey = "userKey"
    private static let usertNameKey = "userName"
    private static let userPhotoKey = "userPhoto"
    
    static func saveUser(user: User){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func saveUserName(name: String) {
        UserDefaults.standard.set(name, forKey: usertNameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func saveUserPhoto(image: UIImage) {
        if let encondedImage = image.pngData()?.base64EncodedString() {
            UserDefaults.standard.set(encondedImage, forKey: userPhotoKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func loadUser() -> User? {
        if let userData = UserDefaults.standard.data(forKey: userKey) {
            let decoder = JSONDecoder()
            
            if let user = try? decoder.decode(User.self, from: userData) {
                return user
            }
        }
        
        return nil
    }
    
    static func loadUserName() -> String? {
        return UserDefaults.standard.string(forKey: usertNameKey)
    }
    
    static func loadUserPhoto() -> UIImage? {
        if let imageData = UserDefaults.standard.string(forKey: userPhotoKey) {
            
            if let decodedImage = Data(base64Encoded: imageData) {
                return UIImage(data: decodedImage)
            }
            
        }
       return nil
    }
    
    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.synchronize()
    }
    
    static func removeUserName(){
        UserDefaults.standard.removeObject(forKey: usertNameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func removeUserPhoto(){
        UserDefaults.standard.removeObject(forKey: userPhotoKey)
        UserDefaults.standard.synchronize()
    }
}
