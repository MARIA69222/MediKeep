// Diálogo personalizado para mostrar mensajes de éxito.
import 'package:flutter/material.dart';
class SuccessDialog extends StatelessWidget {
  // Propiedad: título del diálogo.
  // final: indica que la variable es inmutable después
  // de ser asignada en el constructor.
  final String title;

  // Propiedad: mensaje descriptivo debajo del título.
  final String message;

  // Propiedad opcional: callback que se ejecutará al pulsar "Aceptar".
  // VoidCallback es un typedef de Flutter que equivale a: void Function()
  // Es 'nullable' porque no siempre lo necesitamos.
  final VoidCallback? onAccept;

  // Constructor: recibe las propiedades necesarias.
  // - super.key: clave opcional que ayuda a Flutter a identificar widgets en el árbol.
  // - required: obliga a pasar title y message al crear la instancia.
  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    this.onAccept,
  });

  // build: método que describe la UI del widget.
  @override
  Widget build(BuildContext context) {
    // Dialog es un widget de Flutter que muestra una ventana modal.
    return Dialog(
      // shape: define la forma del contenedor (aquí esquinas redondeadas).
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // Padding: agrega espacio interno alrededor del contenido.
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        // Column organiza widgets verticalmente.
        child: Column(
          // mainAxisSize.min hace que la columna ocupe sólo el espacio que necesita.
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icono verde dentro de un círculo — indicativo de éxito.
            Container(
              // decoration: estilo del contenedor.
              decoration: const BoxDecoration(
                color: Color(0xFFE6F4EA), // fondo verde muy claro
                shape: BoxShape.circle, // hace que el contenedor sea circular
              ),
              padding: const EdgeInsets.all(16), // espacio interior
              child: const Icon(
                Icons.check, // icono de check ✔
                color: Color(0xFF2E7D32), // color verde oscuro para el check
                size: 40, // tamaño del icono
              ),
            ),

            const SizedBox(height: 16), // espacio vertical

            // Título: texto grande y en negrita
            Text(
              title,
              textAlign: TextAlign.center, // centra el texto horizontalmente
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8), // espacio vertical

            // Mensaje descriptivo
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 20), // espacio vertical

            // Botón "Aceptar"
            SizedBox(
              width: 120, // ancho fijo del botón (consistencia visual)
              child: ElevatedButton(
                // onPressed: función que se ejecuta al pulsar el botón.
                // Aquí cerramos el diálogo primero (Navigator.pop) y luego
                // ejecutamos onAccept si fue provisto.
                onPressed: () {
                  // Navigator.pop: cierra la ruta superior del Navigator,
                  // aquí cierra este diálogo modal.
                  Navigator.pop(context);

                  // Si el callback onAccept existe, lo ejecutamos.
                  // El operador '!' llama la función; comprobamos null antes.
                  if (onAccept != null) {
                    onAccept!();
                  }
                },
                // style: personaliza la apariencia del botón.
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF33A06F), // verde botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                // child: contenido del botón (texto).
                child: const Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

