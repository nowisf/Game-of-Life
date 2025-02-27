# Game-of-Life
Juego de la vida (con las reglas de su creador John Horton Conway) pero con espacio limitado y casillas que cruzan los limites horizontales o verticales entre si.

![image](https://github.com/user-attachments/assets/566bc11c-2df0-4d45-bdf4-ad16f93193cb)


## Controles
Click: Invierte el estado <vida|muerte> de una casilla.


Espacio: Activa o desactiva el procesamiento del tiempo.

## Para utlizarlo
utilizar Godot 4.x.x en adelante.

Se puede modificar la propiedad "wait time" de timer desde godot para cambiar la velocidad de cambio
![image](https://github.com/user-attachments/assets/d0f8b93c-9052-4266-b599-fdef3ae68f32)

Se pueden modificar las dimensiones del tablero con la propiedad expuesta "tamaño de mapa" de main 
![image](https://github.com/user-attachments/assets/1b09af8c-a9e5-4650-8e34-be1d0d3f6bea)

### Futuros cambios
[] Crear configuracion dentro del juego para modificar:
  [] Dimensiones
  [] Velocidad de procesamiento
  [] Si el mapa usara Limites portal o Sin limites
