import wollok.game.*

//persona: puntaje, tiempo, vida, 


//peces u objetos que den o quiten vida






const ancho = 20 //12
const alto = 15 //6
const alturaAgua = 9 //4

const fondoIniciar = new Visual(
	image =  "assets/fondoInicio.jpg",
	position = game.at(0,0)
	)
	
const fondoCerrar = new Visual (
	image = "assets/fondoCierre.jpg",
	position = game.at(0,0)
)

object pantalla{
	
	
	method pantallaInicio() {
		
		game.title("club de la pesca")
		game.width(ancho)
		game.height(alto)
		game.addVisual(fondoIniciar)
//		game.boardGround("assets/pantallaInicio.png")
	    game.boardGround("assets/fondo1.png")
		keyboard.enter().onPressDo{self.iniciar()}
	}	
	
	
	
	
	method iniciar(){
		
	    game.clear()
	    
		game.height(alto)
		game.width(ancho)
 
		game.boardGround("assets/fondo1.png")
		game.addVisual(heladeraConPeces)
		game.addVisual(contadorVida)


// ver que cantidad de tiempo se quiere para cada uno
		
 		game.onTick(5000,"se crea pez", {const pez = new Pez()
        	                             game.addVisual(pez)
        	                             pez.movete()
        })

 		game.onTick(5000,"se crea basura", {const basura = new Basura()
        	                             game.addVisual(basura)
        	                             basura.movete()
        })
        
        game.onTick(5000,"se crea medusa", {const medusa = new Medusa()
        	                             game.addVisual(medusa)
        	                             medusa.movete()
        })
        
        game.onTick(5000,"se crea tiburon", {const tiburon = new Tiburon()
        	                             game.addVisual(tiburon)
        	                             tiburon.movete()
        })
        
        game.onTick(5000,"se crea lata de gusanos", {const lataGusanos = new Gusano()
        	                             game.addVisual(lataGusanos)
        	                             lataGusanos.movete()
        })
        
			
		game.addVisual(persona)
		game.addVisual(ansu)
		keyboard.up().onPressDo({ansu.moverseArriba()})
        keyboard.down().onPressDo({ansu.moverseAbajo()})
        
        game.onCollideDo(ansu,{algo => algo.ansuPesco()})
 		

 		
 	}
 	}


object persona {
	
	var property puntaje = 0
	var property tiempo = 0
	
	var property estaParalizado = false
	
	var property position = game.at(8.15,10.99999455)
	
	var property image = "assets/pinguino.png"
	


	method cambiarImagen() {
		image = "assets/pinguinoElectrocutado2.png"
	}
	method volverNormalidad() {
		image = "assets/pinguino.png" 
	}
	

	method electrucutado() {
		
		if (estaParalizado)
		{
			estaParalizado = false
		}
		else
		{
			estaParalizado = true
		}
		
	}
	method perdio() {
		
		return contadorVida.vidas() <= 0 
	}
}

object contadorVida {
	
	var property vidas = 3
	
	var property image = "assets/contVidas3.png"
	
	var property position = game.at(1,13)
	
	
	method sacarVida(cant) {
		
		vidas = vidas - cant
		image = "assets/contVidas"+ vidas + ".png"
		
		if (persona.perdio()){
	       game.clear()
           game.addVisual(fondoCerrar)
		   game.schedule(1000,{heladeraConPeces.agregarFinal()})
		   //poner contador de peces hasta donde llego
	       //sacar todo y poner imagen diciendo que perdio
		}
		
	}
	
		method agregarVida() {
			
		if (vidas < 3){
			
			vidas = vidas + 1
			image = "assets/contVidas"+ vidas + ".png"
		}
		
	}
}


object heladeraConPeces {
	
	var property position = game.at(5,11)
	
	var property capacidad = 0
	
	method image() {
		
		return "assets/pez" + self.capacidad() + ".png"
	}
	
	method pesco() {
		capacidad = capacidad + 1
	}
	
