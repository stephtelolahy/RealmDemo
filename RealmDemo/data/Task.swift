//
//  Task.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/16/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

import RealmSwift

class Task: Object {
    @objc dynamic var name = ""
    @objc dynamic var creationDate = Date(timeIntervalSince1970: 1)
    let associatedTags = LinkingObjects(fromType: Tag.self, property: "members")
}
