/* ================================================================================
 * Entries
 * ===============================================================================*/

// Assets
import.meta.glob(['../images/**', '../fonts/**']);

/* ================================================================================
 * Import Scripts
 * ===============================================================================*/

import Alpine from "alpinejs";
import persist from '@alpinejs/persist'
import collapse from '@alpinejs/collapse'



// General for App
import "./general/collapse";
import "./general/fields";
import "./general/inmutable";
import "./general/loader";
import "./general/upload";

import "./bootstrap";

/* ================================================================================
 * Importar Modulos Javascript
 * ===============================================================================*/





/* ================================================================================
 * Call Scripts / Functions
 * ===============================================================================*/

Alpine.plugin(persist)
Alpine.plugin(collapse)
window.Alpine = Alpine;
Alpine.start();
