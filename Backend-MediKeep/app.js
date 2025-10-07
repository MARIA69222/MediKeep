const express = require("express");
const app = express();
const port = 3001;
const rutas = require("./Routes/index.routes.js");
const cors = require('cors');

// middleware primero
app.use(express.json());
const corsOptions = {
    origin: '*', 
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS',
    credentials: true, 
    allowedHeaders: ['Content-Type', 'Authorization','Origin', 'X-Requested-With', 'Accept','Referer'], 
    optionsSuccessStatus: 204 
};
app.use(cors(corsOptions));
// rutas

app.use("/api", rutas);
/*app.use("/api", (req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept,Referer");
    //res.header("Access-Control-Allow-Headers", "*");
    res.header("Access-Control-Allow-Methods", 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS');
    next();
}, rutas);*/

// activar el servidor
app.listen(port, () => console.log(`Servidor corriendo en el puerto ${port}`));
