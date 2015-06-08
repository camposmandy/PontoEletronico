//
//  Usuario.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 08/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

@objc(Usuario)
class Usuario: NSManagedObject {

    @NSManaged var bancoHoras: NSNumber
    @NSManaged var cargaHorariaSemanal: NSNumber
    @NSManaged var horaEntrada: NSDate
    @NSManaged var horaSaida: NSDate
    @NSManaged var horaSaidaAlmoco: NSDate
    @NSManaged var horaVoltaAlmoco: NSDate
    @NSManaged var nome: String
    @NSManaged var nomeEmpresa: String
    @NSManaged var possuiDiaTrabalhado: NSSet
    @NSManaged var possuiSemana: NSSet

    func adcDiaTrabalhado(diaTrabalhado: DiaTrabalhado) {
        var possuiDiaTrabalhado = self.mutableSetValueForKey("possuiDiaTrabalhado")
        possuiDiaTrabalhado.addObject(diaTrabalhado)
    }
    
    func removerDiaTrabalhado(diaTrabalhado: DiaTrabalhado) {
        var removerDiaTrabalhado = self.mutableSetValueForKey("possuiDiaTrabalhado")
        removerDiaTrabalhado.removeObject(diaTrabalhado)
    }
    
    func adcSemana(semana: Semana) {
        var possuiSemana = self.mutableSetValueForKey("possuiSemana")
        possuiSemana.addObject(semana)
    }
    
    func removerSemana(semana: Semana) {
        var removerSemana = self.mutableSetValueForKey("possuiSemana")
        removerSemana.removeObject(semana)
    }
}
