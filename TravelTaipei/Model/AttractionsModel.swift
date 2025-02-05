//
//  AttractionsModel.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/5.
//

struct AttractionsModel: Codable {
    var total: Int
    var data: [Attraction]
}

struct Attraction: Codable {
    var id: Int
    var name: String
    var openStatus: Int
    var introduction: String
    var openTime: String
    var zipcode: String
    var distric: String
    var address, tel: String
    var fax: String
    var email: String
    var months: String
    var nlat, elong: Double
    var officialSite: String
    var facebook: String
    var ticket: String
    var remind: String
    var staytime: String
    var modified: String
    var url: String
    var category: [Category]
    var target: [Target]
    var service: [Service]
    var friendly: [Friendly]
    var images: [Image]
    var links: [Link]
}

struct Category: Codable {
    var id: Int
    var name: String
}

struct Target: Codable {
    var id: Int
    var name: String
}

struct Service: Codable {
    var id: Int
    var name: String
}

struct Friendly: Codable {
    var id: Int
    var name: String
}

struct Image: Codable {
    var src: String
    var subject: String
    var ext: String
}

struct Link: Codable {
    var src: String
    var subject: String
}
