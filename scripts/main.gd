extends Node2D

var map_path = "res://data/mapa/mapa.tres"
var mapa:Mapa = load(map_path)
var mapa_buffer = Mapa.new()
var play = false

@export var tamañoMapa = Vector2i(17,17) #120 65 max space 

func _ready():
	for x in range(tamañoMapa[0]):
		for y in range(tamañoMapa[1]):
			colocarFichaEnTablero(Vector2i(x,y))
			
	#for llave in mapa.espacios.keys():
		#colocarFichaEnTablero(llave)

func colocarFichaEnTablero(coordenadas):
	# Obtener el tile ID en la posición
	var tablero : TileMapLayer = $Tablero
	
	# Asignar el material al TileSet
	var tile 
	
	if mapa.get_contenido_espacio(coordenadas):
		tile = Vector2i(0,0)
	else:
		tile = Vector2i(1,0)

	tablero.set_cell(coordenadas, 0, tile)

	

func invertirFichaEnMapa(coordenadas):

	mapa.invertir_contenido_espacio(coordenadas)
	mapa.guardar()
	

func _input(event):
	if Input.is_action_just_pressed("inspeccionar"):
		var mouse_pos :Vector2i = get_global_mouse_position()

		var tile_mouse_pos = $Tablero.local_to_map(mouse_pos)

	if Input.is_action_just_pressed("play"):
		play = !play
	if Input.is_action_just_pressed("click"):
		var mouse_pos :Vector2i = get_global_mouse_position()

		var tile_mouse_pos = $Tablero.local_to_map(mouse_pos)

		invertirFichaEnMapa(tile_mouse_pos)
		colocarFichaEnTablero(tile_mouse_pos)

		
#capto el evento de click en el tablero

###necesito un mapa para trabajar mis posiciones!
### necesito guia de fichas para saber mis cualidades!

##opciones se le entregan a mostradorDeOpciones(opciones)
func normalizar_posicion(coordenadas):
	var coordenadas_iniciales = coordenadas
	if(coordenadas[0]<0):
		coordenadas[0] = tamañoMapa[0]-1
	if(coordenadas[1]<0):
		coordenadas[1] = tamañoMapa[1]-1
	if(coordenadas[0]>=tamañoMapa[0]):
		coordenadas[0] = 0
	if(coordenadas[1]>=tamañoMapa[1]):
		coordenadas[1] = 0
		
	
		
	return coordenadas
	
func contar_vivas_alrededor(casilla):
	var cantidad_vivas = 0

	
	
	
	if mapa.get_contenido_espacio(normalizar_posicion(Vector2i(casilla[0],casilla[1]-1))) == true: #arriba
		cantidad_vivas +=1
	if mapa.get_contenido_espacio(normalizar_posicion(Vector2i(casilla[0] -1,casilla[1]-1))) == true: #arriba izq
		cantidad_vivas +=1
	if mapa.get_contenido_espacio(normalizar_posicion(Vector2i(casilla[0] +1,casilla[1]-1))) == true: #arriba der
		cantidad_vivas +=1
	if mapa.get_contenido_espacio(normalizar_posicion(Vector2i(casilla[0]-1,casilla[1]))) == true: #izquierda
		cantidad_vivas +=1
	if mapa.get_contenido_espacio(normalizar_posicion(Vector2i(casilla[0]+1,casilla[1]))) == true: #derecha
		cantidad_vivas +=1
	if mapa.get_contenido_espacio(normalizar_posicion(Vector2i(casilla[0],casilla[1]+1))) == true: #abajo 
		cantidad_vivas +=1
	if mapa.get_contenido_espacio(normalizar_posicion(Vector2i(casilla[0] -1,casilla[1]+1))) == true: #abajo izquierda
		cantidad_vivas +=1
	if mapa.get_contenido_espacio(normalizar_posicion(Vector2i(casilla[0] +1,casilla[1]+1))) == true: # abajo derecha
		cantidad_vivas +=1

	return cantidad_vivas

func calculas_si_ficha_vive_o_muere(coordenadas):

	if mapa.get_contenido_espacio(coordenadas):
		if (contar_vivas_alrededor(coordenadas) == 2 || contar_vivas_alrededor(coordenadas) == 3):
			return true 
	else:
		if contar_vivas_alrededor(coordenadas) == 3:
			return true
	return false
		

func _on_timer_timeout() -> void:
	if play:
		mapa_buffer.espacios = mapa.espacios.duplicate()
		for x in range(tamañoMapa[0]):
			for y in range(tamañoMapa[1]):
				pass
				mapa_buffer.espacios[Vector2i(x,y)] = calculas_si_ficha_vive_o_muere(Vector2i(x,y))
		mapa.espacios = mapa_buffer.espacios.duplicate()
		mapa.guardar()
		for x in range(tamañoMapa[0]):
			for y in range(tamañoMapa[1]):

				colocarFichaEnTablero(Vector2i(x,y))
