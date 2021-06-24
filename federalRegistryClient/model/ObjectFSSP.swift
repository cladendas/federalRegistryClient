//
//  ObjectFSSP.swift
//  federalRegistryClient
//
//  Created by cladendas on 24.06.2021.
//

import Foundation

struct ObjectFSSP: Codable {
    private(set) var status: String
    private(set) var code: Int
    private(set) var exception: String
    private(set) var response: ResponseObjectFSSP?
    
    init?(json: Dictionary <String, Any>) {
        guard
            let status = json["json"] as? String,
            let code = json["code"] as? Int,
            let exception = json["exception"] as? String,
            let response = json["response"] as? Dictionary <String, Any>
        else { return nil }
        
        self.status = status
        self.code = code
        self.exception = exception
        self.response = ResponseObjectFSSP(json: response)
    }
}

struct ResponseObjectFSSP: Codable {
    private(set) var status: Int
    private(set) var taskStart, taskEnd: String
    private(set) var result: ResponseResult?
    
    init?(json: Dictionary <String, Any>) {
        guard
            let status = json["status"] as? Int,
            let taskStart = json["taskStart"] as? String,
            let taskEnd = json["taskEnd"] as? String,
            let result = json["result"] as? Dictionary <String, Any>
        else { return nil }

        self.status = status
        self.taskStart = taskStart
        self.taskEnd = taskEnd
        self.result = ResponseResult(json: result)
    }
}

struct ResponseResult: Codable {
    private(set) var status: Int
    private(set) var result: ResultResult?
    
    init?(json: Dictionary <String, Any>) {
        guard
            let status = json["status"] as? Int,
            let result = json["result"] as? Dictionary <String, Any>
        else { return nil }

        self.status = status
        self.result = ResultResult(json: result)
    }
}

///все найденные физ лица
struct ResultResult: Codable {
    private(set) var name, exeProduction, details, subject: String
    private(set) var department, bailiff, ipEnd: String

    enum CodingKeys: String, CodingKey {
        case name
        case exeProduction = "exe_production"
        case details, subject, department, bailiff
        case ipEnd = "ip_end"
    }
    
    init?(json: Dictionary <String, Any>) {
        guard
            let name = json["name"] as? String,
            let exeProduction = json["exe_production"] as? String,
            let details = json["details"] as? String,
            let subject = json["subject"] as? String,
            let department = json["department"] as? String,
            let bailiff = json["bailiff"] as? String,
            let ipEnd = json["ipEnd"] as? String
        else { return nil }
        
        self.name = name
        self.exeProduction = exeProduction
        self.details = details
        self.subject = subject
        self.department = department
        self.bailiff = bailiff
        self.ipEnd = ipEnd
    }
}

/*
"result": [
                    {
                        "name": "ИВАНОВ ИВАН АЛЕКСАНДРОВИЧ 16.10.1996 РОССИЯ ГОР. ЕКАТЕРИНБУРГ",
                        "exe_production": "43265/21/66062-ИП от 11.03.2021",
                        "details": "Акт органа, осуществляющего контрольные функции от 02.03.2021 № 854 Постановление о взыскании исполнительского сбора ИНСПЕКЦИЯ ФЕДЕРАЛЬНОЙ НАЛОГОВОЙ СЛУЖБЫ ПО ЛЕНИНСКОМУ РАЙОНУ Г.ЕКАТЕРИНБУРГА",
                        "subject": "Взыскание налогов и сборов, включая пени: 40978.23 руб. Исполнительский сбор: 2868.48 руб.",
                        "department": "МО по ИОИП 620062, Россия, , , г. Екатеринбург, , ул. Генеральская, д. 6, корп. а, ",
                        "bailiff": "НЕЛЮБИНА К. В.<br>+73433622808",
                        "ip_end": ""
                    },
**/

