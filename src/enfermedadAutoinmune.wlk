class Famiglia {

	const miembros = #{}

	method tieneUnSoloDon() {
		return miembros.filter({ m => m.rango() == "don" }).size() == 1
	}

}

class Miembro {

	const famiglia
	var rango
	const armas = #{}
	var lealtad
	var estado

	method rango(algo) {
		return algo
	}

	method esHerido() {
		estado = "herido"
	}

	method estaHerido() {
		return estado == "herido"
	}

	method esAsesinado() {
		estado = "muerto"
	}

	method haceSuTrabajo(alguien)

}

class Don inherits Miembro {

	var property subordinados

	method seHaceDon() {
		rango = "don"
		subordinados = famiglia.miembros().filter({ m => m.rango() != "don" })
	}

	override method haceSuTrabajo(alguien) {
		self.subordinados().any({ s => s.haceSuTrabajo(alguien)})
	}

}

class Subjefe inherits Miembro {

	var ultimaArmaQueUso
	var subordinados

	method seHaceSubjefe() {
		subordinados = famiglia.miembros().filter({ m => m.rango() == "soldado" })
		rango = "subjefe"
	}

	override method haceSuTrabajo(alguien) {
		armas.filter({ a => a != ultimaArmaQueUso}).any({ a =>
			a.usar()
			ultimaArmaQueUso = a
		})
	}

}

class Soldado inherits Miembro {

	method seHaceSoldado() {
		self.agregarArma(new Escopeta())
	}

	method agregarArma(arma) {
		armas.add(arma)
	}

	override method haceSuTrabajo(alguien) {
		armas.head().usar()
	}

}

class Revolver {

	var balas

	method recargar() {
	}

	method usar(alguien) {
		if (balas >= 1) {
			alguien.esAsesinado()
		}
	}

}

class Escopeta {

	method usar(alguien) {
		if (alguien.estaHerido()) {
			alguien.esAsesinado()
		} else alguien.esHerido()
	}

}

class cuerdaDePiano {

	var calidad

	method usar(alguien) {
		if (calidad == "buena") {
			alguien.esAsesinado()
		}
	}

}

