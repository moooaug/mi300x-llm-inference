#!/bin/bash
# Launch vLLM (OpenAI-compatible API) on a single AMD Instinct MI300X with ROCm.
# Usage: ./scripts/run_vllm.sh Qwen/Qwen3-70B
set -euo pipefail
MODEL="${1:-Qwen/Qwen3-70B}"
echo "Starting vLLM for $MODEL on MI300X (ROCm)..."
python3 -m vllm.entrypoints.openai.api_server \
  --model "$MODEL" \
  --dtype bfloat16 \
  --max-model-len 8192 \
  --gpu-memory-utilization 0.92 \
  --host 0.0.0.0 --port 8000