	method aumentarCantidad() {
		capacidad += 1
	}
	method agregarFinal() {
		
		position = game.at(12,1)
		game.addVisual(self)
		
		
	}
}
	



class ObjetosFlotantes {

	const vertical = (0..alturaAgua).anyOne()
	
	const horizontal = [20,-1].anyOne()
	
	const posicionInicial  = game.at(horizontal,vertical)
	
	var property estaDerecha = !(horizontal == -1)
	
	
	var property position = posicionInicial
	


	method movete() {
        if (position.x() == -2 or position.x() == 21){
        	
          game.removeVisual(self)
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
 	
 	method movimientoMov() = "se mueve"
 	
	method movimientoArranque() = "comienza a moverse"
	

}





class Pez inherits ObjetosFlotantes {
	

	
	 method image() {
	 	return if (estaDerecha) "assets/pezDer.png" else "assets/pezIzq.png"
	}
	
	method ansuPesco() {
		
	    ansu.cambiarImagen("Pez")
	 	game.removeVisual(self)
	 	
	}
	
//	override method velocidadMov() = 1000
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
	 
}






class Medusa inherits ObjetosFlotantes {
	
	
	//fijar despues cuanto tiempo quieren paralizar
	const cantidadParalizar = 2500
	
	method image() {return if (estaDerecha) "assets/meduzaDer.png" else "assets/meduzaIzq.png"}
	
	method ansuPesco(){
		
		persona.cambiarImagen()
		ansu.cambiarImagen("cañaElectrocutada")
		persona.electrucutado()
	    game.removeVisual(self)
		game.schedule(cantidadParalizar,{ansu.sacarElec() persona.volverNormalidad() persona.electrucutado() })
		

	}
}

class Gusano inherits ObjetosFlotantes {
	
	var property image = "assets/lataDeGusanos.png"
	
	method ansuPesco() {
		
		game.removeVisual(self)
		contadorVida.agregarVida()
	}
	
}


class Tiburon inherits ObjetosFlotantes {
	
	 method image() {
	 	return if (estaDerecha) "assets/tiburonIzq.png" else "assets/tiburonDer.png"
	}
	
	method ansuPesco() {
		game.removeVisual(self)
		contadorVida.sacarVida(3)
	}
	
}

object ansu {
	
	var property position = game.at(9,alturaAgua)
	
	var property caniaElec = false
	
	var property image = "assets/ansu.png"
	
	var property cont = 0
	
	
	
	method arribaMaximo() {
		
	return cont < 0
	}
	
	
	method moverseArriba() {
		
		if (!persona.estaParalizado())	
	{
			
		if ( self.arribaMaximo() ) {
		position = position.up(1)
		cont += 1 
		}
		else
		{
			self.hayUnPescado()
		}
		
	}
	
}
	method moverseAbajo() {
		
		if (!persona.estaParalizado())
		
		{
		position = position.down(1)
		const nuevo = new Hilo(position = position.up(1))
		game.addVisual(nuevo)
		cont -= 1
		
		}
	}
	
 	method hayUnPescado() {		
		if (self.image() == "assets/ansuConPez.png")
		{
			image = "assets/ansu.png"
			heladeraConPeces.aumentarCantidad()
		}
		
		
	}
	

	method cambiarImagen(cosa) {
		if (cosa == "cañaElectrocutada")
		{
			caniaElec = true
		}
		else
		{
		  image =  "assets/ansuCon" + cosa +  ".png"
		}

		
	}
	method sacarElec() {
		caniaElec = false
	}
	
	
}

class Hilo {

	var property position
	
	var image = "assets/hilo.png"
	
	method image() {
		
		if (ansu.caniaElec()){
			 image = "assets/canaElectrocutada.png"
		}
		else
		{
			image = "assets/hilo.png"
		}
		
      return image
	}
	
	method ansuPesco() {
		
				game.removeVisual(self)
			
	}
}

class Visual {
	var property image
	var property position = game.origin()
}


