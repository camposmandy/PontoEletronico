//
//  PrincipalViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController {
    
    var usuario: Usuario?
    var diaTrabalhado: DiaTrabalhado?

    var tempoTotal = NSTimer()
    var tempoAlm = NSTimer()
    var inicioTempo = NSTimeInterval()
    var inicioTempoAlmoco = NSTimeInterval()
    var tempoDeAlmoco = NSTimeInterval()
    var tempoTrabalhado = NSTimeInterval()
    
    var horaEntrada = NSDate()
    var horaSaida = NSDate()
    var horaSaidaAlmoco = NSDate()
    var horaVoltaAlmoco = NSDate()
    
    var entradas = ["Entrada", "Saída Almoço", "Volta Almoço", "Saída"]
    var e = 0
    
    @IBOutlet weak var graficoUm: JMView!
    @IBOutlet weak var graficoDois: JMView!
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var tempoAlmoco: UILabel!
    @IBOutlet weak var entrada: UIButton!
    
    
    @IBAction func entrada(sender: AnyObject) {

        switch e {
        case 0:
            horaEntrada = NSDate()
            tempoTotal = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "atualizaTempoTotal", userInfo: nil, repeats: true)
            inicioTempo = horaEntrada.timeIntervalSinceReferenceDate
        case 1:
            horaSaidaAlmoco = NSDate()
            tempoTotal.invalidate()
            tempoAlm = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "atualizaTempoAlmoco", userInfo: nil, repeats: true)
            inicioTempoAlmoco = horaSaidaAlmoco.timeIntervalSinceReferenceDate
        case 2:
            horaVoltaAlmoco = NSDate()
            tempoAlm.invalidate()
            tempoTotal = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "atualizaTempoTotal", userInfo: nil, repeats: true)
            inicioTempo = horaEntrada.timeIntervalSinceReferenceDate - (horaSaidaAlmoco.timeIntervalSinceReferenceDate - horaVoltaAlmoco.timeIntervalSinceReferenceDate)
        case 3:
            horaSaida = NSDate()
            tempoTotal.invalidate()
            
            diaTrabalhado = DiaTrabalhadoManager.sharedInstance.novoDiaTrabalho()
            
            diaTrabalhado?.horaEntrada = horaEntrada
            diaTrabalhado?.horaSaidaAlmoco = horaSaidaAlmoco
            diaTrabalhado?.horaVoltaAlmoco = horaVoltaAlmoco
            diaTrabalhado?.horaSaida = horaSaida
//            diaTrabalhado?.tempoAlmoco = tempoDeAlmoco
//            diaTrabalhado?.totalHoras = tempoTrabalhado
            
            DiaTrabalhadoManager.sharedInstance.salvar()
            
            
            
            
            
            let alerta = UIAlertController(title: "Fim", message: "...", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            }
            
            alerta.addAction(ok)
            self.presentViewController(alerta, animated: true, completion: nil)
        default:
            break
        }

        if e != 3 {
            e++
        } else {
            e = 0
        }
        entrada.setTitle(entradas[e], forState: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verificaPrimeiroAcesso()
       
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func verificaPrimeiroAcesso() {
        var userDefault = NSUserDefaults()
        var acesso = userDefault.objectForKey("Acesso") as? String
        if acesso == nil {
            var domingo: Semana
            domingo = SemanaManager.sharedInstance.novaSemana()
            domingo.nomeDIa = "Domingo"
            SemanaManager.sharedInstance.salvar()
            
            var segunda: Semana
            segunda = SemanaManager.sharedInstance.novaSemana()
            segunda.nomeDIa = "Segunda"
            SemanaManager.sharedInstance.salvar()
            
            var terca: Semana
            terca = SemanaManager.sharedInstance.novaSemana()
            terca.nomeDIa = "Terça"
            SemanaManager.sharedInstance.salvar()
            
            var quarta: Semana
            quarta = SemanaManager.sharedInstance.novaSemana()
            quarta.nomeDIa = "Quarta"
            SemanaManager.sharedInstance.salvar()
            
            var quinta: Semana
            quinta = SemanaManager.sharedInstance.novaSemana()
            quinta.nomeDIa = "Quinta"
            SemanaManager.sharedInstance.salvar()
            
            var sexta: Semana
            sexta = SemanaManager.sharedInstance.novaSemana()
            sexta.nomeDIa = "Sexta"
            SemanaManager.sharedInstance.salvar()
            
            var sabado: Semana
            sabado = SemanaManager.sharedInstance.novaSemana()
            sabado.nomeDIa = "Sábado"
            SemanaManager.sharedInstance.salvar()
            
            let VCEdit = self.storyboard?.instantiateViewControllerWithIdentifier("editarView") as? EditarPerfilTableViewController
            VCEdit?.btnCancelar.enabled = false
            self.navigationController?.pushViewController(VCEdit!, animated: false)
            
            userDefault.setObject("JaAcessou", forKey: "Acesso")
        }
    }
    
    func atualizaTempoTotal(){
        var tempoAtual = NSDate.timeIntervalSinceReferenceDate() as NSTimeInterval
        tempoTrabalhado = tempoAtual - inicioTempo
        
        let horas = UInt8(tempoTrabalhado/3600.0)
        tempoTrabalhado -= (NSTimeInterval(horas)*3600)
        
        let minutos = UInt8(tempoTrabalhado/60.0)
        tempoTrabalhado -= (NSTimeInterval(minutos)*60)
        
        let segundos = UInt8(tempoTrabalhado)
        tempoTrabalhado -= NSTimeInterval(segundos)
        
        let fracao = UInt8(tempoTrabalhado*100)
        
        let strHoras = horas > 9 ? String(horas):"0" + String(horas)
        let strMinutos = minutos > 9 ? String(minutos):"0" + String(minutos)
        let strSegundos = segundos > 9 ? String(segundos): "0" + String(segundos)
        let strFracao = fracao > 9 ? String(fracao): "0" + String(fracao)
        
        tempoLabel.text = "\(strHoras):\(strMinutos):\(strSegundos):\(strFracao)"
    }
    
    func atualizaTempoAlmoco(){
        var tempoAtual = NSDate.timeIntervalSinceReferenceDate() as NSTimeInterval
        tempoDeAlmoco = tempoAtual - inicioTempoAlmoco
        
        let horas = UInt8(tempoDeAlmoco/3600.0)
        tempoDeAlmoco -= (NSTimeInterval(horas)*3600)
        
        let minutos = UInt8(tempoDeAlmoco/60.0)
        tempoDeAlmoco -= (NSTimeInterval(minutos)*60)
        
        let segundos = UInt8(tempoDeAlmoco)
        tempoDeAlmoco -= NSTimeInterval(segundos)
        
        let fracao = UInt8(tempoDeAlmoco*100)
        
        let strHoras = horas > 9 ? String(horas):"0" + String(horas)
        let strMinutos = minutos > 9 ? String(minutos):"0" + String(minutos)
        let strSegundos = segundos > 9 ? String(segundos): "0" + String(segundos)
        let strFracao = fracao > 9 ? String(fracao): "0" + String(fracao)
        
        tempoAlmoco.text = "\(strHoras):\(strMinutos):\(strSegundos):\(strFracao)"
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
