# ProyectoVLSI – IE0411 Diseño VLSI

Implementación del flujo de **síntesis y diseño físico** de un **SoC Amber de dos núcleos (ARM/Amber)**. El proyecto usa **Synopsys Design Compiler (dc_shell)** y **IC Compiler II (icc2_shell)**, automatizados con **scripts Tcl**, para ir desde **síntesis lógica** hasta **ruteo y ECO post‑ruteo**, cumpliendo métricas de **temporización, utilización e IR‑drop**.

---

## Estructura del repositorio

```
└── ProyectoVLSI
    ├── WORK        # Archivos de ejecución, logs y resultados intermedios
    ├── rtl         # Código RTL del Amber SoC (CPU, memoria y periféricos)
    └── scripts     # Scripts Tcl para dc_shell e icc2_shell
```

**Scripts principales**

```
./scripts/dc/
  ├─ dc.tcl            # Flujo de síntesis lógica (DC)
  ├─ constraints.sdc   # Restricciones de temporización I/O y clocks
  └─ rtl.list          # Lista de archivos RTL a sintetizar

./scripts/icc/
  ├─ icc.tcl           # Orquestador del flujo físico (ICC2)
  ├─ common_setup.tcl  # Setup de librerías, tech y MMMC
  ├─ floorplan.tcl     # Floorplan y red de potencia
  ├─ placement.tcl     # Posicionamiento (global/detallado)
  ├─ cts.tcl           # Síntesis del árbol de reloj
  ├─ routing.tcl       # Enrutamiento global/detallado
  ├─ powerplan.tcl     # Straps y anillos de potencia
  └─ dump_results.tcl  # Recolección de reports post‑ruteo
```

---

## Requisitos

* Synopsys **dc_shell** y **icc2_shell** con licencias disponibles.
* Librerías de tecnología y **MMMC** configuradas en los scripts.
* Entorno Linux con *shell* compatible y permisos de ejecución.

---

## Ejecución rápida

**1) Síntesis lógica (DC)**

```tcl
# Desde dc_shell
source ./scripts/dc/dc.tcl
```

**2) Implementación física (ICC2)**

```tcl
# Desde icc2_shell
source ./scripts/icc/icc.tcl
```

> Los artefactos (netlists, DEF, SPEF, GDS, reports) y logs se depositan en `WORK/` o en las rutas definidas por los scripts.

---

## Resultados esperados

* **Temporización**: 0 violaciones de setup/hold en la vista objetivo.
* **IR‑drop** dentro de los márgenes definidos por la tecnología/curso.
* **Utilización** adecuada (típ. >60%) y ruteabilidad completa.
* Reportes finales de **STA**, **potencia** e **IR‑drop** post‑ruteo.

---

## Notas

* No modificar el RTL del *Amber SoC*.
* Mantener y documentar cualquier cambio fuera de los bloques marcados como “NO MODIFICAR” en los scripts.

---

## Créditos

Proyecto académico del curso **IE0411 – Diseño VLSI**.
