const express = require("express");
const app = express();
const port = 3001;
const rutas = require("./Routes/index.routes.js");
const cors = require('cors');

// middleware primero
app.use(express.json());
const corsOptions = {
    origin: 'http://localhost:49745', // Replace with your frontend origin
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true, // Allow cookies and authentication headers
    allowedHeaders: ['Content-Type', 'Authorization'], // Specify allowed headers
    optionsSuccessStatus: 204 // Set a 204 No Content status for successful OPTIONS responses
};
app.use(cors(corsOptions));
// rutas
app.use("/api", (req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    next();
}, rutas);

// activar el servidor
app.listen(port, () => console.log(`Servidor corriendo en el puerto ${port}`));
