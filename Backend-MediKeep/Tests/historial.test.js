const HistorialService = require("../Services/HistorialService");
const Historial = require("../Models/Historial");

describe("Pruebas reales de HistorialService", () => {
  let historialService;
  let idInsertado;

  beforeAll(() => {
    historialService = new HistorialService();
  });

  // Crear historial
  test("Debe crear un historial nuevo", async () => {
    const nuevoHistorial = new Historial(
      "68d5c6dc30c93d1adaaf11d5", // idUsuario
      ["68e060d4a56733f1510ede49"], // idMedicamentos
      new Date(),
      "tomado"
    );

    const resultado = await historialService.crearHistorial(nuevoHistorial);

    expect(resultado).toHaveProperty("_id");
    expect(resultado.estado).toBe("tomado");

    idInsertado = resultado._id; // Guardamos el ID para siguientes pruebas
  });

  // Obtener historial por ID
  test("Debe obtener un historial por ID", async () => {
    const historial = await historialService.obtenerHistorialPorId(idInsertado);

    expect(historial).not.toBeNull();
    expect(historial._id.toString()).toBe(idInsertado.toString());
    expect(historial.estado).toBe("tomado");
  });

  // Listar historiales
  test("Debe listar todos los historiales", async () => {
    const historiales = await historialService.obtenerHistoriales();

    expect(Array.isArray(historiales)).toBe(true);
    expect(historiales.length).toBeGreaterThan(0);
  });

  // Actualizar historial
  test("Debe actualizar un historial existente", async () => {
    const resultado = await historialService.actualizarHistorial(idInsertado, {
      estado: "omitido",
    });

    expect(resultado.modifiedCount).toBe(1);

    const actualizado = await historialService.obtenerHistorialPorId(idInsertado);
    expect(actualizado.estado).toBe("omitido");
  });

  // Eliminar historial
  test("Debe eliminar el historial de prueba", async () => {
    const resultado = await historialService.eliminarHistorial(idInsertado);

    expect(resultado.deletedCount).toBe(1);
  });
});

