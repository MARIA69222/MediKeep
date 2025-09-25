const Medicamento = require("../Models/Medicamento");
const MedicamentoService = require("../Services/MedicamentoService.js");
const medicamentoService = new MedicamentoService();

// Obtener todos los medicamentos
const obtenerMedicamentos = async (req, res) => {
  try {
    return res.status(501).json({ message: "No implementado: obtenerMedicamentos" });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Obtener un medicamento por ID
const obtenerMedicamentoPorId = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(200).json(await medicamentoService.getMedicamentoId(id));
    // return res.status(501).json({ message: "No implementado: obtenerMedicamentoPorId", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Crear un nuevo medicamento
const crearMedicamento = async (req, res) => {
  try {
    const datos = req.body;
    await medicamentoService.creacionMedicamento(datos);
    return res.status(201).json({ message: "No implementado: crearMedicamento" });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Actualizar un medicamento
const actualizarMedicamento = async (req, res) => {
  try {
    const { id } = req.params;
    const datosActualizados = req.body;
    return res.status(501).json({ message: "No implementado: actualizarMedicamento", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Eliminar un medicamento
const eliminarMedicamento = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(501).json({ message: "No implementado: eliminarMedicamento", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

module.exports = {
  obtenerMedicamentos,
  obtenerMedicamentoPorId,
  crearMedicamento,
  actualizarMedicamento,
  eliminarMedicamento,
};
