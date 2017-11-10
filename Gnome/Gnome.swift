//
//  Gnome.swift
//  Gnome
//
//  Created by Vladimir Spasov on 10/11/17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import ObjectMapper

class Gnome: NSObject, Mappable {

    var id: Int?
    var name: String?
    var thumbnail: String?
    var age: Int?
    var weight: Float?
    var height: Float?
    var hairColor: String?
    var professions:[String]?
    var friends:[String]?

    override init() {
        super.init()
    }

    convenience required init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        thumbnail <- map["thumbnail"]
        age <- map["age"]
        weight <- map["weight"]
        height <- map["height"]
        hairColor <- map["hair_color"]
        professions <- map["professions"]
        friends <- map["friends"]
    }
}

