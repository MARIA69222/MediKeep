const Medicamento = require("../Models/Medicamento");
const MedicamentoService = require("../Services/MedicamentoService");
const medicamentoService = new MedicamentoService();

// Obtener todos los medicamentos
const obtenerMedicamentos = async (req, res) => {
  try {
    return res.status(200).json(await medicamentoService.getMedicamentos());
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Obtener un medicamento por ID
const obtenerMedicamentoPorId = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(200).json(await medicamentoService.getMedicamentoId(id));
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Crear un nuevo medicamento
const crearMedicamento = async (req, res) => {
  try {
    const nuevoMedicamento = Medicamento.fromJson(req.body);
    return res.status(201).json(await medicamentoService.creacionMedicamento(nuevoMedicamento));
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

