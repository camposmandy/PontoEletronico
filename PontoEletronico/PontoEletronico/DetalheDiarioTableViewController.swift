//
//  DetalheDiarioTableViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit


class DetalheDiarioTableViewController: UITableViewController {
    
    @IBOutlet weak var diaTrabalhado: UILabel!
    @IBOutlet weak var horaEntrada: UILabel!
    @IBOutlet weak var horaSaida: UILabel!
    @IBOutlet weak var horaSaidaAlmoco: UILabel!
    @IBOutlet weak var horaVoltaAlmoco: UILabel!
    @IBOutlet weak var creditoLbl: UILabel!
    
    var diaTrab : DiaTrabalhado!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preencherLabels()

    }
    
    func preencherLabels(){
        diaTrabalhado.text = "\(diaTrab.horaEntrada)"
        horaEntrada.text = "\(diaTrab.horaEntrada)"
        horaSaida.text = "\(diaTrab.horaEntrada)"
        horaSaidaAlmoco.text = "\(diaTrab.horaEntrada)"
        horaVoltaAlmoco.text = "\(diaTrab.horaEntrada)"
        creditoLbl.text = "\(diaTrab.horaEntrada)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
