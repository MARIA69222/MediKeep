const Medicamento = require("../Models/Medicamento");
const MedicamentoService = require("../Services/MedicamentoService");
const { ObjectId } = require("mongodb");
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
    delete datosActualizados._id; // nunca actualizamos el _id

    const conexion = await medicamentoService.db.connectDB();
    const coleccion = conexion.collection("medicamentos");

    const resultado = await coleccion.findOneAndUpdate(
      { _id: new ObjectId(id) },
      { $set: datosActualizados },
      { returnDocument: "after" }
    );
    if (resultado === null) {
      return res.status(404).json({ message: "Medicamento no encontrado" });
    }

    return res.status(200).json({
      message: "Medicamento actualizado con éxito",
      medicamento: resultado
    });
  } catch (error) {
    return res.status(500).json({ message: "Error al actualizar medicamento", error: error.message });
  }
}

// Eliminar un medicamento
const eliminarMedicamento = async (req, res) => {
  try {
    const { id } = req.params;

    const conexion = await medicamentoService.db.connectDB();
    const coleccion = conexion.collection("medicamentos");

    const resultado = await coleccion.deleteOne({ _id: new ObjectId(id) });

    if (resultado.deletedCount === 0) {
      return res.status(404).json({ message: "Medicamento no encontrado" });
    }

    return res.status(200).json({ message: "Medicamento eliminado con éxito" });
  } catch (error) {
    return res.status(500).json({ message: "Error al eliminar medicamento", error: error.message });
  }
};
// Obtener medicamentos por usuario
const obtenerMedicamentosPorUsuario = async (req, res) => {
  try {
    const { userId } = req.params; // recibimos el id del usuario
    const conexion = await medicamentoService.db.connectDB();
    const coleccion = conexion.collection("medicamentos");

    // Filtramos por idUsuario
    const medicamentos = await coleccion.find({ idUsuario: userId }).toArray();

    return res.status(200).json(medicamentos);
  } catch (error) {
    return res.status(500).json({ message: "Error al obtener medicamentos del usuario", error: error.message });
  }
};


module.exports = {
  obtenerMedicamentos,
  obtenerMedicamentoPorId,
  crearMedicamento,
  actualizarMedicamento,
  eliminarMedicamento,
  obtenerMedicamentosPorUsuario
};

