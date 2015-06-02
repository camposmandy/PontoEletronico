//
//  UsuarioManager.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 01/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class UsuarioManager {
    static let sharedInstance = UsuarioManager()
    static let entidadeNome = "Usuario"
    
    let coreData = CoreDataPersistencia.sharedInstance
    
    private init(){}
    
    func novoUsuario() -> PontoEletronico.Usuario {
        return NSEntityDescription.insertNewObjectForEntityForName(UsuarioManager.entidadeNome, inManagedObjectContext: coreData.managedObjectContext!) as! PontoEletronico.Usuario
    }
    
    func Usuario() -> Array<PontoEletronico.Usuario>? {
        return coreData.fetchData(UsuarioManager.entidadeNome, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<PontoEletronico.Usuario>
    }
    
    func Usuario(predicate: NSPredicate) -> Array<PontoEletronico.Usuario>?{
        return coreData.fetchData(UsuarioManager.entidadeNome, predicate: predicate) as? Array <PontoEletronico.Usuario>
    }
    
    func salvar() {
        coreData.saveContext()
    }
    
    func deletar(materia: PontoEletronico.Usuario) {
        coreData.managedObjectContext?.deleteObject(materia)
    }
    
    func deletarTudo() {
        let todosObjetos: Array<PontoEletronico.Usuario> = self.Usuario()!
        
        for item : PontoEletronico.Usuario in todosObjetos as Array<PontoEletronico.Usuario> {
            self.deletar(item)
        }
    }
}
