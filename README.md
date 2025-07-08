# Amaris Consulting - App de Manejo de Fondos BTG

Una aplicación Flutter interactiva para el manejo de fondos de inversión (FPV/FIC) desarrollada como prueba técnica para Amaris Consulting.

## 📋 Descripción del Proyecto

Esta aplicación permite a los usuarios gestionar sus inversiones en fondos BTG de manera intuitiva y completa. Los usuarios pueden suscribirse a fondos, cancelar participaciones, consultar historial de transacciones y gestionar sus preferencias de notificación.

## ✨ Funcionalidades Implementadas

### 🎯 Requisitos Funcionales ✅ **100% Completos**

1. **✅ Visualizar lista de fondos disponibles**
   - Muestra los 5 fondos BTG configurados
   - Información detallada: nombre, categoría (FPV/FIC), monto mínimo
   - Estado de suscripción y método de notificación

2. **✅ Suscripción a fondos**
   - Validación automática del monto mínimo requerido
   - Verificación de saldo suficiente en wallet
   - Actualización inmediata del saldo disponible

3. **✅ Cancelación de participación**
   - Desuscripción de fondos con un clic
   - Actualización automática del saldo en wallet
   - Registro de transacción de cancelación

4. **✅ Historial de transacciones**
   - Vista completa de suscripciones y cancelaciones
   - Tabla ordenada por fecha (más reciente primero)
   - Información detallada: fondo, categoría, valor, saldo resultante

5. **✅ Selección de método de notificación**
   - Modal interactivo para elegir entre SMS y Email
   - Configuración individual por fondo o global
   - Persistencia de preferencias

6. **✅ Mensajes de error apropiados**
   - Notificaciones cuando no hay saldo suficiente
   - Feedback visual claro para el usuario
   - Manejo de estados de error

### 🛠️ Requisitos Técnicos ⚠️ **85% Completos**

#### ✅ **Implementado:**
- **Flutter**: Versión 3.8.1 con Material Design
- **BLoC**: Patrón completo para manejo de estado
- **Diseño responsivo**: Breakpoints configurables para diferentes dispositivos
- **API simulada**: DAL (Data Access Layer) con mocks locales
- **Manejo de errores**: Estados de error y loading apropiados
- **Código limpio**: Estructura organizada y comentada
- **Pruebas unitarias**: Test placeholder incluido y test de prueba

#### ❌ **Pendiente:**
- **Validaciones de formularios**: No hay forms de entrada de datos

## 🏗️ Arquitectura del Proyecto

```
lib/
├── core/
│   ├── config/           # Configuración de entorno
│   ├── models/           # Entidades de datos
│   └── tools/            # Herramientas utilitarias
├── dal/                  # Data Access Layer
│   ├── fund/            # Gestión de fondos
│   ├── transaction/     # Gestión de transacciones
│   └── wallet/          # Gestión de wallet
├── features/
│   ├── common/          # Widgets compartidos
│   └── welcome/         # Pantalla principal
│       ├── bloc/        # Lógica de estado BLoC
│       ├── page/        # Página principal
│       └── widget/      # Widgets específicos
```

## 💰 Fondos Disponibles

La aplicación incluye 5 fondos BTG preconfigurados:

| ID | Nombre | Monto Mínimo | Categoría |
|---|---|---|---|
| 1 | FPV_BTG_PACTUAL_RECAUDADORA | $75,000 COP | FPV |
| 2 | FPV_BTG_PACTUAL_ECOPETROL | $125,000 COP | FPV |
| 3 | DEUDAPRIVADA | $50,000 COP | FIC |
| 4 | FDO-ACCIONES | $250,000 COP | FIC |
| 5 | FPV_BTG_PACTUAL_DINAMICA | $100,000 COP | FPV |

**Saldo inicial del usuario**: $500,000 COP

## 🚀 Instalación y Ejecución

### Requisitos Previos
- Flutter SDK ^3.8.1
- Dart SDK
- Android Studio / VS Code
- Emulador Android o dispositivo físico

### Pasos para ejecutar:

1. **Clonar el repositorio**
```bash
git clone [https://github.com/codebryanc/Amaris_consulting]
cd amaris_consulting
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Ejecutar la aplicación**
```bash
flutter run
```

## 📱 Capturas de Pantalla

### Pantalla Principal - Lista de Fondos
- Vista de todos los fondos disponibles
- Información de suscripción y montos
- Botones de suscripción/cancelación

### Historial de Transacciones
- Tabla con todas las operaciones realizadas
- Información detallada de cada transacción
- Ordenamiento por fecha descendente

### Selección de Notificaciones
- Modal para elegir método de notificación
- Opciones: SMS y Email
- Configuración individual o global

## 🎨 Características de UI/UX

- **Diseño responsivo**: Adaptable a diferentes tamaños de pantalla
- **Colores intuitivos**: Verde para fondos suscritos, rojo para no suscritos
- **Feedback visual**: Loading states y notificaciones claras
- **Navegación fluida**: Toggle entre lista de fondos e historial
- **Accesibilidad**: Textos legibles y contraste apropiado

## 🔧 Tecnologías Utilizadas

- **Flutter**: Framework principal
- **BLoC**: Manejo de estado
- **Material Design**: Sistema de diseño
- **Singleton Pattern**: Para DAL
- **Repository Pattern**: Para acceso a datos

## 📊 Estado de Completitud

- **Funcionalidades**: ✅ 100% (6/6)
- **Requisitos Técnicos**: ⚠️ 85% (7/8)
- **Extras**: ⚠️ 25% (1/4)
- **Completitud General**: **85%**

## 🔮 Mejoras Futuras

- [ ] Implementar pruebas unitarias completas
- [ ] Agregar navegación multi-pantalla
- [ ] Crear formularios con validaciones
- [ ] Integrar HTTP client real
- [ ] Implementar persistencia de datos
- [ ] Agregar internacionalización
- [ ] Mejorar componentes reutilizables
- [ ] Mejorar el log de errores + instrumentación

## 👨‍💻 Desarrollador Bryan Cubillos

Desarrollado como prueba técnica para Amaris Consulting - Posición de Ingeniero de Desarrollo Flutter.

---

*Esta aplicación demuestra competencias en Flutter, BLoC, diseño responsivo, y manejo de estado para aplicaciones financieras.*
