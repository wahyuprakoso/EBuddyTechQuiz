//
//  User.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 02/01/25.
//

enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}

struct User: Identifiable, Codable {
    var id: String? { uid }
    var uid: String?
    var email: String?
    var phoneNumber: String?
    var gender: GenderEnum?
}
