//
//  HomeResponse.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 15/10/23.
//

import Foundation

// MARK: - Welcome
struct HomeResponseWrapped: Codable {
    let response: HomeResponse
}

// MARK: - Response
struct HomeResponse: Codable {
    let topCategories: [TopCategory]
    let topCompanies: [TopCompany]
    let cities: [City]
    let scheduleTypes: [ScheduleType]
    let experiences: [Experience]
    let numberOfNotifications: Int?

    enum CodingKeys: String, CodingKey {
        case topCategories = "top_categories"
        case topCompanies = "top_companies"
        case cities
        case scheduleTypes = "schedule_types"
        case experiences
        case numberOfNotifications = "number_of_notifications"
    }
}

// MARK: - City
struct City: Codable {
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

// MARK: - Experience
struct Experience: Codable {
    let id: Int
    let name: String
}

// MARK: - ScheduleType
struct ScheduleType: Codable {
    let id: Int
    let name: String
    let status: Int
}

// MARK: - TopCategory
struct TopCategory: Codable {
    let id: Int
    let name, icon: String
}

// MARK: - TopCompany
struct TopCompany: Codable {
    let id: Int
    let name: String
    let logo: String
    let description: String?
    let numberOfVacancies: Int

    enum CodingKeys: String, CodingKey {
        case id, name, logo, description
        case numberOfVacancies = "number_of_vacancies"
    }
}

