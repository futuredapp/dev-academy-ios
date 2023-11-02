//
//  CoreDataService.swift
//  DevAcademy
//
//  Created by Mikoláš Stuchlík on 02.11.2023.
//

import CoreData

protocol CoreDataService {
    func loadNote(forPlace ogcFid: Int) -> String?
    func save(note: String?, forPlace ogcFid: Int)
}

final class ProductionsCoreDataService: NSObject, CoreDataService {
    func loadNote(forPlace ogcFid: Int) -> String? {
        nil
    }

    func save(note: String?, forPlace ogcFid: Int) {
    }
}

final class MockCoreDataService: CoreDataService {
    func loadNote(forPlace ogcFid: Int) -> String? { nil }
    func save(note: String?, forPlace ogcFid: Int) { }
}
