// Model.swift
// coreDataTest
// Created by ALLENIC Aurélien on 15/10/2024.

import Foundation

struct Model{
    var goodUsername: String = "aurelien"
    var goodPassword: String = "testpassword"
    
    // Fonction pour vérifier le mot de passe
    func checkPassword(username: String, password: String) -> Bool {
        return username == goodUsername && password == goodPassword
    }
}
