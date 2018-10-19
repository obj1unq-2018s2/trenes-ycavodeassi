
class Vagon {

	method pesoMaximo()
	method cantidadPasajeros() = 0
	method cantidadBanios() = 0
	method esLiviano() = self.pesoMaximo() < 2500
}

class VagonDePasajeros inherits Vagon {
	var metrosLargo //mts
	var metrosAncho //mts
	var cantBanios  //num
	
	override method cantidadPasajeros() = if (metrosAncho <= 2.5) metrosLargo*8 else metrosLargo*10
	
	override method cantidadBanios() = cantBanios
	
	override method pesoMaximo() = self.cantidadPasajeros()*80	
	
}

class VagonDeCarga inherits Vagon {
	var cargaMaxima //kgs
	
	override method pesoMaximo() = cargaMaxima+160
}

