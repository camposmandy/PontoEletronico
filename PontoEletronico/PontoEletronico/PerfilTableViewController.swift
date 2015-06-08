//
//  PerfilTableViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class PerfilTableViewController: UITableViewController {

    var usuario : Array<Usuario>!
    var i = 0
    
    @IBOutlet weak var nomeEmpresa: UILabel!
    @IBOutlet weak var nomeUsuario: UILabel!
    @IBOutlet weak var cargaHoraria: UILabel!
    @IBOutlet weak var horarioVoltaAlmoco: UILabel!
    @IBOutlet weak var horarioSaidaAlmoco: UILabel!
    @IBOutlet weak var horarioSaida: UILabel!
    @IBOutlet weak var horarioEntrada: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preencherLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func preencherLabels(){
   usuario = UsuarioManager.sharedInstance.Usuario()
    
    var horario = NSDateFormatter()
        horario.dateFormat = "HH:mm"
    
    horarioVoltaAlmoco.text = horario.stringFromDate(usuario[i].horaVoltaAlmoco)
    horarioSaidaAlmoco.text = horario.stringFromDate(usuario[i].horaSaidaAlmoco)
    horarioSaida.text = horario.stringFromDate(usuario[i].horaSaida)
    horarioEntrada.text = horario.stringFromDate(usuario[i].horaEntrada)
    nomeUsuario.text = usuario[i].nome
    nomeEmpresa.text = usuario[i].nomeEmpresa
    cargaHoraria.text = "\(usuario[i].cargaHorariaSemanal)"
   
    }
  }
