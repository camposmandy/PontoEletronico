//
//  Semana.swift
//  PontoEletronico
//
//  Created by João Marcos on 08/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

@objc(Semana)
class Semana: NSManagedObject {

    @NSManaged var nomeDIa: String
    @NSManaged var pertenceDiaTrabalhado: NSSet
    @NSManaged var pertenceUsuario: Usuario

    func adcDiaTrabalhado(diaTrabalhado: DiaTrabalhado) {
        var possuiDiaTrabalhado = self.mutableSetValueForKey("possuiDiaTrabalhado")
        possuiDiaTrabalhado.addObject(diaTrabalhado)
    }
    
    func removerDiaTrablhado(diaTrabalhado: DiaTrabalhado) {
        var removerDiaTrabalhado = self.mutableSetValueForKey("possuiDiaTrabalhado")
        removerDiaTrabalhado.removeObject(diaTrabalhado)
    }
}
