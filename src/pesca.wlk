import wollok.game.*

//persona: puntaje, tiempo, vida, 


//peces u objetos que den o quiten vida
const objetoFlotante = new ObjetosFlotantes()

object pantalla {
	
	method iniciar() {
		game.title()
		game.height()
		game.width()
		game.addVisual()
		game.boardGround()
	
        keyboard.up().onPressDo({})
        keyboard.down().onPressDo({})

        game.onCollideDo()
        
        game.onTick(1000,"sale objeto por derecha", objetoFlotante.aparecerObjetoDerecha())
        game.onTick(1000,"sale objeto por izquierda", objetoFlotante.aparecerObjetoIzquierda())
        
        game.start()
	}
	
	}


object persona {
	
	var vida = 100
	var puntaje = 0
	var tiempo
	
	method image() {return "assets/persona.png"}
}




object heladeraConPeces {
	
	var property capacidad = 0
	
	method image() {
		
		return "assets/heladera" + self.capacidad() + ".png"
	}
	
	method pesco() {
		capacidad = capacidad + 1
	}
}
	
//que los objetosFlotantes siempre vayan en linea recta
//que empiecen desde la izquierda o derecha
//que desaparezca el objeto una vez que se vaya de la pantalla 
//que desaparezca si choca
//que se mantenga en el recuadro


class ObjetosFlotantes {
	
	
	method movimiento() {

		
	}
	
	method aparecerObjetoIzquierda() {
		
	}
	
	method aparecerObjetoDerecha() {
		
	}
	
}

object pez inherits ObjetosFlotantes {
	
	
	
	method image() {
		// por derecha es una imagen por izquierda otra
		
	}
}

class Basura inherits ObjetosFlotantes {
	
	
	
}

class Villanos inherits ObjetosFlotantes {
	
}

object cania {
	
	
}