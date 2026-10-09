cd ~/Documents/Dial_llama

export RUST_LOG=info

# 保留两请求流水线
export DIAL_PIPELINE_DEPTH=2
export DIAL_PIPELINE_TRACE=1

# Vision 用完后释放，给 MLP RKNN 腾内存
export QWEN3VL_KEEP_VISION_RKNN=0

# MLP RKNN 第一次 decode 时再加载，避免启动时同时占很多内存
export QWEN3VL_MLP_RKNN_LAZY=1

# 第一次测试建议打开，可以确认每层是否真的走了 MLP RKNN
export QWEN3VL_PROFILE_LOCAL=1

./target/release/dial-cli \
  --mode master \
  --api 0.0.0.0:8082 \
  --cpu \
  --model /home/firefly/Documents/Qwen3-VL-8B-Instruct \
  --topology ./topology_2dev.yml \
  --vision-rknn /home/firefly/Documents/Dial_llama/qwen3_vl_8b_vision_448_deepstack_fp16.rknn \
  --vision-fixed-side 448 \
  --text-mlp-rknn-dir /home/firefly/Documents/Dial_llama/transmodel/mlp_down_rknn_l00_l03 \
  --sample-len 128