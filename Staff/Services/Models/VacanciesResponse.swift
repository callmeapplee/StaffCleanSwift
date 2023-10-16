
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcom = try? newJSONDecoder().decode(Welcom.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cities = try? newJSONDecoder().decode(Cities.self, from: jsonData)

import Foundation

// MARK: - Cities
struct VacanciesResponseWrapped: Codable {
    var response: VacanciesResponse
}

// MARK: - Response
struct VacanciesResponse: Codable {
    var currentPage:Int
    var data: [Vacancy]
    enum CodingKeys: String, CodingKey {
        case data
        case currentPage = "current_page"
    }
}

// MARK: - Datum
struct Vacancy: Codable {
    let id: Int
    let position:String
    let datumDescription: String?
    let employerID, categoryID, cityID, languageID: Int
    let experienceID, scheduleTypeID, payrollTypeID, salaryMin: Int
    let salaryMax, viewsNumber, status: Int
    let startTime, endTime, createdAt, updatedAt: String
    let category: VacancyCategory
    let employer: VacancyEmployer
    let city: VacancyCity
    let experience: VacancyExperience
    let scheduleType, payrollType: VacancyCategory

    enum CodingKeys: String, CodingKey {
        case id, position
        case datumDescription = "description"
        case employerID = "employer_id"
        case categoryID = "category_id"
        case cityID = "city_id"
        case languageID = "language_id"
        case experienceID = "experience_id"
        case scheduleTypeID = "schedule_type_id"
        case payrollTypeID = "payroll_type_id"
        case salaryMin = "salary_min"
        case salaryMax = "salary_max"
        case viewsNumber = "views_number"
        case status
        case startTime = "start_time"
        case endTime = "end_time"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case category, employer, city, experience
        case scheduleType = "schedule_type"
        case payrollType = "payroll_type"
    }
}

// MARK: - Category
struct VacancyCategory: Codable {
    let id: Int
    let name: String
    let icon: String?
    let status: Int
}

// MARK: - City
struct VacancyCity: Codable {
    let id: Int
    let nameTj, nameRu, nameEn: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case id
        case nameTj = "name_tj"
        case nameRu = "name_ru"
        case nameEn = "name_en"
        case status
    }
}

// MARK: - Employer
struct VacancyEmployer: Codable {
    let id, accountID: Int
    let name, logo:String
    let employerDescription: String?
    let categoryID, status: Int
    let startTime, endTime, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case accountID = "account_id"
        case name, logo
        case employerDescription = "description"
        case categoryID = "category_id"
        case status
        case startTime = "start_time"
        case endTime = "end_time"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Experience
struct VacancyExperience: Codable {
    let id: Int
    let name: String
}


