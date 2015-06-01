//
//  Usuario.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 01/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class Usuario: NSManagedObject {

    @NSManaged var bancoHoras: NSNumber
    @NSManaged var nome: String
    @NSManaged var nomeEmpresa: String
    @NSManaged var horaEntrada: NSDate
    @NSManaged var horaSaida: NSDate
    @NSManaged var horaSaidaAlmoco: NSDate
    @NSManaged var horasAlmoco: NSNumber
    @NSManaged var cargaHorariaSemanal: NSNumber
    @NSManaged var possuiDiaTrabalhado: NSSet
    @NSManaged var newRelationship: NSSet

}
