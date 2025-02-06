//
//  NewsModel.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/5.
//

struct NewsModel: Codable {
    var total: Int
    var data: [News]
}

struct News: Codable {
    var id: Int
    var title: String
    var description: String
    var posted: String
    var modified: String
    var url: String
    var files: [File]
    var links: [Link]
}

struct File: Codable {
    var src: String
    var subject: String
    var ext: String
}
