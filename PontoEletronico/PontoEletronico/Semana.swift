//
//  Semana.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

@objc
class Semana: NSManagedObject {

    @NSManaged var nomeDIa: String
    @NSManaged var pertenceDiaTrabalhado: NSSet
    @NSManaged var pertenceUsuario: NSSet

}
