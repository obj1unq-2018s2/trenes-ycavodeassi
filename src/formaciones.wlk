import locomotoras.*
import vagones.*

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
	
	method formacionBienArmada() = self.puedeMoverse()
}

//el metodo lookup empieza en la clase de la que es instancia el receptor.
//super() arranca en la superclase. De donde esta escrita la palabra super()... Rompe la regla method lookup
//self dinamico && super estatico

class FormacionCortaDistancia inherits Formacion {
	
	override method formacionBienArmada() = super() && not self.esCompleja()
	
	method limiteVelocidad() = 60 //kms
	
	override method velocidadMaxima() = self.limiteVelocidad().min(super()) 
	
}

class FormacionLargaDistancia inherits Formacion {
	var property uneDosCiudadesGrandes = true
	
	override method formacionBienArmada() = super() && (self.cantidadPasajeros() / 50) <= self.cantidadBanios()

	method limiteVelocidad() = if (self.uneDosCiudadesGrandes()) 200 else 150 //kms
	
	override method velocidadMaxima() = self.limiteVelocidad().min(super())

}

class FormacionAltaVelocidad inherits FormacionLargaDistancia {
	
	override method limiteVelocidad() = 400
	
	override method formacionBienArmada() = super() && self.velocidadMaxima()>250 && self.cantidadVagones()==self.vagonesLivianos()
}