#!/bin/bash
# xellworld Auto-Deploy Script

echo "🚀 Building WebGPU/WebXR Application..."
npm run build

echo "🛠 Copying Intel binaries (XeSS/XeLL) to dist..."
cp -r native/bin dist/

echo "📤 Deploying to web4application.github.io/xellworld/..."
git add .
git commit -m "Web4: Performance update with new Bith.ai worker logic"
git push origin main

echo "✅ Deployment Successful!"
