//
//  PaymentNetworkService.swift
//  FakeNFT
//
//  Created by Кирилл Дробин on 29.03.2025.
//

import Foundation

final class PaymentNetworkService {
    // MARK: - Singleton
    static let shared = PaymentNetworkService()
    private let storage = Storage.shared
    
    // MARK: - Private Properties
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    private(set) var orderId = String()
    private init() {}
    
    private enum PaymentNetworkServiceError: Error {
        case paymentNetworkServiceError
    }
    
    // MARK: - Order Fetch
    func getOrder(_ completion: @escaping (Result<Order, Error>) -> Void) {
        if task != nil {
            task?.cancel()
        }
        
        guard let request = makeRequest(string: HttpStrings.order.rawValue,
                                        httpMethod: HttpMethod.get.rawValue),
              task == nil
        else {
            print("Order request error")
            return
        }
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<Order, Error>) in
            guard let self else { return }
            self.task = nil
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.orderId = data.id
                }
                
            case .failure(let error):
                print("responce error: \(error)")
            }
        }
        self.task = task
        task.resume()
    }
    
    func getCurrencies(_ completion: @escaping (Result<[Currency], Error>) -> Void) {
        if task != nil {
            task?.cancel()
        }
        
        guard let request = makeRequest(string: HttpStrings.currencies.rawValue,
                                        httpMethod: HttpMethod.get.rawValue),
              task == nil
        else {
            print("Currencies request error")
            return
        }
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<[Currency], Error>) in
            guard let self else { return }
            self.task = nil
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.storage.forCurrenciesCollection = data
                }
                completion(.success(data))
            case .failure(let error):
                print("responce error: \(error)")
            }
        }
        self.task = task
        task.resume()
        
    }
    
    func setCurrencyBeforePay(currencyID: String, _ completion: @escaping (Result<SetCurrency, Error>) -> Void) {
        if task != nil {
            task?.cancel()
        }
        
        guard let request = makeRequest(string: "\(HttpStrings.payment.rawValue)" + "\(currencyID)",
                                        httpMethod: HttpMethod.get.rawValue),
              task == nil
        else {
            print("setCurrency request error")
            return
        }
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<SetCurrency, Error>) in
            guard let self else { return }
            self.task = nil
            switch result {
            case .success(let responce):
                completion(.success(responce))
                print("\(responce)")
            case .failure(let error):
                completion(.failure(error))
                print("responce error: \(error)")
            }
        }
        self.task = task
        task.resume()
        
    }
    
    // MARK: - Order Update
    func updateOrder(_ completion: @escaping (Result<Order, Error>) -> Void) {
        if task != nil {
            task?.cancel()
        }
        
        var nfts: [String] = []
        
        for i in storage.mockCartNfts {// брать из словаря данных для постоения таблицы корзины
            nfts.append(i.id)
            print("nfts: \(nfts)")
        }
        
        guard var request = makeRequest(string: HttpStrings.order.rawValue,
                                        httpMethod: HttpMethod.put.rawValue),
              task == nil
        else {
            print("PUT Order request error")
            return
        }
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //        let messageData = OrderUpdate(nfts: nfts)
        //        let data = try? JSONEncoder().encode(nfts)
        //        request.httpBody = try? JSONEncoder().encode(data)
        var requestComponents = URLComponents()
        requestComponents.queryItems = [URLQueryItem(name: "nfts", value: arrayToStringConverter(nfts: nfts))]
        
        //        let data = "nfts:\(nfts)"
        request.httpBody = requestComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<Order, Error>) in
            guard let self else { return }
            self.task = nil
            switch result {
            case .success(let responce):
                DispatchQueue.main.async {
                    completion(.success(responce))
                    print("PUT ok: \(responce)")
                }
            case .failure(let error):
                completion(.failure(error))
                print("responce error: \(error)")
            }
        }
        task.resume()
        return
    }
}

private func makeRequest(string: String, httpMethod: String) -> URLRequest? {
    guard let url = URL(
        string: string,
        relativeTo: URL(string: RequestConstants.baseURL)
    ) else {
        preconditionFailure("Unable to construct url")
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    request.setValue(RequestConstants.token, forHTTPHeaderField: "X-Practicum-Mobile-Token")
    print("URL Request: \(request)")
    return request
}

private func arrayToStringConverter(nfts: [String]) -> String {
    var dateStringArray = [String]()
    for i in nfts {
        dateStringArray.append(i)
    }
    return dateStringArray.joined(separator: ",")
}


//private func makePutRequest(string: String) -> URLRequest? {
//    guard let url = URL(
//        string: string,
//        relativeTo: URL(string: RequestConstants.baseURL)
//    ) else {
//        preconditionFailure("Unable to construct url")
//    }
//
//    var request = URLRequest(url: url)
//    request.setValue(RequestConstants.token, forHTTPHeaderField: "X-Practicum-Mobile-Token")
//    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//    request.httpMethod = HttpMethod.put.rawValue
//    return request
//}

