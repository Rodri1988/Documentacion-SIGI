# S.I.G.I. - Sistema Inteligente de Gestión de Incendios 🏢🔥

### 🎓 Proyecto Académico - Ingeniería en Informática (Duoc UC)
* **Asignatura:** Desarrollo Fullstack III (DSY1106)
* **Caso de Estudio:** Municipalidad Valle del Sol
* **Integrantes:** Emilio Jaramillo, Hawk Durant, Rodrigo Candia
* **Fecha de Entrega:** Junio 2026

---

## 📄 Documentación Oficial (Entregables de la Rúbrica)
Toda la documentación y los informes requeridos para la **Evaluación Parcial N°3** se encuentran organizados en formato PDF dentro de la carpeta `/documentos` de este repositorio:

1. **[Informe de Arquitectura y Persistencia](./documentos/1_Informe_Arquitectura_y_Persistencia.pdf):** 
   * Detalla la propuesta de solución basada en una **Arquitectura de Microservicios** utilizando Spring Boot.
   * Explica el rol fundamental del **API Gateway** como fachada (BFF) para el enrutamiento y la seguridad perimetral mediante JWT.
   * Describe el descubrimiento dinámico de servicios usando **Netflix Eureka**.
   * Justifica la implementación de la persistencia de datos bajo el enfoque *Database per Service* utilizando **Spring Data JPA**.

2. **[Informe de Pruebas Unitarias y Calidad](./documentos/2_Informe_Pruebas_Unitarias.pdf):** 
   * Respaldo completo de las pruebas unitarias automatizadas desarrolladas sobre la capa lógica (`@Service`) mediante **JUnit 5 y Mockito**.
   * Gráficos y reportes de cobertura de código generados por herramientas de testing (JaCoCo), demostrando una **cobertura superior al 60% mínimo** exigido por la rúbrica.

3. **[Especificación de la API REST](./documentos/3_Especificacion_API_REST.pdf):** 
   * Contrato técnico y documentación detallada de todos los endpoints expuestos a través del Gateway (Puerto 8080).
   * Incluye ejemplos reales de peticiones (payloads JSON con las cabeceras de autorización de identidad) y respuestas del sistema.

---

## 🚀 Arquitectura y Componentes del Sistema

El ecosistema de software está diseñado para mitigar fallos mediante resiliencia (Resilience4j para el servicio de geocodificación con OpenCage) y se compone de los siguientes módulos estructurados:

* 💻 `/sigi-frontend`: Interfaz de usuario web desarrollada sobre un framework moderno, empaquetada bajo el estándar NPM (con su archivo `package.json` y scripts de ejecución).
* ⚙️ `/sigi-backend`: Solución backend modularizada que aloja los microservicios core distribuidos en los puertos 8080 al 8086 (`servicio-usuario`, `servicio-reporte`, `servicio-ubicacion`, `servicio-emergencia`, `servicio-recurso`, y `servicio-notificacion`).

---

## 🛠️ Instrucciones de Despliegue Local (Demo)

El proyecto incluye soporte para contenedores, permitiendo levantar todo el mapa arquitectónico de forma local:

1. Clonar el repositorio:
```bash
   git clone [https://github.com/Rodri1988/Documentacion-SIGI.git](https://github.com/Rodri1988/Documentacion-SIGI.git)