class Famiglia {

	const miembros = #{}

	method tieneUnSoloDon() {
		return self.miembrosQueSonDe("don").size() == 1
	}
	method miembrosQueSonDe(rango){
		return miembros.filter({ m => m.rango() == rango })
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
		subordinados = famiglia.miembrosQueSonDe("don").negate()
	}

	override method haceSuTrabajo(alguien) {
		self.subordinados().any({ s => s.haceSuTrabajo(alguien)})
	}

}

class Subjefe inherits Miembro {

	var ultimaArmaQueUso
	var subordinados
	method ultimaArmaQueUso(algo){
		ultimaArmaQueUso = algo
	}
	method seHaceSubjefe() {
		subordinados = famiglia.miembrosQueSonDe("soldado")
		rango = "subjefe"
	}

	override method haceSuTrabajo(alguien) {
		const unArma = armas.filter({ a => a != ultimaArmaQueUso}).head()
		unArma.usar()
		ultimaArmaQueUso = unArma
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

