//
//  NetworkManager.swift
//  federalRegistryClient
//
//  Created by cladendas on 22.06.2021.
//

import Foundation

final class NetworkManager {
    static var num = ""
    
    private static let tmpToken = "94syEB56qRtu"
    
    private static let schema = "http"
    private static let host = "rosreestr.ru"
    private static var searchPath: String {
        get {
            return "/api/online/fir_objects/\(num)"
        }
    }
    
//    http://rosreestr.ru/api/online/fir_objects/2:56:30302:639
    
    ///Проверка выполнения сессии и получения данных
    private static func checkSession(data: Data?, response: URLResponse?, error: Error?) -> Data? {
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            print("http status code: \(httpResponse.statusCode)")
        }
        
        guard let data = data else {
            print("no data received")
            return nil
        }
        
        return data
    }
    
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
    
    ///выполнение запроса по поиску объектов в Рееестр
    static func performSearchObject(complition: @escaping (_ objects: [Object]) -> ()) {
        
        var tmpObjects: [Object] = []
        
        guard let urlRequest = requestRegistry() else {
            print("url request error")
            return
        }
        
        //создание сессии и выполнение запроса
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = checkSession(data: data, response: response, error: error) else {
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
    
    ///создание запроса в ФССП по физлицам для получения task
    private static func requestFSSP(_ region: String, _ firstname: String, _ lastname: String, _ token: String) -> URLRequest? {
        
//        https://api-ip.fssp.gov.ru/api/v1.0/search/physical?region=66&lastname=Иванов&firstname=Иван&token=94syEB56qRtu
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api-ip.fssp.gov.ru"
        urlComponents.path = "/api/v1.0/search/physical"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "region", value: region),
            URLQueryItem(name: "firstname", value: firstname),
            URLQueryItem(name: "lastname", value: lastname),
            URLQueryItem(name: "token", value: tmpToken)
        ]
        
        guard let url = urlComponents.url else { return nil }
        
        let request = URLRequest(url: url)
        
//        request.allHTTPHeaderFields = deafaultHeader
        
        return request
    }
    
    ///Создание запроса на получение данных по физлицу от ФССП по task
    private static func requestFSSPTask(_ task: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api-ip.fssp.gov.ru"
        urlComponents.path = "/api/v1.0/result"
        
//        https://api-ip.fssp.gov.ru/api/v1.0/result
        
        urlComponents.queryItems = [
            URLQueryItem(name: "task", value: task),
            URLQueryItem(name: "token", value: tmpToken)
        ]
        
        guard let url = urlComponents.url else { return nil }
        
        let request = URLRequest(url: url)
        
//        request.allHTTPHeaderFields = deafaultHeader
        
        return request
    }
    
    ///Выполнение запроса на получение от ФССП данных по физлицам по task
    static func performSearchFSSPTask(_ task: String, complition: @escaping (_ resultResult: [ResultResult]) -> ()) {
        
        var tmpResultResult: [ResultResult] = []
        
        print("fffff", task)
        
        guard let urlRequest = requestFSSPTask(task) else {
            print("url request error")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = checkSession(data: data, response: response, error: error) else {
                print("no data received")
                return
            }
            print("----------")
            var ff = parseJSON(withData: data)

//            if let sss = ff?.response.result {
//
//                print(type(of: sss))
//                complition(tmpResultResult)
//            }
            
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any> {
//
//                    //перебираем словарь сразу для получения информации по объекту из базы ФССП
//                    if let responseResultJSON = json["response"] as? Dictionary<String, Any> {
//                        if let resultJSON = responseResultJSON["result"] as? [Dictionary<String, Any>] {
//                            print("2222", type(of: resultJSON[0]), resultJSON[0].keys)
//                            let dd = resultJSON[0]
//
//                            print(dd)
//                            if let resultResultJSON = resultJSON[0]["result"] as? Dictionary<String, Any>{
//
//                                print("let resultResultJSON 1", resultResultJSON.count)
//                                resultResultJSON.forEach {
//                                    guard let tmp = ResultResult(json: $0 as! Dictionary<String, Any>) else { return }
//                                    print("type of $0", type(of: tmp))
//                                    tmpResultResult.append(tmp)
//                                }
//                            }
//                        }
//                    }
//
//                    complition(tmpResultResult)
//                }
//            } catch {
//                print(error)
//            }
            
        }
        
        dataTask.resume()
    }
    
    ///Выполнение запроса на получение task для поиска физлиц в ФССП
    ///- parameter region:  регион
    ///- parameter firstname: имя
    ///- parameter lastname: фамилия
    ///- parameter token: токен
    ///- parameter complition: вернёт объекты по заданным параметрам
    static func performSearchFSSP(region: String, firstname: String, lastname: String, token: String, complition: @escaping (_ resultResult: [ResultResult], String) -> ()) {
        
        print(region, firstname, lastname, token)
        
        var tmpResultResult: [ResultResult] = []
        var tttt = ""
        
        guard let urlRequest = requestFSSP(region, firstname, lastname, token) else {
            print("url request error")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            guard let data = checkSession(data: data, response: response, error: error) else {
                print("no data received")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any> {

                    if let responseResultJSON = json["response"] as? Dictionary<String, Any> {
                        if let task = responseResultJSON["task"] as? String {
                            tttt = task
                        }
                    }
                    complition(tmpResultResult, tttt)
                }
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }
    
    ///Парсинг полученных данных
    private static func parseJSON(withData data: Data) -> ObjectFSSP? {
        let decoder = JSONDecoder()
        
        do {
            let objectFSSP = try decoder.decode(ObjectFSSP.self, from: data)
            print(objectFSSP)
            return objectFSSP
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
