//
//  Stroy.swift
//  Chat
//
//  Created by hanho on 10/20/18.
//  Copyright © 2018 hanho. All rights reserved.
//

import Foundation
import RealmSwift

class Story: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var read: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "stories")
    
}
