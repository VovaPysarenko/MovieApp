//
//  User.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 19.09.2021.
//

import Foundation
import Firebase

struct AppUser {
    
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
