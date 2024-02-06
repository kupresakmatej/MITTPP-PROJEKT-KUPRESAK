//
//  Show.swift
//  Shows
//
//  Created by Matej Kuprešak on 18.09.2023..
//

import Foundation

struct Person: Codable, Hashable, Equatable {
    let id: Int
    let url: String?
    let name: String
    let image: [String: String]?
    var character: Character?
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Character: Codable {
    let id: Int
    let name: String
}

struct SearchResponse: Codable {
    let show: Show
}

struct CastResponse: Codable {
    let person: Person
    let character: Character?
}

struct HomeScreenShow: Codable {
    let show: Show
}

struct HomeScreenSchedule: Codable {
    let show: Show
    var airtime: String?
}

struct Rating: Codable {
    let average: Double?
}

struct Show: Codable, Equatable, Hashable {
    let id: Int
    let url: String
    let name: String
    let language: String?
    let genres: [String]?
    let premiered: String?
    let image: [String: String]?
    let rating: Rating?
    var airtime: String?
    let summary: String?

    static func ==(lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
