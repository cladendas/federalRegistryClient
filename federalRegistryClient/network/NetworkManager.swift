//
//  NetworkManager.swift
//  federalRegistryClient
//
//  Created by cladendas on 22.06.2021.
//

import Foundation

final class NetworkManager {
    static var num = ""
    
    private static let schema = "http"
    private static let host = "rosreestr.ru"
    private static var searchPath: String {
        get {
            return "/api/online/fir_objects/\(num)"
        }
    }
    
//    http://rosreestr.ru/api/online/fir_objects/2:56:30302:639
    
    ///создание запроса в Росреестр по кадастровому номеру
    private static func requestRegistry() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = schema
        urlComponents.host = host
        urlComponents.path = searchPath
        
        guard let url = urlComponents.url else { return nil }
        
        let request = URLRequest(url: url)
        
//        request.allHTTPHeaderFields = deafaultHeader
        
        return request
    }
    
    static func performSearchObject(complition: @escaping (_ repositories: [Object]) -> ()) {
        
        var tmpObjects: [Object] = []
        
        guard let urlRequest = requestRegistry() else {
            print("url request error")
            return
        }
        
        //создание сессии и выполнение запроса
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("http status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("no data received")
                return
            }
              
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as?  [Dictionary<String, Any>] {
//                    let tmpRepositories = json["items"] as? [Dictionary<String, Any>]
                    
                    //Преобразование каждого элемента массива json в элемент с типом Object и добавление его в массив tmpObjects
                    json.forEach({
                        guard let tmp = Object(json: $0) else { return }
                        tmpObjects.append(tmp)
                    })
                
                    complition(tmpObjects)
                }
            } catch {
                print(error)
            }
            
            guard let _ = String(data: data, encoding: .utf8) else {
                print("data encoding failed")
                return
            }
        }
        
        dataTask.resume() 
    }
}
