//
//  User.swift
//  
//
//  Created by AutumnCAT on 2018/6/27.
//

import Foundation

struct User: Codable {
    var no:Int
    var point:Int
    var user:String
    var description:String
    
    static func saveToFile(users: [User]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(users) {
            UserDefaults.standard.setValue(data, forKey: "users")
        }
    }
    
    
    static func saveToFile(user: User) {
        let propertyEncoder = PropertyListEncoder()
        let propertyDecoder = PropertyListDecoder()
        let userDefault = UserDefaults.standard
        
        var users=Array<User>()
        
        if let data = UserDefaults.standard.data(forKey: "users"),
            let datas = try? propertyDecoder.decode([User].self, from: data) {
            users=datas
        }
        
        
        var i=0
        
        for us in users {
            if user.point>=us.point {
                users.insert(user, at: i)
                break
            }
            i=i+1
        }
        if i == users.count {
            users.append(user)
        }
        if users.count==0{
            users.insert(user, at: 0)
        }
        
        //更新排名
        for i in 1...users.count {
            users[i-1].no=i
        }
        
        if let data = try? propertyEncoder.encode(users) {
            UserDefaults.standard.setValue(data, forKey: "users")
        }
    }
    
    static func readLoversFromFile() -> [User]? {
        let propertyDecoder = PropertyListDecoder()
        if let data = UserDefaults.standard.data(forKey: "users"),
            let users = try? propertyDecoder.decode([User].self, from: data) {
            return users
        } else {
            return nil
        }
    }
    
}
