//
//  DiaTrabalhado.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

@objc
class DiaTrabalhado: NSManagedObject {

    @NSManaged var horaEntrada: NSDate
    @NSManaged var horaSaida: NSDate
    @NSManaged var horaSaidaAlmoco: NSDate
    @NSManaged var horaVoltaAlmoco: NSDate
    @NSManaged var totalHoras: NSNumber
    @NSManaged var pertenceUsuario: Usuario
    @NSManaged var possuiSemana: NSSet

}
