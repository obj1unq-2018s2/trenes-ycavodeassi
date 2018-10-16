class Deposito {
	const formaciones 		 = #{}
	const locomotorasSueltas = #{}
	var   locomotoraSueltaUtil = null
	
	method agregarFormacion(formacion) { formaciones.add(formacion) }
	
	method eliminarFormacion(formacion) { formaciones.remove(formacion)} 
	
	method agregarLocomotoraSueltaAFormacionSi(formacion) { 
		if (not formacion.puedeMoverse() && self.hayLocomotoraSueltaUtil(formacion)) {
			locomotoraSueltaUtil = self.obtenerLocomotoraSueltaUtil(formacion) //Me guardo la locomotora para luego borrarla
			formacion.agregarLocomotora(locomotoraSueltaUtil) //Agrego la locomotora a una formacion
			locomotorasSueltas.remove(locomotoraSueltaUtil) //Borro la locomotora, ya no esta mas suelta.
		}
	}
	
	method hayLocomotoraSuelta() = not locomotorasSueltas.isEmpty()
	
	method hayLocomotoraSueltaUtil(formacion) = locomotorasSueltas.any{ locomotora => locomotora.esLocomotoraUtil(formacion) }
	
	method obtenerLocomotoraSueltaUtil(formacion) = locomotorasSueltas.find{ locomotora => locomotora.esLocomotoraUtil(formacion) }
		
	method vagonesMasPesados() = formaciones.map{ formacion => formacion.vagonMasPesado() }.asSet()
	
	method necesitaConductorExperimentado() = formaciones.any{ formacion => formacion.esCompleja() }
}

class Formacion {
	const locomotoras = #{}
	const vagones     = #{}

	method agregarLocomotora(locomotora) { locomotoras.add(locomotora) }
	
	method agregarVagon(vagon) { vagones.add(vagon) }
	
	method vagonesLivianos() = vagones.count{ vagon => vagon.esLiviano() }
	
	method velocidadMaxima() = if (locomotoras.isEmpty()) 0 else self.locomotoraMasLenta().velocidadMaxima()
	
	method locomotoraMasLenta() = locomotoras.min{ locomotora => locomotora.velocidadMaxima() }
	
	method esEficiente() = locomotoras.all{ locomotora => locomotora.arrastreUtil() >= locomotora.peso()*5 }
	
	method puedeMoverse() = self.arrastreUtilLocomotoras() >= self.pesoTotalVagones()
	
	method arrastreUtilLocomotoras() = locomotoras.sum{ locomotora => locomotora.arrastreUtil() }
	
	method peso() = self.pesoTotalVagones() + self.pesoTotalLocomotoras()
	
	method pesoTotalVagones() = vagones.sum{ vagon => vagon.pesoMaximo() }
	
	method pesoTotalLocomotoras() = locomotoras.sum{ locomotora => locomotora.peso() }
	
	method kgEmpujeRestantesParaMoverse() = if (self.puedeMoverse()) 0 else self.kgEmpujeRestantes()
	
	method kgEmpujeRestantes() = self.pesoTotalVagones() - self.arrastreUtilLocomotoras()
	
	method vagonMasPesado() = vagones.max({ vagon => vagon.pesoMaximo() }) 
	
	method esCompleja() = self.cantidadUnidades() > 20 || self.peso() > 10000
	
	method cantidadLocomotoras() = locomotoras.size()
	
	method cantidadVagones() = vagones.size()
	
	method cantidadUnidades() = self.cantidadLocomotoras() + self.cantidadVagones()
	
	method cantidadBanios() = vagones.sum{ vagon => vagon.cantidadBanios() }
	
	method cantidadPasajeros() = vagones.sum{ vagon => vagon.cantidadPasajeros() }
}


class FormacionCortaDistancia inherits Formacion {
	
	method formacionBienArmada() = self.puedeMoverse() && not self.esCompleja()
	
	method limiteVelocidad() = 60 //kms 
	
	override method velocidadMaxima() = self.limiteVelocidad().min(self.velocidadMaxima()) //Consultar
	
}

class FormacionLargaDistancia inherits Formacion {
	var property uneDosCiudadesGrandes = true
	
	method formacionBienArmada() = (self.cantidadPasajeros() / 50) <= self.cantidadBanios()

	method limiteVelocidad() = if (self.uneDosCiudadesGrandes()) 200 else 150 //kms
	
	override method velocidadMaxima() = self.limiteVelocidad().min(self.velocidadMaxima()) //Consultar

}

class FormacionAltaVelocidad inherits FormacionLargaDistancia {
	
	override method formacionBienArmada() = self.velocidadMaxima()>250 && self.cantidadVagones()==self.vagonesLivianos()
}

class Locomotora {
	var peso 			//kgs
	var pesoMaximo 		//kgs
	var velocidadMaxima //kms
	
	method arrastreUtil() =  pesoMaximo-peso
	
	method peso() = peso
	
	method velocidadMaxima() = velocidadMaxima
	
	method esLocomotoraUtil(formacion) = self.arrastreUtil() >= formacion.kgEmpujeRestantes()
}

class VagonDePasajeros {
	var metrosLargo //mts
	var metrosAncho //mts
	var cantBanios  //num
	
	method cantidadPasajeros() = if (metrosAncho <= 2.5) metrosLargo*8 else metrosLargo*10
	
	method pesoMaximo() = self.cantidadPasajeros()*80
	
	method esLiviano() = self.pesoMaximo() < 2500
	
	method cantidadBanios() = cantBanios
}

class VagonDeCarga {
	var cargaMaxima //kgs
	
	method cantidadPasajeros() = 0
	
	method pesoMaximo() = cargaMaxima+160
	
	method esLiviano() = self.pesoMaximo() < 2500
	
	method cantidadBanios() = 0
}





