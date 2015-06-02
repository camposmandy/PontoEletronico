//
//  SemanaManager.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 01/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class SemanaManager {
    static let sharedInstance = SemanaManager()
    static let entidadeNome = "Semana"
    
    let coreData = CoreDataPersistencia.sharedInstance
    
    private init(){}
    
    func novaSemana() -> PontoEletronico.Semana {
        return NSEntityDescription.insertNewObjectForEntityForName(SemanaManager.entidadeNome, inManagedObjectContext: coreData.managedObjectContext!) as! PontoEletronico.Semana
    }
    
    func Semana() -> Array<PontoEletronico.Semana>? {
        return coreData.fetchData(SemanaManager.entidadeNome, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<PontoEletronico.Semana>
    }
    
    func Semana(predicate: NSPredicate) -> Array<PontoEletronico.Semana>?{
        return coreData.fetchData(SemanaManager.entidadeNome, predicate: predicate) as? Array <PontoEletronico.Semana>
    }
    
    func salvar() {
        coreData.saveContext()
    }
    
    func deletar(semana: PontoEletronico.Semana) {
        coreData.managedObjectContext?.deleteObject(semana)
    }
    
    func deletarTudo() {
        let todosObjetos: Array<PontoEletronico.Semana> = self.Semana()!
        
        for item : PontoEletronico.Semana in todosObjetos as Array<PontoEletronico.Semana> {
            self.deletar(item)
        }
    }
}