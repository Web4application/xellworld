
>## 1. script.xess (Initialization Config)
This script typically defines the quality profiles for the upscaler.
```ini
# XeSS Configuration Script
[Upscaler]
Mode=UltraQuality      # Options: Performance, Balanced, Quality, UltraQuality
Sharpness=0.5          # Value between 0.0 and 1.0
ExposureMode=Auto      # Helps AI calculate HDR brightness
NetworkModel=XeSS_3.0  # Use the latest Multi-Frame Generation model
```
>## 2. `script.xell` (Latency Tuning)
This script manages the render queue to ensure the GPU doesn't fall behind the CPU.

```json
{
  "XeLL_Config": {
    "LowLatencyMode": "Ultra",
    "InputSamplingOffset": -2.0, // ms before frame start
    "BoostClock": true,          // Keeps GPU clocks high to finish frames faster
    "QueueDepth": 1             // Minimum lag (0-1 is ideal)
  }
}
```
>## 3. `scriptz.xr(OpenXR / WebXR Action Map)`
If you're using this for XR/Web4, it should map user inputs to visual actions.

```js
// XR Interaction Scriptconst actionMap = {
  "/user/hand/left/input/trigger": "SelectObject",
  "/user/hand/right/input/thumbstick": "Teleport",
  "renderScale": 1.5, // Native XR supersampling
  "reprojection": "MotionVector" // Links to XeSS motion data
};
```
## 4. `script.blf (Binary Logging Logic)`
Since .blf is a binary format, your "script" is actually the logger setup in your code to write the performance data.
```cpp
// Logic for generating the .blf logvoid CaptureFrameMetrics(int frameID) {
    LogWriter logger("script.blf");
    logger.WriteTimestamp();
    logger.WriteMetric("GPU_Frame_Time", GetGPUTime());
    logger.WriteMetric("XeSS_Upscale_Time", GetXeSSTime());
    logger.WriteMetric("Input_Lag_ms", GetXeLLLatency());
    logger.Close();
}
```
## How to use them in your repo:

   1. Place them in a /configs or /assets/scripts directory.
   2. Point your main application code to read these files on startup so you can change settings without recompiling your entire project.

>## src/template.pdf
```tex
\documentclass{article}
% main document, called main.tex
\usepackage{tikz}

\usetikzlibrary{external}
\tikzexternalize % activate

\begin{document}

\begin{tikzpicture} % will be written to 'main-figure0.pdf'
  \node {root}
    child {node {left}}
    child {node {right}
      child {node {child}}
      child {node {child}}
    };
\end{tikzpicture}

{
  \tikzsetfigurename{subset_}
  A simple image is \tikz \fill (0,0) circle(5pt);. % will be written to 'subset_0.pdf'

  \begin{tikzpicture} % will be written to 'subset_1.pdf'
     \draw[help lines] (0,0) grid (5,5);
  \end{tikzpicture}
}% here, the old file name will be restored:

\begin{tikzpicture} % will be written to 'main-figure1.pdf'
   \draw (0,0) -- (5,5);
\end{tikzpicture}
\end{document}
