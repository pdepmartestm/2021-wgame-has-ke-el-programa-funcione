import pesca.*
import wollok.game.*

class ObjetosFlotantes {
	
    var property sePesco = false
    


	const vertical = (0..alturaAgua).anyOne()
	
	const horizontal = [20,-1].anyOne()
	
	const posicionInicial  = game.at(horizontal,vertical)
	
	var property estaDerecha = !(horizontal == -1)
	
	
	var property position = posicionInicial
	
    method fuePescado() {
    	sePesco = true
    }

	method movete() {
        if (position.x() == -2 or position.x() == 21){
        		
        	if (!sePesco) {game.removeVisual(self)}
          
        }
        else
        {
        	self.moverPosicion()
		    game.schedule(self.velocidadMov(),{self.movete()})
        	
        }
		
		
	}
	
	method moverPosicion() {
		
		if (estaDerecha){
			position = position.left(1) 
		}
		else
		{
			position = position.right(1) 
		}
		
		
	}
	
  	method velocidadMov() = 1000
 	
 	
	

}





class Pez inherits ObjetosFlotantes {
	
	
	 method image() {
	 	return if (estaDerecha) "assets/pezDer.png" else "assets/pezIzq.png"
	}
	
	method ansuPesco() {
		
	    ansu.cambiarImagen("Pez")
	 	game.removeVisual(self)
	 	
	}
	

	
}





class Basura inherits ObjetosFlotantes {
	
	const basuras = ["zapato","barril","botella"]
	
	const objeto = basuras.anyOne()
	
	method image() {
	 	return  "assets/" + objeto + ".png"}
	 	
	 	
	 method ansuPesco() {
	 	
	game.removeVisual(self)
	contadorVida.sacarVida(1)
	
} 

override method velocidadMov() = 1500	
	 
}






class Medusa inherits ObjetosFlotantes {
	
	
	//fijar despues cuanto tiempo quieren paralizar
	const cantidadParalizar = 1500
	
	method image() {return if (estaDerecha) "assets/meduzaDer.png" else "assets/meduzaIzq.png"}
	
	method ansuPesco(){
		
		persona.cambiarImagen()
		ansu.cambiarImagen("cañaElectrocutada")
		persona.electrucutado()
	    game.removeVisual(self)
		game.schedule(cantidadParalizar,{ansu.sacarElec() persona.volverNormalidad() persona.electrucutado() })
		

	}
	
	override method velocidadMov() = 500
}

class Gusano inherits ObjetosFlotantes {
	
	var property image = "assets/lataDeGusanos.png"
	
	method ansuPesco() {
		
		game.removeVisual(self)
		contadorVida.agregarVida()
	}
	
	override method velocidadMov() = 250
	
}


class Tiburon inherits ObjetosFlotantes {
	
	 method image() {
	 	return if (estaDerecha) "assets/tiburonIzq.png" else "assets/tiburonDer.png"
	}
	
	method ansuPesco() {
		game.removeVisual(self)
		contadorVida.sacarVida(3)
	}
	
	override method velocidadMov() = 250
	
}
