//
//  Tags.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/17/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

import RealmSwift

class Tag: Object {
    @objc dynamic var name = ""
    let members = List<Task>()
}
