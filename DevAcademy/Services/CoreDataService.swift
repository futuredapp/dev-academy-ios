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
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DevAcademyModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        container.viewContext.retainsRegisteredObjects = true
        return container
    }()

    func loadNote(forPlace ogcFid: Int) -> String? {
        let request = NSFetchRequest<Note>(entityName: String(describing: Note.self))
        request.predicate = NSPredicate(format: "self.ogcFid == %d", ogcFid)
        request.returnsObjectsAsFaults = false

        let result = persistentContainer.viewContext.performAndWait {
            try? persistentContainer.viewContext.fetch(request)
        }

        return result?.first?.note
    }

    func save(note: String?, forPlace ogcFid: Int) {
        persistentContainer.viewContext.perform {
            let request = NSFetchRequest<Note>(entityName: String(describing: Note.self))
            request.predicate = NSPredicate(format: "self.ogcFid == %d", ogcFid)
            request.returnsObjectsAsFaults = false

            let result = self.persistentContainer.viewContext.performAndWait {
                try? self.persistentContainer.viewContext.fetch(request)
            }
            
            let managedObject = result?.first ?? Note(context: self.persistentContainer.viewContext)
            managedObject.ogcFid = Int64(ogcFid)
            managedObject.note = note
            try? self.persistentContainer.viewContext.save()
        }
    }
}

final class MockCoreDataService: CoreDataService {
    func loadNote(forPlace ogcFid: Int) -> String? { nil }
    func save(note: String?, forPlace ogcFid: Int) { }
}
