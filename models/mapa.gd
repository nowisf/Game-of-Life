class_name Mapa
extends Resource

@export var espacios: Dictionary

func invertir_contenido_espacio(coordenadas):
	if !espacios.has(coordenadas):
		espacios[coordenadas] = true
	else:
		espacios[coordenadas] = !espacios[coordenadas]

	guardar()

func get_contenido_espacio(coordenadas):
	
	if !(espacios.has(coordenadas)):
		espacios[coordenadas] = false
	return espacios[coordenadas]
	
func set_contenido_espacio(coordenadas, contenido):
	espacios[coordenadas] = contenido
	guardar()
	
func guardar():
	ResourceSaver.save(self, self.get_path())
	
