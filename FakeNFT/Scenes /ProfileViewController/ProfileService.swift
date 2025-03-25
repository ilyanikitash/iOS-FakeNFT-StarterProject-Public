//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Давид Бекоев on 24.03.2025.
//


import Foundation

typealias ProfileCompletion = (Result<Profile, Error>) -> Void

protocol ProfileService {
    func loadProfile(completion: @escaping ProfileCompletion)
    func updateProfile(
        name: String,
        description: String,
        website: String,
        avatar: String,
        completion: @escaping ProfileCompletion
    )
}

final class ProfileServiceImpl: ProfileService {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func loadProfile(completion: @escaping ProfileCompletion) {
        let request = ProfileRequest()
        networkClient.send(request: request, type: Profile.self) { result in
            completion(result)
        }
    }

    func updateProfile(
        name: String,
        description: String,
        website: String,
        avatar: String,
        completion: @escaping ProfileCompletion
    ) {
        let dto = ProfileDtoObject(name: name, description: description, website: website, avatar: avatar)

        let request = ProfilePutRequest(dto: dto)

        networkClient.send(request: request, type: Profile.self) { result in
            switch result {
            case .success(let updatedProfile):
                completion(.success(updatedProfile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
