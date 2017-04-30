//
//  TrackResponse.swift
//  Belajar-iOS
//
//  Created by rizki mufrizal on 4/30/17.
//  Copyright © 2017 rizki mufrizal. All rights reserved.
//

import Foundation
import ObjectMapper

struct TrackResponse: Mappable {
    var tracks: Track?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        tracks <- map["tracks"]
    }
}

struct Track: Mappable {
    var limit: Int?
    var next: String?
    var offset: Int?
    var previous: String?
    var total: Int?
    var items: [Item]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        limit <- map["limit"]
        next <- map["next"]
        offset <- map["offset"]
        previous <- map["previous"]
        total <- map["total"]
        items <- map["items"]
    }
}

struct Item: Mappable {
    var name: String?
    var previewUrl: String?
    var album: Album?
    var artists: [Artist]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        name <- map["name"]
        previewUrl <- map["preview_url"]
        album <- map["album"]
        artists <- map["artists"]
    }
}

struct Artist: Mappable {
    var name: String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        name <- map["name"]
    }
}

struct Album: Mappable {
    var name: String?
    var images: [Image]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        name <- map["name"]
        images <- map["images"]
    }
}

struct Image: Mappable {
    var height: Int?
    var width: Int?
    var url: String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        height <- map["height"]
        width <- map["width"]
        url <- map["url"]
    }
}
