//
//  ViewController.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 11.10.2021.
//

import UIKit
import DefaultNetworkOperationPackage

typealias CharacterListResult = Result<CharacterDataResponse, ErrorResponse>

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?ts=8F46CC9B-4885-4D8D-9761-9092B84D4C5A&apikey=b1b6a2c675b36a5e44800a4fbaa2fb8e&hash=68cb7ec069de76b37db17dc7e2aa5b5c&offset=0&limit=30") else { return }
        
        let urlRequest = URLRequest(url: url)
        APIManager.shared.executeRequest(urlRequest: urlRequest) { (result: CharacterListResult) in
            switch result {
            case .success(let response):
                print("Al Data",response.data.results)
            case .failure(let error):
                print(error.serverResponse?.returnMessage)
            }
        }
    }
}

// MARK: - CharacterDataResponse
public struct CharacterDataResponse: Codable {
    public let data: CharacterListData
    
    public init(data: CharacterListData) {
        self.data = data
    }
    
}

// MARK: - DataClass
public struct CharacterListData: Codable {
    public let offset, limit, total, count: Int
    public let results: [CharacterData]
    
    public init(offset: Int, limit: Int, total: Int, count: Int, results: [CharacterData]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}

// MARK: - Result
public struct CharacterData: Codable {
    public let id: Int
    public let name: String
    public let thumbnail: Thumbnail
    public let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case thumbnail
        case description
    }
    
    public init(id: Int, name: String, thumbnail: Thumbnail, description: String?) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
    }
}

// MARK: - Comics
public struct Comics: Codable {
    public let available: Int
    public let collectionURI: String
    public let items: [ComicsItem]
    public let returned: Int
    
    public init(available: Int, collectionURI: String, items: [ComicsItem], returned: Int) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
    
}

// MARK: - ComicsItem
public struct ComicsItem: Codable {
    public let resourceURI: String
    public let name: String
    
    public init(resourceURI: String, name: String) {
        self.resourceURI = resourceURI
        self.name = name
    }
    
}

public enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case unknown = "unknown"
}

extension ItemType {
    public init(from decoder: Decoder) throws {
        self = try ItemType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}

// MARK: - Thumbnail
public struct Thumbnail: Codable {
    public let path: String
    public let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

public enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case unknown = "unknown"
}

extension Extension {
    public init(from decoder: Decoder) throws {
        self = try Extension(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}

