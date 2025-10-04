const MedicamentoService = require("../Services/MedicamentoService");
const Medicamento = require("../Models/Medicamento");
const { ObjectId } = require("mongodb");

describe("Pruebas reales de MedicamentoService", () => {
  let medicamentoService;
  let idInsertado;

  beforeAll(() => {
    medicamentoService = new MedicamentoService();
  });

  // Crear medicamento
  test("Debe crear un medicamento nuevo", async () => {
    const nuevoMedicamento = new Medicamento(
      "68d5c6dc30c93d1adaaf11d5", 
      "Paracetamol",
      "Analgésico y antipirético",
      "500mg",
      "Cada 8 horas",
      "08:00",
      "7 días",
      false,
      "activo"
    );

    const resultado = await medicamentoService.creacionMedicamento(nuevoMedicamento);

    expect(resultado).toHaveProperty("id");   //  cambiamos a "id"
    expect(resultado.nombre).toBe("Paracetamol");
    idInsertado = resultado.id; //  usamos id, no idMongo
  });

  // Obtener medicamento por ID
  test("Debe obtener un medicamento por ID", async () => {
    const medicamento = await medicamentoService.getMedicamentoId(idInsertado);
    expect(medicamento).not.toBeNull();
    expect(medicamento._id.toString()).toBe(idInsertado.toString());
    expect(medicamento.nombre).toBe("Paracetamol");
  });

  // Listar medicamentos
  test("Debe listar todos los medicamentos", async () => {
    const medicamentos = await medicamentoService.getMedicamentos();
    expect(Array.isArray(medicamentos)).toBe(true);
    expect(medicamentos.length).toBeGreaterThan(0);
  });

  // Actualizar medicamento
  test("Debe actualizar un medicamento existente", async () => {
    const resultado = await medicamentoService.actualizarMedicamento(
      idInsertado,
      { frecuencia: "Cada 12 horas" }
    );

    expect(resultado.modifiedCount).toBe(1);

    const actualizado = await medicamentoService.getMedicamentoId(idInsertado);
    expect(actualizado.frecuencia).toBe("Cada 12 horas");
  });

  // Eliminar medicamento
  test("Debe eliminar el medicamento de prueba", async () => {
    const resultado = await medicamentoService.eliminarMedicamento(idInsertado);
    expect(resultado.deletedCount).toBe(1);
  });
});
