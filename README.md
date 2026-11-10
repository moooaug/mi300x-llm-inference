# MI300X LLM Inference

Run open-source large language models on a single **AMD Instinct MI300X** (192 GB HBM3) with **vLLM on ROCm** — built for the AMD AI Developer Program / AMD Developer Cloud $100 credit.

## Goal

Test whether a single MI300X can serve 70B-class models in BF16 without model sharding, and measure throughput, latency, memory use and output quality for local deployment.

## Hardware

- 1x AMD Instinct MI300X — 192 GB HBM3, 5.3 TB/s memory bandwidth
- 20 vCPUs, 240 GB system RAM (AMD Developer Cloud small configuration)
- ROCm, Ubuntu, Docker, vLLM (OpenAI-compatible API server)

## Models

| Model | Size | Fits in 192 GB? |
|---|---|---|
| Qwen3-70B / Qwen 70B | 70B, BF16 (~140 GB) | Yes, single GPU |
| Llama-3.3-70B | 70B, BF16 (~140 GB) | Yes, single GPU |
| MiniMax-M2.1 | 139B, FP8 | Yes, single GPU |

## Quick start

```bash
# On the MI300X instance (ROCm image)
./scripts/run_vllm.sh Qwen/Qwen3-70B

# In another terminal
curl http://localhost:8000/v1/models
curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model": "Qwen/Qwen3-70B", "messages": [{"role": "user", "content": "Hello, what can you do?"}]}'
```

## What I measure

- Time to first token and tokens/second at batch sizes 1 / 8 / 32
- Peak GPU memory (HBM3) during load and generation
- Output quality on a small set of reasoning, coding and summarisation prompts
- Cost per 1k tokens at the Developer Cloud rate (~$2/GPU-hour)

## Status

- [x] Project plan and hardware target defined
- [ ] MI300X instance provisioned via AMD Developer Cloud credit
- [ ] Qwen 70B served with vLLM, first benchmark run
- [ ] Results written up in `benchmarks.md`

## Why MI300X

192 GB on one card means a 70B model in BF16 fits without tensor parallelism across GPUs — simpler serving, no cross-GPU communication, and room for a long context window.
