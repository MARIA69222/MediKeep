const UsuarioService = require("../Services/UsuarioService");
const Usuario = require("../Models/Usuario");
const { ObjectId } = require("mongodb");

describe("Pruebas reales de UsuarioService", () => {
  let usuarioService;
  let idInsertado;

  beforeAll(() => {
    usuarioService = new UsuarioService();
  });

  // Crear usuario
  test("Debe crear un usuario nuevo", async () => {
    const nuevoUsuario = Usuario.fromJson({
      nombre: "Prueba Jest",
      apellido: "Testing",
      correo: "jest_prueba@example.com",
      contrasena: "123456",
      edad: 30,
      telefono: "1234567890",
      fechaNacimiento: "1993-01-01",
      tipoDocumento: "cc",
      numeroDocumento: "123456789",
    });

    const resultado = await usuarioService.creacionUsuario(nuevoUsuario);

    expect(resultado).toHaveProperty("id"); // ahora es "id"
    expect(resultado.nombre).toBe("Prueba Jest");
    idInsertado = resultado.id; //  guardamos "id"
  });

  // Obtener usuario por ID
  test("Debe obtener un usuario por ID", async () => {
    const usuario = await usuarioService.getUsuarioId(idInsertado);
    expect(usuario).not.toBeNull();
    expect(usuario._id.toString()).toBe(idInsertado.toString());
  });

  // Listar usuarios
  test("Debe listar todos los usuarios", async () => {
    const usuarios = await usuarioService.getUsuarios();
    expect(Array.isArray(usuarios)).toBe(true);
    expect(usuarios.length).toBeGreaterThan(0);
  });

  // Eliminar usuario de prueba
  test("Debe eliminar el usuario de prueba", async () => {
    const conexion = await usuarioService.db.connectDB();
    const coleccion = conexion.collection("usuarios");

    const resultado = await coleccion.deleteOne({ _id: new ObjectId(idInsertado) });
    expect(resultado.deletedCount).toBe(1);
  });
});
