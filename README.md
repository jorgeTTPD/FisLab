# 🔬 FisLab

*Physics laboratory app built with **Delphi 12** (FireMonkey, multi-device: Windows + Android).*
**Aplicación de laboratorio de física hecha en Delphi 12 (FireMonkey, multi-dispositivo: Windows + Android).**

![Captura 1](Captura%20de%20pantalla%202026-08-12%20181731.png)

## ⚠️ Estado del proyecto · *Project status*

> ⚠️ **Proyecto incompleto** · *Incomplete project*
>
> No hay ejecutable disponible, la APK es inestable y el último desarrollo se hizo en Windows.
> Fue un buen intento, pero quedó sin terminar.
>
> *No executable is available, the APK is unstable, and the last development was done on Windows.
> It was a good attempt, but it remains unfinished.*

## 📖 ¿Qué es? · *What is it?*

FisLab es una herramienta de laboratorio para procesar **mediciones físicas** y sus **errores**: calcula el valor medio, la desviación estándar, el error promedio y el error de medición, formatea resultados en notación científica `(valor ± error) [unidad]; %error` y grafica la distribución de Gauss.

*FisLab is a lab tool for processing **physical measurements** and their **errors**: it computes the mean value, standard deviation, average error and measurement error, formats results in scientific notation `(value ± error) [unit]; %error`, and plots the Gaussian distribution.*

## ✨ Funcionalidades · *Features*

- 📏 **Medición directa** (`PMedidaDirectaU`): formato `(valor ± error) [unidad]; %error` con redondeo correcto según el error · *Direct measurement with proper error-based rounding*
- 📊 **Serie de mediciones directas** (`PSerieDirectas`): media, desviación estándar, error promedio y error de medición · *Direct measurement series: mean, std. deviation, average & measurement error*
- 🔄 **Serie indirecta** (`PSerieIndirectas`): propagación de errores en magnitudes indirectas · *Indirect series: error propagation*
- 🧮 **Calculadora estadística** (`UCalculadora`): media, desviación estándar muestral, error promedio, error de medición · *Statistical calculator*
- 📁 **Carga de datos desde TXT** (`ULectorTXT` + tokenizador de columnas) · *Load data from TXT files*
- 📈 **Gráfica de Gauss** (`GraficoUnit`) con TChart · *Gaussian plot with TChart*
- 🔊 Recursos de audio embebidos (multiplataforma) · *Embedded audio resources (cross-platform)*
- 📱 **Multi-dispositivo FMX**: Windows, Android (tablets/phones), con manifest e iconos iOS · *Multi-device FMX: Windows, Android (tablets/phones), iOS manifest & icons*

## 🛠️ Compilación · *Build*

- **Delphi 12** (RAD Studio) con FireMonkey (FMX)
- Abre `FisLab.dpr` y compila para la plataforma deseada (Windows/Android)
- Las variantes `.fmx` por dispositivo (`.LgXhdpiTb`, `.NmXhdpiPh`, `.Moto360`, etc.) se usan automáticamente según el objetivo · *Device-specific `.fmx` variants are used automatically per target*

## 📂 Estructura · *Structure*

| Unidad · *Unit* | Propósito · *Purpose* |
|---|---|
| `Pmain.pas` | Formulario principal · *Main form* |
| `PMedidaDirectaU.pas` | Medición directa · *Direct measurement* |
| `PSerieDirectas.pas` / `PSerieIndirectas.pas` | Series directas e indirectas · *Direct & indirect series* |
| `UCalculadora.pas` | Estadística: media, desviación, errores · *Statistics* |
| `PMedidor.pas` | Formato de medición `(v ± e) [u]; %` · *Measurement formatting* |
| `ULectorTXT.pas` / `PTokenizadorColumnas.pas` | Lectura de datos desde TXT · *TXT data loading* |
| `GraficoUnit.pas` | Gráfica de Gauss · *Gaussian plot* |

## 🖼️ Capturas · *Screenshots*

![Captura 2](Captura%20de%20pantalla%202026-08-12%20181759.png)
