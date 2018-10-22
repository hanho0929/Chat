//
//  Category.swift
//  Chat
//
//  Created by hanho on 10/20/18.
//  Copyright © 2018 hanho. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let stories = List<Story>()
    
}
