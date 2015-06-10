//
//  DiaTrabalhado.swift
//  PontoEletronico
//
//  Created by João Marcos on 10/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

@objc(DiaTrabalhado)
class DiaTrabalhado: NSManagedObject {

    @NSManaged var horaEntrada: NSDate
    @NSManaged var horaSaida: NSDate
    @NSManaged var horaSaidaAlmoco: NSDate
    @NSManaged var horaVoltaAlmoco: NSDate
    @NSManaged var tempoAlmoco: NSNumber
    @NSManaged var totalHoras: NSNumber
    @NSManaged var pertenceUsuario: Usuario
    @NSManaged var possuiSemana: NSSet

    func adcSemana(semana: Semana) {
        var possuiSemana = self.mutableSetValueForKey("possuiSemana")
        possuiSemana.addObject(semana)
    }
    
    func removerSemana(semana: Semana) {
        var removerSemana = self.mutableSetValueForKey("possuiSemana")
        removerSemana.removeObject(semana)
    }
}
