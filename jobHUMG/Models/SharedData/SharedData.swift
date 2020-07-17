//
//  SharedData.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

// MARK: - General information
class SharedData {

    // Access token for requesting APIs
    class var accessToken: String? {
        get {
            return (UserDefaults.standard.value(forKey: "ApiAccessToken") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "ApiAccessToken")
        }
    }
    
    // User Information
    class var id: Int? {
        get {
            return (UserDefaults.standard.value(forKey: "Id") as? Int)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Id")
        }
    }
    
    class var fullName: String? {
        get {
            return (UserDefaults.standard.value(forKey: "FullName") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "FullName")
        }
    }
    
    class var birthday: String? {
        get {
            return (UserDefaults.standard.value(forKey: "Birthday") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Birthday")
        }
    }
    
    class var phoneNumber: String? {
        get {
            return (UserDefaults.standard.value(forKey: "PhoneNumber") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "PhoneNumber")
        }
    }
    
    class var skype: String? {
        get {
            return (UserDefaults.standard.value(forKey: "Skype") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Skype")
        }
    }
    
    class var email: String? {
        get {
            return (UserDefaults.standard.value(forKey: "Email") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Email")
        }
    }
    
    class var martial: String? {
        get {
            return (UserDefaults.standard.value(forKey: "Martial") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Martial")
        }
    }
    
    class var hobby: String? {
        get {
            return (UserDefaults.standard.value(forKey: "Hobby") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Hobby")
        }
    }
    
    class var avatar: String? {
        get {
            return (UserDefaults.standard.value(forKey: "Avatar") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Avatar")
        }
    }
    
    class var career: String? {
        get {
            return (UserDefaults.standard.value(forKey: "Career") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Career")
        }
    }
    
    class var introduce: String? {
        get {
            return (UserDefaults.standard.value(forKey: "Introduce") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Introduce")
        }
    }
    
    class var account: String? {
        get {
            return (UserDefaults.standard.value(forKey: "Account") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Account")
        }
    }
    
    class var password: String? {
        get {
            return (UserDefaults.standard.value(forKey: "Password") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "Password")
        }
    }
}
