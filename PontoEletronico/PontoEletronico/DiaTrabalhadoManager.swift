//
//  DiaTrabalhadoManager.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 01/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class DiaTrabalhadoManager {
    
    static let sharedInstance = DiaTrabalhadoManager()
    static let entidadeNome = "DiaTrabalhado"
    
    let coreData = CoreDataPersistencia.sharedInstance
    
    private init(){}
    
    func novoDiaTrabalho() -> PontoEletronico.DiaTrabalhado {
        return NSEntityDescription.insertNewObjectForEntityForName(DiaTrabalhadoManager.entidadeNome, inManagedObjectContext: coreData.managedObjectContext!) as! PontoEletronico.DiaTrabalhado
    }
    
    func DiasTrabalho() -> Array<PontoEletronico.DiaTrabalhado>? {
        return coreData.fetchData(DiaTrabalhadoManager.entidadeNome, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<PontoEletronico.DiaTrabalhado>
    }
    
    func DiasTrabalho(predicate: NSPredicate) -> Array<PontoEletronico.DiaTrabalhado>?{
        return coreData.fetchData(DiaTrabalhadoManager.entidadeNome, predicate: predicate) as? Array <PontoEletronico.DiaTrabalhado>
    }
    
    func salvar() {
        coreData.saveContext()
    }
    
    func deletar(semana: PontoEletronico.DiaTrabalhado) {
        coreData.managedObjectContext?.deleteObject(semana)
    }
}