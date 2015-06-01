//
//  DiaTrabalhadoManager.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 01/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class DiaSemanaManager {
    
    static let sharedInstance = DiaTrabalhadoManager()
    static let entidadeNome = "DiasTrabalho"
    
    let coreData = CoreDataPersistencia.sharedInstance
    
    private init(){}
    
    func novoDiaTrabalho() -> PontoEletronico.DiasTrabalho {
        return NSEntityDescription.insertNewObjectForEntityForName(DiaTrabalhadoManager.entidadeNome, inManagedObjectContext: coreData.managedObjectContext!) as! PontoEletronico.DiasTrabalho
    }
    
    func DiasTrabalho() -> Array<PontoEletronico.DiasTrabalho>? {
        return coreData.fetchData(DiaTrabalhadoManager.entidadeNome, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<PontoEletronico.DiasTrabalho>
    }
    
    func DiasTrabalho(predicate: NSPredicate) -> Array<PontoEletronico.DiasTrabalho>?{
        return coreData.fetchData(DiaTrabalhadoManager.entidadeNome, predicate: predicate) as? Array <PontoEletronico.DiasTrabalho>
    }
    
    func salvar() {
        coreData.saveContext()
    }
    
    func deletar(semana: PontoEletronico.DiasTrabalho) {
        coreData.managedObjectContext?.deleteObject(semana)
    }
}