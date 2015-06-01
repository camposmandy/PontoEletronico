//
//  Semana.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 01/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class Semana: NSManagedObject {

    @NSManaged var nomeDIa: String
    @NSManaged var newRelationship: NSSet
    @NSManaged var newRelationship1: NSSet
}