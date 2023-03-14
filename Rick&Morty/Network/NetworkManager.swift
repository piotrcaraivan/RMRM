//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by Петр Караиван on 10.03.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func getCharacters(name: String?, status: Status?, gender: Gender?) async -> [RMCharacter]
    func getNextCharacters() async -> [RMCharacter]?
    func getCharacter(id: Int) async throws -> RMCharacter
    
    func getEpisode(_ episodeUrlString: String) async throws -> Episode
}

final class NetworkManager: NetworkManagerProtocol {
    private let decoder = JSONDecoder()
    
    private var nextPageUrlString: String?
    
    private let baseUrlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        return components
    }()
    
    private func getUrlComponents(
        for endpointType: Network.EndpointType,
        with queryItems: [String: String?]
    ) -> URLComponents {
        var urlComponents = baseUrlComponents
        urlComponents.path = "/api/" + endpointType.rawValue
        urlComponents.queryItems = queryItems.compactMap { (key, value) -> URLQueryItem? in
            guard let value = value else { return nil }
            return URLQueryItem(name: key, value: value)
        }
//        if !urlQueryItems.isEmpty { urlComponents.queryItems = urlQueryItems }
        return urlComponents
    }
    
    private func requestData(from url: URL) async throws -> Network.APIResponse<RMCharacter> {
        let (data, _) = try await URLSession.shared.data(from: url)
        let apiResponse = try decoder.decode(Network.APIResponse<RMCharacter>.self, from: data)
        nextPageUrlString = apiResponse.info.next
        return apiResponse
    }
    
    func getCharacters(name: String?, status: Status?, gender: Gender?) async -> [RMCharacter] {
        let urlComponents = getUrlComponents(for: .character, with: [
            "name": name, "status": status?.rawValue, "gender": gender?.rawValue
        ])
        guard let url = urlComponents.url else { return [] }
        let apiResponse = try? await requestData(from: url)
        return apiResponse?.results ?? []
    }
    
    func getNextCharacters() async -> [RMCharacter]? {
        guard let nextPageUrlString = nextPageUrlString,
              let url = URL(string: nextPageUrlString) else { return nil }
        
        let apiResponse = try? await requestData(from: url)
        return apiResponse?.results
    }
    
    func getCharacter(id: Int) async throws -> RMCharacter {
        var urlComponents = getUrlComponents(for: .character, with: [:])
        urlComponents.path += "/\(id)"
        guard let url = urlComponents.url else { throw Network.Error.invalidUrl }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(RMCharacter.self, from: data)
    }
    
    func getEpisode(_ episodeUrlString: String) async throws -> Episode {
        guard let url = URL(string: episodeUrlString) else { throw Network.Error.invalidUrl }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(Episode.self, from: data)
    }
}
